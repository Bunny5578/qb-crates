local currentZone               = ''
local LastZone                  = ''
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local CurrentActionName         = ''
local alltreasures              = {}
local QBCore = exports['qb-core']:GetCoreObject()
local canOpenContainer

AddEventHandler('onResourceStart', function()
  TriggerEvent('qb-crates:checkcheck')
end)

RegisterNetEvent('qb-crates:checkcheck')
AddEventHandler('qb-crates:checkcheck', function()
  checkIfTaken()
end)

local ped
local coords
CreateThread(function()
    while true do
        ped = PlayerPedId()
        coords = GetEntityCoords(ped)
        Wait(0)
    end
end)

function checkIfTaken()
  --Empty the old set of crates
  for i=1, #alltreasures, 1 do
    alltreasures[i]=nil
  end
  --Refresh the set of crates excluding the ones that were already taken
  for k,v in pairs(Config.Treasure) do
    Wait(500) --Fixes a bug for slower servers
    QBCore.Functions.TriggerCallback('qb-crates:isTaken', function(isTaken)
      if isTaken == 0 then
        table.insert(alltreasures, {
          name = v.Name,
          posx = v.Pos.x,
          posy = v.Pos.y,
          posz = v.Pos.z,
          type = v.Type,
          size = v.Size,
          color = v.Color,
        })
      end
    end, v.Name)
  end
end

AddEventHandler('qb-crates:hasEnteredMarker', function(zone, name)
  canOpenContainer = true
  CurrentActionName = name
end)
-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
		Wait(0)
		local isInMarker  = false
		local currentZone = nil
      
    for i=1,#alltreasures,1 do
      local crateCoords = vector3(alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz)
      if #(coords - crateCoords) < 3then
        isInMarker  = true
        currentZone = 'containerzone'
        LastZone    = 'containerzone'
        currentName = alltreasures[i].name
      end
    end
        
    if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('qb-crates:hasEnteredMarker', currentZone, currentName)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
      canOpenContainer = false
		end
	end
end)

RegisterNetEvent('qb-crates:TryOpenStash', function()
  if canOpenContainer and CurrentActionName ~= nil then
    TriggerServerEvent('qb-crates:found', CurrentActionName)
  end
end)



-- Display markers
Citizen.CreateThread(function()
  while true do
    Wait(0)
    for i=1,#alltreasures,1 do
      local crateCoords = vector3(alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz)
      local distance = #(coords - crateCoords)
			if (alltreasures[i].type ~= -1 and distance < Config.DrawDistance) then
				-- DrawMarker(alltreasures[i].type, alltreasures[i].posx, alltreasures[i].posy, alltreasures[i].posz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, alltreasures[i].size.x, alltreasures[i].size.y, alltreasures[i].size.z, alltreasures[i].color.r, alltreasures[i].color.g, alltreasures[i].color.b, 100, false, true, 2, false, false, false, false)
      end
		end
  end
end)

-- Display container
Citizen.CreateThread(function()
  for k,v in pairs(Config.Treasure) do
    RequestModel(Config.ContainerModel)
    while not HasModelLoaded(Config.ContainerModel) do
      RequestModel(Config.ContainerModel)
      Wait(1)
    end
    crate = CreateObjectNoOffset(Config.ContainerModel, v.Pos.x, v.Pos.y, v.Pos.z, false, true, false)
  end
end)

-- Create Blips
Citizen.CreateThread(function()
  if Config.ShowBlips then
    for k,info in pairs(Config.Treasure) do
      info.blip = AddBlipForCoord(info.Pos.x, info.Pos.y, info.Pos.z)
      SetBlipSprite(info.blip, 501)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, 31)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Treasure')
      EndTextCommandSetBlipName(info.blip)
    end
  end
end)
