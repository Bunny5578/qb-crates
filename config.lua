Config              = {}
Config.DrawDistance = 100.0
Config.IsMoneyDirtyMoney = false --If true, the money you get from treasure crates will be given in dirty money. If false, the player will get normal cash money.
Config.ContainerModel = "prop_box_wood05a" --Crate model.
Config.ShowBlips = false --If true crate blips are shown on the map.
Config.OnePersonOpen = false --If true, a crate that was once open can't be opened again by anybody (1 use). If false, the crate can be opened once by everybody (1 use/person).
Config.MarkerCircle = 1 --doesnt do anything

Config.Treasure = {
	Treasure1 = {
		Name = "Starter Crate", --Each crate must have a unique name
		Pos = {x = 444.89, y = -1025.09, z = 28.67}, --Position on the map
		Size = {x = 3.0, y = 3.0, z = 1.0}, --Marker size (even if invisible)
		Color = {r = 204, g = 204, b = 0}, --Maker color
		Type = Config.MarkerCircle, --Marker type. defined above
		Money = 0, --Money given
		Items = { --Array of items given
			Item1 = { --Item
				Name = 'water_bottle', --Item name (make sure to use the name from the DB)
				Amount = 10, --How many of this item you want to give
			},
			Item1 = { --Item
			Name = 'compass', --Item name (make sure to use the name from the DB)
			Amount = 10, --How many of this item you want to give
		    },  
			Item2 = { --Another item
				Name = 'sandwich', --The item's name
				Amount = 10, --The amount
			},
		},
		Weapons = { --Array of weapons given
			Weapon1 = { --Weapon
				Name = 'WEAPON_PISTOL', --The weapon's name (can be found in es_extended/config.weapons.lua)
				AmmoType = 'PISTOL_AMMO',
				Ammo = 10, --Amount 
			},
		},
	},
	--If you don't want the crate to give items or weapons, just leave the Items and Weapons array empty
	--If you don't want the crate to give money, set the money to 0, DON'T GO INTO NEGATIVE
	--See examples below

	Treasure2 = {
		Name = "Lighthouse Crate",
		Pos = {x = 325.74, y = -1086.1, z = 60.77},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 5000,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_FLAREGUN',
				AmmoType = nil,
				Ammo = 1,
			},
		},
	},

	Treasure3 = {
		Name = "Hatchet Crate",
		Pos = {x = 1443.29, y = 6333.99, z = 22.89},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 7500,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_HATCHET',
				AmmoType = nil,
				Ammo = 1,
			},
		},
	},

	Treasure4 = {
		Name = "Man of the woods crate",
		Pos = {x = -575.88, y = 5953.77, z = 21.89},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_COMBATPDW',
				AmmoType = 'smg_ammo',
				Ammo = 1,
			},
		},
	},

	Treasure5 = {
		Name = "Hiker's crate",
		Pos = {x = -767.10, y = 4335.09, z = 147.21},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 12500,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_PISTOL50',
				Ammo = 180,
			},
		},
	},

	Treasure6 = {
		Name = "Warehouse worker's crate",
		Pos = {x = 246.25, y = 370.13, z = 104.80},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
			Item1 = {
				Name = 'coke',
				Amount = 180,
			},
		},
		Weapons = {
		},
	},

	Treasure7 = {
		Name = "Boat crate",
		Pos = {x = 1235.09, y = -2918.19, z = 28.75},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
		},
		Weapons = {
			Weapon1 = {
				Name = 'WEAPON_MICROSMG',
				Ammo = 1,
			},
		},
	},

	Treasure8 = {
		Name = "Weed dealer's crate",
		Pos = {x = -1165.29, y = -1566.74, z = 3.51},
		Size = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type = Config.MarkerCircle,
		Money = 0,
		Items = {
			Item1 = {
				Name = 'weed',
				Amount = 180,
			},
		},
		Weapons = {
		},
	},
}