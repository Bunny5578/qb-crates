
local requestedtreasure = {}
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('qb-crates:found')
AddEventHandler('qb-crates:found', function(name)
	local source = source
  local xPlayer = QBCore.Functions.GetPlayer(source)
  local identifier = QBCore.Functions.GetIdentifier(source, 'license')
  local playerName = xPlayer.PlayerData.charinfo.firstname.." "..xPlayer.PlayerData.charinfo.lastname

  --Insert the player and the name of the found crate into the database
  --To make sure that the player can't open it again
  MySQL.Async.execute(
    'INSERT INTO treasure (identifier, treasurename) VALUES (@identifier, @name)',
    {
      ['@identifier'] = identifier,
      ['@name']   = name,
    }
  )

 

  --Delete any previously found crates
  for i=1, #requestedtreasure, 1 do
    requestedtreasure[i]=nil
  end

  --Set up the contents of the new crate
  for k,v in pairs(Config.Treasure) do
    if v.Name == name then
      table.insert(requestedtreasure, {
        name = v.Name,
        money = v.Money,
        items = v.Items,
        weapons = v.Weapons,
      })
    end
  end

  --Should only happen once but you never know :D
  for i=1, #requestedtreasure, 1 do
    --Give money
    if requestedtreasure[i].money ~= 0 then
      if Config.IsMoneyDirtyMoney then
        xPlayer.Functions.AddItem("markedbills", requestedtreasure[i].money)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["markedbills"], "add")
      else
        xPlayer.Functions.AddMoney("cash", requestedtreasure[i].money)
      end
    end
    --Give items
    for f,j in pairs(requestedtreasure[i].items) do
      xPlayer.Functions.AddItem(j.Name, j.Amount)
      TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[string.lower(j.Name)], "add")
    end
    --Give weapons
    for f,j in pairs(requestedtreasure[i].weapons) do
      if j.AmmoType ~= nil then
        xPlayer.Functions.AddItem(j.Name, 1)
        xPlayer.Functions.AddItem(j.AmmoType, j.Ammo)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[string.lower(j.Name)], "add")
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[string.lower(j.Ammo)], "add")
      else
        xPlayer.Functions.AddItem(j.Name, j.Ammo)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[string.lower(j.Name)], "add")
      end
      
    end

    --Print in the console who opened what
    print('QBCore Treasure: '..playerName..' just opened '..requestedtreasure[i].name)
  end

  --Trigger the checking function from the client in order to make the opened crate inaccessible to the player that opened it or for others
  if Config.OnePersonOpen then
    TriggerClientEvent('qb-crates:checkcheck', -1) --Check for everybody
  else
    TriggerClientEvent('qb-crates:checkcheck', source) --Check for source
  end
end)

QBCore.Functions.CreateCallback('qb-crates:isTaken',function(source, cb, name)
	local xPlayer = QBCore.Functions.GetPlayer(source)
  local identifier = QBCore.Functions.GetIdentifier(source, 'license')
  local isTaken = 0

  --Search in the database if the player already opened the crate
  --This is called by the client for each crate
  if Config.OnePersonOpen then
    MySQL.Async.fetchAll(
    'SELECT treasurename FROM treasure WHERE treasurename = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  else
    MySQL.Async.fetchAll(
    'SELECT treasurename FROM treasure WHERE identifier = @identifier AND treasurename = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  end

  function isTakenResult(result)
      for i=1, #result, 1 do
        if name == result[i].treasurename then
          isTaken = 1
        end
      end
    cb(isTaken)
  end
end)

