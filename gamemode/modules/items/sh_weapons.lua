
local Weapons = Weapons or {}

local mt = {
	__call = function(table, id, name, type, slot, rarity, entity, model, durability, weight, value, level, minDamage, maxDamage, criticalChance, actionPoints, ammoType)
		local weapon = {
			name = name,
			type = type,
			slot = slot,
			rarity = rarity,
			entity = entity,
			model = model,
			durability = durability,
			weight = weight,
			value = value,
			level = level,
			minDamage = minDamage,
			maxDamage = maxDamage,
			criticalChance = criticalChance,
			actionPoints = actionPoints,
			ammoType = ammoType,
		}
		setmetatable(weapon, {__index = ITEM})

		addToLoot(weapon)

		function weapon:getMinDamage()
			return self.minDamage
		end
		function weapon:getMaxDamage()
			return self.maxDamage
		end
		function weapon:getMedianDamage()
			return math.floor((self.minDamage + self.maxDamage) / 2)
		end
		function weapon:getCriticalChance()
			return self.criticalChance
		end
		function weapon:getAmmoType()
			return self.ammoType or ""
		end

		Weapons[id] = weapon
		return weapon
	end
}
setmetatable(Weapons, mt)

function getWeapons()
	return Weapons
end

function findWeapon(id)
	if id then
		return Weapons[id]
	end
end

// Weapon data that's dynamic
local meta = FindMetaTable("Player")

function meta:getWeaponDamage(uniqueid, location)
	local location = location or "inventory"

	return self[location].weapons[uniqueid]["damage"] or 0
end
function meta:getWeaponDurability(uniqueid, location)
	local location = location or "inventory"

	return self[location].weapons[uniqueid]["durability"] or 0
end

timer.Simple(5, function()
	// Level 1:
	Weapons(1023, "Lead Pipe", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_leadpipe", "models/Halokiller38/fallout/weapons/Melee/leadpipe.mdl", 1120, 2.5, 0, 1, 14, 18, 2, 1.76, nil)
	Weapons(1075, "Pickaxe", DMG_SLASH, "primary", RARITY_WHITE, "eoti_tool_miningpick", "models/pickaxe/pickaxe_w.mdl", 1120, 2.5, 55, 1, 0, 0, 2.75, 1.76, nil)
	Weapons(1074, "Lockpick", DMG_SLASH, "primary", RARITY_WHITE, "lockpick", "models/weapons/w_crowbar.mdl", 1120, 2.5, 130, 1, 0, 0, 2.75, 1.76, nil)
	Weapons(1056, "Silence .22", DMG_BULLET, "seconary", RARITY_WHITE, "weapon_22mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/silenced22pistol.mdl", 1120, 2.5, 0, 1, 8, 12, 4, 1.76, 3001)

	// level 2
	Weapons(1001, "Assault Carbine", DMG_BULLET, "primary", RARITY_WHITE, "weapon_assaultcarbinesil", "models/Halokiller38/fallout/weapons/AssaultRifles/assaultcarbinesilencer.mdl", 1120, 2.5, 2000, 2, 8, 10, 12, 1.76, 3001)

	//Level 3:
	Weapons(1027, "Pool Cue", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_poolcue", "models/Halokiller38/fallout/weapons/Melee/poolcue.mdl", 1120, 2.5, 117, 3, 16, 20, 2, 1.76, nil)

	//Level 4:
	Weapons(1050, "9mm Pistol", DMG_BULLET, "seconary", RARITY_GREEN, "weapon_9mmpistol", "models/Halokiller38/fallout/weapons/Pistols/9mmpistol.mdl", 1120, 2.5, 250, 4, 14, 16, 5, 1.76, 3001)

	//Level 5:
	Weapons(1022, "Dress Cane", DMG_CLUB, "seconary", RARITY_GREEN, "weapon_dresscane", "models/Halokiller38/fallout/weapons/Melee/dresscane.mdl", 1120, 2.5, 181, 5, 22, 26, 3, 1.76, nil)

	//Level 6:
	Weapons(1044, "Maria", DMG_BULLET, "seconary", RARITY_WHITE, "weapon_9mmpistolmaria", "models/Halokiller38/fallout/weapons/Pistols/9mmunique.mdl", 1120, 2.5, 152, 6, 14, 18, 4, 1.76, 3001)

	//Level 7:
	Weapons(1006, "Bumper Sword", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_bumpersword", "models/Halokiller38/fallout/weapons/Melee/bumpersword.mdl", 1120, 2.5, 278, 7, 32, 38, 10, 1.76, nil)

	//Level 8:
	Weapons(1052, "Chinese Pistol", DMG_BULLET, "seconary", RARITY_BLUE, "weapon_chinesepistol", "models/Halokiller38/fallout/weapons/Pistols/chinesepistol.mdl", 1120, 2.5, 500, 8, 22, 28, 4, 1.76, 3001)

	//Level 9:
	Weapons(1032, "Tire Iron", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_tireiron", "models/Halokiller38/fallout/weapons/Melee/tireiron.mdl", 1120, 2.5, 428, 9, 22, 26, 2, 1.76, nil)
	Weapons(1017, "Straight Razor", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_straightrazor", "models/Halokiller38/fallout/weapons/Melee/straightrazor.mdl", 1120, 2.5, 525, 9, 20, 25, 15,  1.76, nil)

	//Level 10:
	Weapons(1035, "Laser Pistol", DMG_SONIC, "seconary", RARITY_BLUE, "weapon_laserpistol", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpistol.mdl", 1120, 2.5, 1242, 10, 28, 32, 15, 1.76, 3003)
	Weapons(1048, "10mm Pistol", DMG_BULLET, "seconary", RARITY_GREEN, "weapon_10mmpistol", "models/Halokiller38/fallout/weapons/pistols/10mmpistol.mdl", 1120, 2.5, 311, 10, 20, 24, 8, 1.76, 3001)
	Weapons(1070, "9mm Sub-Machine Gun", DMG_BULLET, "primary", RARITY_WHITE, "weapon_9mmsmgdrum", "models/Halokiller38/fallout/weapons/SMGs/9mmsmgdrum.mdl", 1120, 2.5, 311, 10, 9, 12, 6, 1.76, 3001)

	//Level 11:
	Weapons(1015, "Machete", DMG_SLASH, "seconary", RARITY_BLUE, "weapon_machete", "models/Halokiller38/fallout/weapons/Melee/machete.mdl", 1120, 2.5, 659, 11, 35, 40, 20, 1.76, nil)

	//Level 12:
	Weapons(1051, "Light in Darkness", DMG_BULLET, "seconary", RARITY_PURPLE, "weapon_45autopistolu", "models/Halokiller38/fallout/weapons/Pistols/45autopistolunique.mdl", 1120, 2.5, 444, 12, 32, 36, 10, 1.76, 3001)

	//Level 13:
	Weapons(1025, "Nine Iron", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_nineiron", "models/Halokiller38/fallout/weapons/Melee/9iron.mdl", 1120, 2.5, 1014, 13, 24, 28, 4, 1.76, nil)
	Weapons(1014, "Lily's Vertibird Blade", DMG_SLASH, "seconary", RARITY_ORANGE, "weapon_lilysblade", "models/Halokiller38/fallout/weapons/Melee/lilysblade.mdl", 1120, 2.5, 5000, 13, 75, 100, 75, 1.76, nil)

	//Level 14:
	Weapons(1068, "10mm Sub-Machine Gun", DMG_BULLET, "primary", RARITY_GREEN, "weapon_10mmsmgext", "models/weapons/w_Pistol.mdl", 1120, 2.5, 635, 14, 13, 16, 12, 1.76, 3001)
	Weapons(1041, "Plasma Pistol", DMG_PLASMA, "seconary", RARITY_BLUE, "weapon_plasmapistol", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmapistol.mdl", 1120, 2.5, 1912, 14, 32, 34, 16, 1.76, 3002)

	//Level 15:
	Weapons(1071, "Brass Knuckles", DMG_CLUB, "primary", RARITY_BLUE, "weapon_brassknuckles", "models/Halokiller38/fallout/weapons/Melee/brassknuckles.mdl", 1120, 2.5, 1090, 15, 25, 30, 25, 1.76, nil)
	Weapons(1016, "Machete Gladius", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_machetegladius", "models/Halokiller38/fallout/weapons/Melee/machetegladius.mdl", 1120, 2.5, 1193, 15, 34, 38, 20, 1.76, nil)

	//Level 16:
	Weapons(1057, "Battle Rifle", DMG_BULLET, "primary", RARITY_WHITE, "weapon_battlerifle", "models/Halokiller38/fallout/weapons/Rifles/thismachine.mdl", 1120, 2.5, 907, 16, 22, 26, 12, 1.76, 3001)

	//Level 17:
	Weapons(1029, "Shovel", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_shovel", "models/Halokiller38/fallout/weapons/Melee/shovel.mdl", 1120, 2.5, 1404, 17, 28, 30, 3, 1.76,  nil)

	//Level 18:
	Weapons(1067, ".45 Sub-Machine Gun", DMG_BULLET, "primary", RARITY_BLUE, "weapon_45smg", "models/Halokiller38/fallout/weapons/SMGs/45smg.mdl", 1120, 2.5, 2941, 18, 22, 25, 18, 1.76, 3001)
	Weapons(1033, "Automatic Plasma Defender", DMG_PLASMA, "primary", RARITY_PURPLE, "weapon_plasmadefender", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmadefender.mdl", 1120, 2.5, 4464, 18, 58, 63, 20, 1.76, 3002)

	//Level 19:
	Weapons(1011, "Fireaxe", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_fireaxe", "models/Halokiller38/fallout/weapons/Melee/fireaxe.mdl", 1120, 2.5, 1652, 19, 40, 43, 25, 1.76, nil)

	//Level 20:
	Weapons(1063, "Hunting Shotgun", DMG_BULLET, "primary", RARITY_GREEN, "weapon_huntingshotgun", "models/Halokiller38/fallout/weapons/Shotguns/huntingshotgun.mdl", 1120, 2.5, 1853, 20, 45, 60, 10, 1.76, 3001)

	//Level 21:
	Weapons(1026, "Police Baton", DMG_CLUB, "seconary", RARITY_BLUE, "weapon_policebaton", "models/Halokiller38/fallout/weapons/Melee/baton.mdl", 1120, 2.5, 1943, 21, 40, 48, 14, 2.75, nil)

	//Level 22:
	Weapons(1069, "12.7mm Sub-Machine Gun", DMG_BULLET, "primary", RARITY_GREEN, "weapon_127mmsmgsil", "models/Halokiller38/fallout/weapons/SMGs/127smgsilencer.mdl", 1120, 2.5, 2058, 22, 23, 26, 20, 1.76, 3001)
	Weapons(1037, "Laser Rifle", DMG_SONIC, "primary", RARITY_BLUE, "weapon_laserrifle", "models/Halokiller38/fallout/weapons/Energy Weapons/laserrifle.mdl", 1120, 2.5, 4525, 22, 45, 55, 20, 1.76, 3003)
	Weapons(1047, ".45 Auto Pistol", DMG_BULLET, "seconary", RARITY_BLUE, "weapon_45autopistol", "models/Halokiller38/fallout/weapons/Pistols/45pistol.mdl", 1120, 2.5, 2058, 22, 37, 40, 14, 1.76, 3001)

	//Level 23:
	Weapons(1008, "Chinese Officer Sword", DMG_SLASH, "seconary", RARITY_PURPLE, "weapon_chineseofficersword", "models/Halokiller38/fallout/weapons/Melee/chineseofficersword.mdl", 1120, 2.5, 2209, 23, 48, 56, 35, 1.76, nil)

	//Level 24:
	Weapons(1049, "12.7mm Pistol", DMG_BULLET, "seconary", RARITY_WHITE, "weapon_127mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/127mmpistolsilencer.mdl", 1120, 2.5, 2287, 24, 32, 36, 12, 1.76, 3001)

	//Level 25:
	Weapons(1021, "Dirty Baseball Bat", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_bballbatdirty", "models/Halokiller38/fallout/weapons/Melee/baseballbatdirty.mdl", 1120, 2.5, 2511, 25, 36, 40, 8, 1.76, nil)

	// Level 26:
	Weapons(1058, "Hunting Rifle", DMG_BULLET, "primary", RARITY_BLUE, "weapon_huntingrifleext", "models/Halokiller38/fallout/weapons/Rifles/huntingrifleext.mdl", 1120, 2.5, 5324, 26, 46, 50, 28, 1.76, 3001)
	Weapons(1038, "Laser Rifle (Scope)", DMG_SONIC, "primary", RARITY_PURPLE, "weapon_laserriflescp", "models/Halokiller38/fallout/weapons/Energy Weapons/laserriflescope.mdl", 1120, 2.5, 5449, 26, 50, 60, 25, 1.76, 3003)
	Weapons(1054, "Police Pistol", DMG_BULLET, "seconary", RARITY_GREEN, "weapon_policepistol", "models/Halokiller38/fallout/weapons/Pistols/policepistol.mdl", 1120, 2.5, 2824, 26, 36, 40, 12, 1.76, 3001)

	// Level 27:
	Weapons(1019, "Trench Knife", DMG_SLASH, "seconary", RARITY_BLUE, "weapon_trenchknife", "models/Halokiller38/fallout/weapons/Melee/trenchknife.mdl", 1120, 2.5, 2886, 27, 40, 46, 40, 1.76, nil)

	// Level 28:
	Weapons(1045, ".357 Magnum Revolver", DMG_BULLET, "seconary", RARITY_GREEN, "weapon_357revolverlonghdcyl", "models/Halokiller38/fallout/weapons/Pistols/357revolverhdcyl.mdl", 1120, 2.5, 3138, 28, 42, 46, 12, 1.76, 3001)
	Weapons(1059, "Hunting Rifle (Scope)", DMG_BULLET, "primary", RARITY_BLUE, "weapon_huntingriflescp", "models/Halokiller38/fallout/weapons/Rifles/huntingriflescoped.mdl", 1120, 2.5, 3138, 28, 46, 50, 28, 1.76, 3001)

	// Level 29:
	Weapons(1024, "Nail Board", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_nailboard", "models/Halokiller38/fallout/weapons/Melee/nailboard.mdl", 1120, 2.5, 3280, 29, 42, 46, 8, 1.76, nil)

	// Level 30:
	Weapons(1064, "Riot Shotgun", DMG_BULLET, "primary", RARITY_GREEN, "weapon_riotshotgun", "models/Halokiller38/fallout/weapons/Shotguns/riotshotgun.mdl", 1120, 2.5, 3486, 30, 38, 54, 15, 1.76, 3001)
	Weapons(1040, "Modified Tribeam Rifle", DMG_SONIC, "primary", RARITY_BLUE, "weapon_tribeam", "models/Halokiller38/fallout/weapons/Energy Weapons/tribeamlaserrifle.mdl", 1120, 2.5, 6264, 30, 55, 60, 30, 1.76, 3003)
	Weapons(1073, "Spiked Knuckles", DMG_SLASH, "primary", RARITY_GREEN, "weapon_spikedknuckles", "models/Halokiller38/fallout/weapons/Melee/spikedknuckles.mdl", 1120, 2.5, 1350, 30, 32, 34, 35, 1.76, nil)

	// Level 31:
	Weapons(1018, "Switchblade", DMG_SLASH, "seconary", RARITY_WHITE, "weapon_switchblade", "models/Halokiller38/fallout/weapons/Melee/switchblade.mdl", 1120, 2.5, 3727, 31, 34, 36, 40, 1.76, nil)

	// Level 32:
	Weapons(1002, "Chinese Assault Rifle", DMG_BULLET, "primary", RARITY_GREEN, "weapon_chineseassaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/chineseassaultrifle.mdl", 1120, 2.5, 3874, 32, 32, 36, 16, 1.76, 3001)
	Weapons(1066, "Sniper Rifle", DMG_BULLET, "primary", RARITY_PURPLE, "weapon_sniperriflesil", "models/Halokiller38/fallout/weapons/SniperRifles/sniperriflesupressor.mdl", 1120, 2.5, 3874, 32, 70, 80, 40, 1.76, 3001)

	// Level 33:
	Weapons(1020, "Cattle Prod", DMG_CLUB, "seconary", RARITY_WHITE, "weapon_cattleprod", "models/Halokiller38/fallout/weapons/Melee/cattleprod.mdl", 1120, 2.5, 4235, 33, 38, 44, 16, 1.76, nil)

	// Level 34:
	Weapons(1036, "Laser RCW", DMG_SONIC, "primary", RARITY_GREEN, "weapon_laserpdw", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpdw.mdl", 1120, 2.5, 7369, 34, 15, 20, 12, 1.76, 3003)
	Weapons(1060, "Railway Rifle", DMG_BULLET, "primary", RARITY_WHITE, "weapon_railwayrifle", "models/Halokiller38/fallout/weapons/Rifles/railwayrifle.mdl", 1120, 2.5, 4304, 34, 50, 55, 35, 1.76, 3001)

	// Level 35:
	Weapons(1013, "Kitchen Knife", DMG_SLASH, "seconary", RARITY_WHITE, "weapon_kitchenknife", "models/Halokiller38/fallout/weapons/Melee/kitchenknife.mdl", 1120, 2.5, 4813, 35, 36, 38, 45, 1.76, nil)

	// Level 36:
	Weapons(1003, "R91 Assault Rifle", DMG_BULLET, "primary", RARITY_GREEN, "weapon_r91assaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/r91assaultrifle.mdl", 1120, 2.5, 4782, 36, 36, 40, 22, 1.76, 3001)

	// Level 37:
	Weapons(1030, "Sledge Hammer", DMG_SLASH, "seconary", RARITY_BLUE, "weapon_sledgehammer", "models/Halokiller38/fallout/weapons/Melee/sledgehammer.mdl", 1120, 2.5, 5175, 37, 65, 80, 16, 1.76, nil)

	// Level 38:
	Weapons(1046, ".44 Magnum Revolver", DMG_BULLET, "seconary", RARITY_BLUE, "weapon_44revolver", "models/Halokiller38/fallout/weapons/Pistols/44magnumrevolver.mdl", 1120, 2.5, 5314, 38, 54, 60, 16, 1.76, 3001)

	// Level 39:
	Weapons(1009, "Cleaver", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_cleaver", "models/Halokiller38/fallout/weapons/Melee/cleaver.mdl", 1120, 2.5, 5565, 39, 42, 44, 50, 1.76, nil)

	// Level 40:
	Weapons(1034, "Gatling Laser", DMG_SONIC, "primary", RARITY_ORANGE, "weapon_gatlinglaser", "models/Halokiller38/fallout/weapons/Energy Weapons/gatlinglaser.mdl", 1120, 2.5, 8670, 40, 6, 9, 15, 1.76, 3003)
	Weapons(1043, "Minigun", DMG_BULLET, "primary", RARITY_PURPLE, "weapon_minigun", "models/halokiller38/fallout/weapons/heavy weapons/minigun.mdl", 1120, 2.5, 5904, 40, 6, 9, 18, 1.76, 3001)
	Weapons(1053, "Hunting Revolver", DMG_BULLET, "seconary", RARITY_ORANGE, "weapon_huntingrevolver", "models/Halokiller38/fallout/weapons/Pistols/huntingrevolver.mdl", 1120, 2.5, 5904, 40, 70, 90, 35, 1.76, 3001)

	// Level 41:
	Weapons(1012, "Hatchet", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_hatchet", "models/Halokiller38/fallout/weapons/Melee/hatchet.mdl", 1120, 2.5, 5984, 41, 46, 50, 55, 1.76, nil)

	// Level 42:
	Weapons(1004, "Service Rifle", DMG_BULLET, "primary", RARITY_PURPLE, "weapon_serviceriflereflex", "models/Halokiller38/fallout/weapons/AssaultRifles/battlerifleap.mdl", 1120, 2.5, 6561, 42, 50, 60, 30, 1.76, 3001)

	// Level 43:
	Weapons(1028, "Rebar Club", DMG_CLUB, "seconary", RARITY_GREEN, "weapon_rebarclub", "models/Halokiller38/fallout/weapons/Melee/rebar.mdl", 1120, 2.5, 6434, 43, 65, 75, 25, 1.76, nil)

	// Level 44:
	Weapons(1061, "Varmint Rifle", DMG_BULLET, "primary", RARITY_GREEN, "weapon_varmintriflesilext", "models/Halokiller38/fallout/weapons/Rifles/varmintriflesilext.mdl", 1120, 2.5, 7290, 44, 72, 82, 42, 1.76, 3001)

	// Level 45:
	Weapons(1039, "Modified Multiplas Rifle", DMG_SONIC, "primary", RARITY_PURPLE, "weapon_multiplasrifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/multiplasrifle.mdl", 1120, 2.5, 12000, 50, 80, 90, 38, 1.76, 3002)
	Weapons(1007, "Chance's Knife", DMG_SLASH, "seconary", RARITY_PURPLE, "weapon_chancesknife", "models/Halokiller38/fallout/weapons/Melee/chancesknife.mdl", 1120, 2.5, 6919, 45, 44, 46, 60, 1.76, nil)

	// Level 46:
	Weapons(1055, "Ranger Sequoia", DMG_BULLET, "seconary", RARITY_BLUE, "weapon_rangersequoia", "models/Halokiller38/fallout/weapons/Pistols/rangersequoia.mdl", 1120, 2.5, 8100, 46, 65, 70, 22, 1.76, 3001)

	// Level 47:
	Weapons(1005, "Bowie Knife", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_bowieknife", "models/Halokiller38/fallout/weapons/Melee/bowieknife.mdl", 1120, 2.5, 7440, 47, 35, 45, 65, 1.76, nil)

	//Level 48:
	Weapons(1062, "Combat Shotgun", DMG_BULLET, "primary", RARITY_PURPLE, "weapon_combatshotgun", "models/Halokiller38/fallout/weapons/Shotguns/combatshotgun.mdl", 1120, 2.5, 9000, 48, 70, 100, 35, 1.76, 3001)

	//Level 49:
	Weapons(1072, "Deathclaw Gauntlet", DMG_SLASH, "primary", RARITY_ORANGE, "weapon_deathclawgauntlet", "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 1120, 2.5, 2360, 49, 95, 115, 65, 1.76, nil)

	//Level 50:
	Weapons(1065, "Anti-Material Rifle", DMG_BULLET, "primary", RARITY_ORANGE, "weapon_antimaterielrifle", "models/Halokiller38/fallout/weapons/SniperRifles/antimaterielrifle.mdl", 1120, 2.5, 10000, 50, 95, 115, 65, 1.76, 3001)
	Weapons(1042, "Plasma Rifle", DMG_PLASMA, "primary", RARITY_BLUE, "weapon_plasmarifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmarifle.mdl", 1120, 2.5, 10200, 50, 84, 96, 25, 1.76, 3002)
	Weapons(1010, "Combat Knife", DMG_SLASH, "seconary", RARITY_GREEN, "weapon_combatknife", "models/Halokiller38/fallout/weapons/Melee/combatknife.mdl", 1120, 2.5, 8000, 50, 50, 54, 70, 1.76, nil)
	Weapons(1031, "Super Sledge", DMG_CLUB, "seconary", RARITY_ORANGE, "weapon_supersledge", "models/Halokiller38/fallout/weapons/Melee/supersledge.mdl", 1120, 2.5, 8000, 50, 100, 120, 40, 1.76, nil)
end)
