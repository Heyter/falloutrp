
local meta = FindMetaTable("Player")

local Weapons = {}

function addWeapon(id, name, type, slot, entity, model, durability, weight, value, level, minDamage, maxDamage, criticalChance, actionPoints, ammoType)
	Weapons[id] = {
		name = name,
		type = type,
		slot = slot,
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
end


function getWeapons()
	return Weapons
end

function findWeapon(id)
	if id then
		return Weapons[id]
	end
end

// Base functions that have data that will not change
function getWeaponName(id)
	return findWeapon(id).name
end
function getWeaponType(id)
	return findWeapon(id).type
end
function getWeaponSlot(id)
	return findWeapon(id).slot
end
function getWeaponEntity(id)
	return findWeapon(id).entity
end
function getWeaponModel(id)
	return findWeapon(id).model
end
function getWeaponMinDamage(id)
	return findWeapon(id).minDamage
end
function getWeaponMedianDamage(id)
	return math.floor((findWeapon(id).minDamage + findWeapon(id).maxDamage) / 2)
end
function getWeaponMaxDamage(id)
	return findWeapon(id).maxDamage
end
function getWeaponWeight(id)
	return findWeapon(id).weight or 0
end
function getWeaponValue(id)
	return findWeapon(id).value
end
function getWeaponLevel(id)
	return findWeapon(id).level
end
function getWeaponCriticalChance(id)
	return findWeapon(id).criticalChance
end
function getWeaponMaxDurability(id)
	return findWeapon(id).durability
end
function getWeaponAmmoType(id)
	return findWeapon(id).ammoType or ""
end

// Functions that have data which can change
function meta:getWeaponDamage(uniqueid, location)
	local location = location or "inventory"

	return self[location].weapons[uniqueid]["damage"] or 0
end
function meta:getWeaponDurability(uniqueid, location)
	local location = location or "inventory"

	return self[location].weapons[uniqueid]["durability"] or 0
end

addWeapon(1017, "Straight Razor", DMG_SLASH, "secondary", "weapon_straightrazor", "models/Halokiller38/fallout/weapons/Melee/straightrazor.mdl", 1120, 2.5, 525, 9, 18, 23, 15,  1.76, nil)

// Level 1:
addWeapon(1023, "Lead Pipe", DMG_CLUB, "secondary", "weapon_leadpipe", "models/Halokiller38/fallout/weapons/Melee/leadpipe.mdl", 1120, 2.5, 0, 1, 14, 18, 2, 1.76, nil)

addWeapon(1075, "Pickaxe", DMG_SLASH, "primary", "eoti_tool_miningpick", "models/pickaxe/pickaxe_w.mdl", 1120, 2.5, 55, 1, 0, 0, 2.75, 1.76, nil)

//Level 2:
addWeapon(1056, "Silence .22", DMG_BULLET, "secondary", "weapon_22mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/silenced22pistol.mdl", 1120, 2.5, 74, 2, 8, 12, 4, 1.76, 3007)

addWeapon(1074, "Lockpick", DMG_SLASH, "primary", "lockpick", "models/weapons/w_crowbar.mdl", 1120, 2.5, 130, 2, 0, 0, 2.75, 1.76, nil)

//Level 3:
addWeapon(1027, "Pool Cue", DMG_CLUB, "secondary", "weapon_poolcue", "models/Halokiller38/fallout/weapons/Melee/poolcue.mdl", 1120, 2.5, 117, 3, 16, 20, 2, 1.76, nil)

//Level 4:
addWeapon(1050, "9mm Pistol", DMG_BULLET, "secondary", "weapon_9mmpistol", "models/Halokiller38/fallout/weapons/Pistols/9mmpistol.mdl", 1120, 2.5, 250, 4, 12, 14, 4, 1.76, 3017)

//Level 5:
addWeapon(1022, "Dress Cane", DMG_CLUB, "secondary", "weapon_dresscane", "models/Halokiller38/fallout/weapons/Melee/dresscane.mdl", 1120, 2.5, 181, 5, 20, 24, 2, 1.76, nil)

//Level 6:
addWeapon(1044, "Maria", DMG_BULLET, "secondary", "weapon_9mmpistolmaria", "models/Halokiller38/fallout/weapons/Pistols/9mmunique.mdl", 1120, 2.5, 152, 6, 14, 18, 4, 1.76, 3017)

//Level 7:

addWeapon(1006, "Bumper Sword", DMG_SLASH, "secondary", "weapon_bumpersword", "models/Halokiller38/fallout/weapons/Melee/bumpersword.mdl", 1120, 2.5, 278, 7, 30, 36, 10, 1.76, nil)

//Level 8:
addWeapon(1052, "Chinese Pistol", DMG_BULLET, "secondary", "weapon_chinesepistol", "models/Halokiller38/fallout/weapons/Pistols/chinesepistol.mdl", 1120, 2.5, 500, 8, 16, 20, 4, 1.76, 3009)

//Level 9:

addWeapon(1032, "Tire Iron", DMG_CLUB, "secondary", "weapon_tireiron", "models/Halokiller38/fallout/weapons/Melee/tireiron.mdl", 1120, 2.5, 428, 9, 22, 26, 2, 1.76, nil)

//Level 10:
addWeapon(1035, "Laser Pistol", DMG_SONIC, "secondary", "weapon_laserpistol", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpistol.mdl", 1120, 2.5, 1242, 10, 23, 28, 12, 1.76, 3021)

addWeapon(1048, "10mm Pistol", DMG_BULLET, "secondary", "weapon_10mmpistol", "models/Halokiller38/fallout/weapons/pistols/10mmpistol.mdl", 1120, 2.5, 311, 10, 18, 22, 8, 1.76, 3009)

addWeapon(1070, "9mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_9mmsmgdrum", "models/Halokiller38/fallout/weapons/SMGs/9mmsmgdrum.mdl", 1120, 2.5, 311, 10, 9, 12, 6, 1.76, 3017)

//Level 11:

addWeapon(1015, "Machete", DMG_SLASH, "secondary", "weapon_machete", "models/Halokiller38/fallout/weapons/Melee/machete.mdl", 1120, 2.5, 659, 11, 30, 36, 15, 1.76,nil)

//Level 12:
addWeapon(1051, "Light in Darkness", DMG_BULLET, "secondary", "weapon_45autopistolu", "models/Halokiller38/fallout/weapons/Pistols/45autopistolunique.mdl", 1120, 2.5, 444, 12, 22, 26, 8, 1.76, 3006)

//Level 13:

addWeapon(1025, "Nine Iron", DMG_CLUB, "secondary", "weapon_nineiron", "models/Halokiller38/fallout/weapons/Melee/9iron.mdl", 1120, 2.5, 1014, 13, 24, 28, 4, 1.76, nil)

addWeapon(1014, "Lily's Vertibird Blade", DMG_SLASH, "secondary", "weapon_lilysblade", "models/Halokiller38/fallout/weapons/Melee/lilysblade.mdl", 1120, 2.5, 5000, 13, 30, 60, 75, 1.76, nil)

//Level 14:

addWeapon(1068, "10mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_10mmsmgext", "models/weapons/w_Pistol.mdl", 1120, 2.5, 635, 14, 12, 15, 12, 1.76, 3009)

addWeapon(1041, "Plasma Pistol", DMG_PLASMA, "secondary", "weapon_plasmapistol", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmapistol.mdl", 1120, 2.5, 1912, 14, 28, 33, 16, 1.76, 3023)

//Level 15:

addWeapon(1071, "Brass Knuckles", DMG_CLUB, "primary", "weapon_brassknuckles", "models/Halokiller38/fallout/weapons/Melee/brassknuckles.mdl", 1120, 2.5, 1090, 15, 18, 22, 20, 1.76, nil)

addWeapon(1016, "Machete Gladius", DMG_SLASH, "secondary", "weapon_machetegladius", "models/Halokiller38/fallout/weapons/Melee/machetegladius.mdl", 1120, 2.5, 1193, 15, 32, 38, 20, 1.76, nil)

//Level 16:
addWeapon(1057, "Battle Rifle", DMG_BULLET, "primary", "weapon_battlerifle", "models/Halokiller38/fallout/weapons/Rifles/thismachine.mdl", 1120, 2.5, 907, 16, 22, 26, 12, 1.76, 3002)

//Level 17:

addWeapon(1029, "Shovel", DMG_CLUB, "secondary", "weapon_shovel", "models/Halokiller38/fallout/weapons/Melee/shovel.mdl", 1120, 2.5, 1404, 17, 28, 30, 4, 1.76,  nil)

//Level 18:
addWeapon(1067, ".45 Sub-Machine Gun", DMG_BULLET, "primary", "weapon_45smg", "models/Halokiller38/fallout/weapons/SMGs/45smg.mdl", 1120, 2.5, 2941, 18, 16, 20, 18, 1.76, 3006)

addWeapon(1033, "Automatic Plasma Defender", DMG_PLASMA, "primary", "weapon_plasmadefender", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmadefender.mdl", 1120, 2.5, 4464, 18, 58, 63, 20, 1.76, 3023)

//Level 19:


addWeapon(1011, "Fireaxe", DMG_SLASH, "secondary", "weapon_fireaxe", "models/Halokiller38/fallout/weapons/Melee/fireaxe.mdl", 1120, 2.5, 1652, 19, 36, 40, 25, 1.76, nil)

//Level 20:
addWeapon(1063, "Hunting Shotgun", DMG_BULLET, "primary", "weapon_huntingshotgun", "models/Halokiller38/fallout/weapons/Shotguns/huntingshotgun.mdl", 1120, 2.5, 1853, 20, 40, 55, 10, 1.76, 3010)

//Level 21:

addWeapon(1026, "Police Baton", DMG_CLUB, "secondary", "weapon_policebaton", "models/Halokiller38/fallout/weapons/Melee/baton.mdl", 1120, 2.5, 1943, 21, 32, 34, 8, 2.75, nil)

//Level 22:

addWeapon(1069, "12.7mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_127mmsmgsil", "models/Halokiller38/fallout/weapons/SMGs/127smgsilencer.mdl", 1120, 2.5, 2058, 22, 22, 26, 24, 1.76, 3011)

addWeapon(1037, "Laser Rifle", DMG_SONIC, "primary", "weapon_laserrifle", "models/Halokiller38/fallout/weapons/Energy Weapons/laserrifle.mdl", 1120, 2.5, 4525, 22, 36, 41, 24, 1.76, 3021)


addWeapon(1047, ".45 Auto Pistol", DMG_BULLET, "secondary", "weapon_45autopistol", "models/Halokiller38/fallout/weapons/Pistols/45pistol.mdl", 1120, 2.5, 2058, 22, 26, 30, 12, 1.76, 3006)

//Level 23:
addWeapon(1008, "Chinese Officer Sword", DMG_SLASH, "secondary", "weapon_chineseofficersword", "models/Halokiller38/fallout/weapons/Melee/chineseofficersword.mdl", 1120, 2.5, 2209, 23, 38, 42, 30, 1.76, nil)

//Level 24:
addWeapon(1049, "12.7mm Pistol", DMG_BULLET, "secondary", "weapon_127mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/127mmpistolsilencer.mdl", 1120, 2.5, 2287, 24, 32, 36, 12, 1.76, 3011)

addWeapon(1001, "Assault Carbine", DMG_BULLET, "primary", "weapon_assaultcarbinesil", "models/Halokiller38/fallout/weapons/AssaultRifles/assaultcarbinesilencer.mdl", 1120, 2.5, 2000, 24, 28, 32, 12, 1.76, 3016)

//Level 25:

addWeapon(1021, "Dirty Baseball Bat", DMG_CLUB, "secondary", "weapon_bballbatdirty", "models/Halokiller38/fallout/weapons/Melee/baseballbatdirty.mdl", 1120, 2.5, 2511, 25, 36, 40, 8, 1.76, nil)

// Level 26:

addWeapon(1058, "Hunting Rifle", DMG_BULLET, "primary", "weapon_huntingrifleext", "models/Halokiller38/fallout/weapons/Rifles/huntingrifleext.mdl", 1120, 2.5, 5324, 26, 38, 44, 28, 1.76, 3002)

addWeapon(1038, "Laser Rifle (Scope)", DMG_SONIC, "primary", "weapon_laserriflescp", "models/Halokiller38/fallout/weapons/Energy Weapons/laserriflescope.mdl", 1120, 2.5, 5449, 26, 36, 41, 24, 1.76, 3021)

addWeapon(1054, "Police Pistol", DMG_BULLET, "secondary", "weapon_policepistol", "models/Halokiller38/fallout/weapons/Pistols/policepistol.mdl", 1120, 2.5, 2824, 26, 34, 38, 12, 1.76, 3004)

// Level 27:
addWeapon(1019, "Trench Knife", DMG_SLASH, "secondary", "weapon_trenchknife", "models/Halokiller38/fallout/weapons/Melee/trenchknife.mdl", 1120, 2.5, 2886, 27, 32, 34, 35, 1.76, nil)

// Level 28:

addWeapon(1045, ".357 Magnum Revolver", DMG_BULLET, "secondary", "weapon_357revolverlonghdcyl", "models/Halokiller38/fallout/weapons/Pistols/357revolverhdcyl.mdl", 1120, 2.5, 3138, 28, 38, 42, 12, 1.76, 3004)

addWeapon(1059, "Hunting Rifle (Scope)", DMG_BULLET, "primary", "weapon_huntingriflescp", "models/Halokiller38/fallout/weapons/Rifles/huntingriflescoped.mdl", 1120, 2.5, 3138, 28, 38, 44, 28, 1.76, 3002)

// Level 29:
addWeapon(1024, "Nail Board", DMG_CLUB, "secondary", "weapon_nailboard", "models/Halokiller38/fallout/weapons/Melee/nailboard.mdl", 1120, 2.5, 3280, 29, 42, 46, 8, 1.76, nil)

// Level 30:
addWeapon(1064, "Riot Shotgun", DMG_BULLET, "primary", "weapon_riotshotgun", "models/Halokiller38/fallout/weapons/Shotguns/riotshotgun.mdl", 1120, 2.5, 3486, 30, 35, 50, 15, 1.76, 3010)

addWeapon(1040, "Modified Tribeam Rifle", DMG_SONIC, "primary", "weapon_tribeam", "models/Halokiller38/fallout/weapons/Energy Weapons/tribeamlaserrifle.mdl", 1120, 2.5, 6264, 30, 3, 4, 28, 1.76, 3021)

addWeapon(1073, "Spiked Knuckles", DMG_SLASH, "primary", "weapon_spikedknuckles", "models/Halokiller38/fallout/weapons/Melee/spikedknuckles.mdl", 1120, 2.5, 1350, 30, 28, 32, 40, 1.76, nil)

// Level 31:
addWeapon(1018, "Switchblade", DMG_SLASH, "secondary", "weapon_switchblade", "models/Halokiller38/fallout/weapons/Melee/switchblade.mdl", 1120, 2.5, 3727, 31, 34, 36, 40, 1.76, nil)

// Level 32:
addWeapon(1002, "Chinese Assault Rifle", DMG_BULLET, "primary", "weapon_chineseassaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/chineseassaultrifle.mdl", 1120, 2.5, 3874, 32, 28, 32, 16, 1.76, 3015)

addWeapon(1066, "Sniper Rifle", DMG_BULLET, "primary", "weapon_sniperriflesil", "models/Halokiller38/fallout/weapons/SniperRifles/sniperriflesupressor.mdl", 1120, 2.5, 3874, 32, 54, 68, 40, 1.76, 3002)

// Level 33:
addWeapon(1020, "Cattle Prod", DMG_CLUB, "secondary", "weapon_cattleprod", "models/Halokiller38/fallout/weapons/Melee/cattleprod.mdl", 1120, 2.5, 4235, 33, 38, 44, 16, 1.76, nil)

// Level 34:
addWeapon(1036, "Laser RCW", DMG_SONIC, "primary", "weapon_laserpdw", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpdw.mdl", 1120, 2.5, 7369, 34, 30, 36, 12, 1.76, 3020)

addWeapon(1060, "Railway Rifle", DMG_BULLET, "primary", "weapon_railwayrifle", "models/Halokiller38/fallout/weapons/Rifles/railwayrifle.mdl", 1120, 2.5, 4304, 34, 60, 74, 35, 1.76, 3026)

// Level 35:
addWeapon(1013, "Kitchen Knife", DMG_SLASH, "secondary", "weapon_kitchenknife", "models/Halokiller38/fallout/weapons/Melee/kitchenknife.mdl", 1120, 2.5, 4813, 35, 36, 38
,  45, 1.76, nil)

// Level 36:

addWeapon(1003, "R91 Assault Rifle", DMG_BULLET, "primary", "weapon_r91assaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/r91assaultrifle.mdl", 1120, 2.5, 4782, 36, 32, 36, 22, 1.76, 3015)

// Level 37:

addWeapon(1030, "Sledge Hammer", DMG_SLASH, "secondary", "weapon_sledgehammer", "models/Halokiller38/fallout/weapons/Melee/sledgehammer.mdl", 1120, 2.5, 5175, 37, 50, 60, 16, 1.76, nil)

// Level 38:

addWeapon(1046, ".44 Magnum Revolver", DMG_BULLET, "secondary", "weapon_44revolver", "models/Halokiller38/fallout/weapons/Pistols/44magnumrevolver.mdl", 1120, 2.5, 5314, 38, 46, 52, 16, 1.76, 3005)

// Level 39:
addWeapon(1009, "Cleaver", DMG_SLASH, "secondary", "weapon_cleaver", "models/Halokiller38/fallout/weapons/Melee/cleaver.mdl", 1120, 2.5, 5565, 39, 38, 40, 50, 1.76,nil)

// Level 40:
addWeapon(1034, "Gatling Laser", DMG_SONIC, "primary", "weapon_gatlinglaser", "models/Halokiller38/fallout/weapons/Energy Weapons/gatlinglaser.mdl", 1120, 2.5, 8670, 40, 15, 20, 15, 1.76, 3020)

addWeapon(1043, "Minigun", DMG_BULLET, "primary", "weapon_minigun", "models/halokiller38/fallout/weapons/heavy weapons/minigun.mdl", 1120, 2.5, 5904, 40, 18, 22, 18, 1.76, 3016)

addWeapon(1053, "Hunting Revolver", DMG_BULLET, "secondary", "weapon_huntingrevolver", "models/Halokiller38/fallout/weapons/Pistols/huntingrevolver.mdl", 1120, 2.5, 5904, 40, 56, 60, 22, 1.76, 3007)

// Level 41:
addWeapon(1012, "Hatchet", DMG_SLASH, "secondary", "weapon_hatchet", "models/Halokiller38/fallout/weapons/Melee/hatchet.mdl", 1120, 2.5, 5984, 41, 42, 44, 55, 1.76, nil)

// Level 42:

addWeapon(1004, "Service Rifle", DMG_BULLET, "primary", "weapon_serviceriflereflex", "models/Halokiller38/fallout/weapons/AssaultRifles/battlerifleap.mdl", 1120, 2.5, 6561, 42, 42, 48, 30, 1.76, 3015)

// Level 43:
addWeapon(1028, "Rebar Club", DMG_CLUB, "secondary", "weapon_rebarclub", "models/Halokiller38/fallout/weapons/Melee/rebar.mdl", 1120, 2.5, 6434, 43, 68, 80, 25, 1.76, nil)

// Level 44:
addWeapon(1061, "Varmint Rifle", DMG_BULLET, "primary", "weapon_varmintriflesilext", "models/Halokiller38/fallout/weapons/Rifles/varmintriflesilext.mdl", 1120, 2.5, 7290, 44, 72, 82, 42, 1.76, 3015)

// Level 45:
addWeapon(1039, "Modified Multiplas Rifle", DMG_SONIC, "primary", "weapon_multiplasrifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/multiplasrifle.mdl", 1120, 2.5, 12000, 50, 5, 8, 38, 1.76, 3023)

addWeapon(1007, "Chance's Knife", DMG_SLASH, "secondary", "weapon_chancesknife", "models/Halokiller38/fallout/weapons/Melee/chancesknife.mdl", 1120, 2.5, 6919, 45, 44, 46, 60, 1.76, nil)

// Level 46:
addWeapon(1055, "Ranger Sequoia", DMG_BULLET, "secondary", "weapon_rangersequoia", "models/Halokiller38/fallout/weapons/Pistols/rangersequoia.mdl", 1120, 2.5, 8100, 46, 70, 76, 22, 1.76, 3007)

// Level 47:

addWeapon(1005, "Bowie Knife", DMG_SLASH, "secondary", "weapon_bowieknife", "models/Halokiller38/fallout/weapons/Melee/bowieknife.mdl", 1120, 2.5, 7440, 47, 12, 25, 65, 1.76, nil)

//Level 48:
addWeapon(1062, "Combat Shotgun", DMG_BULLET, "primary", "weapon_combatshotgun", "models/Halokiller38/fallout/weapons/Shotguns/combatshotgun.mdl", 1120, 2.5, 9000, 48, 70, 100, 35, 1.76, 3012)

//Level 49:
addWeapon(1072, "Deathclaw Gauntlet", DMG_SLASH, "primary", "weapon_deathclawgauntlet", "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 1120, 2.5, 2360, 49, 66, 74, 65, 1.76, nil)

//Level 50:
addWeapon(1065, "Anti-Material Rifle", DMG_BULLET, "primary", "weapon_antimaterielrifle", "models/Halokiller38/fallout/weapons/SniperRifles/antimaterielrifle.mdl", 1120, 2.5, 10000, 50, 94, 110, 65, 1.76, 3008)
addWeapon(1042, "Plasma Rifle", DMG_PLASMA, "primary", "weapon_plasmarifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmarifle.mdl", 1120, 2.5, 10200, 50, 84, 96, 25, 1.76, 3023)

addWeapon(1010, "Combat Knife", DMG_SLASH, "secondary", "weapon_combatknife", "models/Halokiller38/fallout/weapons/Melee/combatknife.mdl", 1120, 2.5, 8000, 50, 50, 54, 70, 1.76, nil)

addWeapon(1031, "Super Sledge", DMG_CLUB, "secondary", "weapon_supersledge", "models/Halokiller38/fallout/weapons/Melee/supersledge.mdl", 1120, 2.5, 8000, 50, 96, 114, 30, 1.76, nil)
