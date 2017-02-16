
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

// Adding weapons below here
addWeapon(1001, "Assault Carbine", DMG_BULLET, "primary", "weapon_assaultcarbinesil", "models/Halokiller38/fallout/weapons/AssaultRifles/assaultcarbinesilencer.mdl", 1120, 2.5, 570, 2, 10, 15, 2.75, 1.76, 3016)

addWeapon(1002, "Chinese Assault Rifle", DMG_BULLET, "primary", "weapon_chineseassaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/chineseassaultrifle.mdl", 1120, 2.5, 645, 10, 20, 30, 7, 1.76, 3015)

addWeapon(1003, "R91 Assault Rifle", DMG_BULLET, "primary", "weapon_r91assaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/r91assaultrifle.mdl", 1120, 2.5, 910, 15, 35, 45, 15, 1.76, 3015)

addWeapon(1004, "Service Rifle", DMG_BULLET, "primary", "weapon_serviceriflereflex", "models/Halokiller38/fallout/weapons/AssaultRifles/battlerifleap.mdl", 1120, 2.5, 770, 20, 30, 35, 5, 1.76, 3015)

addWeapon(1005, "Bowie Knife", DMG_SLASH, "secondary", "weapon_bowieknife", "models/Halokiller38/fallout/weapons/Melee/bowieknife.mdl", 1120, 2.5, 235, 3, 12, 25, 30, 1.76, nil)
addWeapon(1006, "Bumper Sword", DMG_SLASH, "secondary", "weapon_bumpersword", "models/Halokiller38/fallout/weapons/Melee/bumpersword.mdl", 1120, 2.5, 435, 6, 17, 33, 15, 1.76, nil)
addWeapon(1007, "Chance's Knife", DMG_SLASH, "secondary", "weapon_chancesknife", "models/Halokiller38/fallout/weapons/Melee/chancesknife.mdl", 1120, 2.5, 1900, 21, 50, 55, 30, 1.76, nil)
addWeapon(1008, "Chinese Officer Sword", DMG_SLASH, "secondary", "weapon_chineseofficersword", "models/Halokiller38/fallout/weapons/Melee/chineseofficersword.mdl", 1120, 2.5, 3575, 31, 65, 75, 35, 1.76, nil)
addWeapon(1009, "Cleaver", DMG_SLASH, "secondary", "weapon_cleaver", "models/Halokiller38/fallout/weapons/Melee/cleaver.mdl", 1120, 2.5, 1200, 4, 25, 30, 10, 1.76,nil)
addWeapon(1010, "Combat Knife", DMG_SLASH, "secondary", "weapon_combatknife", "models/Halokiller38/fallout/weapons/Melee/combatknife.mdl", 1120, 2.5, 1170, 10, 30, 40, 30, 1.76, nil)
addWeapon(1011, "Fireaxe", DMG_SLASH, "secondary", "weapon_fireaxe", "models/Halokiller38/fallout/weapons/Melee/fireaxe.mdl", 1120, 2.5, 500, 1, 15, 25, 7.5, 1.76, nil)
addWeapon(1012, "Hatchet", DMG_SLASH, "secondary", "weapon_hatchet", "models/Halokiller38/fallout/weapons/Melee/hatchet.mdl", 1120, 2.5, 355, 7, 20, 35, 20, 1.76, nil)
addWeapon(1013, "Kitchen Knife", DMG_SLASH, "secondary", "weapon_kitchenknife", "models/Halokiller38/fallout/weapons/Melee/kitchenknife.mdl", 1120, 2.5, 5000, 1, 30, 50, 62.5, 2.75, 1.76, nil)
addWeapon(1014, "Lily's Vertibird Blade", DMG_SLASH, "secondary", "weapon_lilysblade", "models/Halokiller38/fallout/weapons/Melee/lilysblade.mdl", 1120, 2.5, 2000, 5, 1, 125, 75, 1.76, nil)
addWeapon(1015, "Machete", DMG_SLASH, "secondary", "weapon_machete", "models/Halokiller38/fallout/weapons/Melee/machete.mdl", 1120, 2.5, 300, 1, 10, 20, 10, 1.76,nil)
addWeapon(1016, "Machete Gladius", DMG_SLASH, "secondary", "weapon_machetegladius", "models/Halokiller38/fallout/weapons/Melee/machetegladius.mdl", 1120, 2.5, 950, 14, 25, 35, 50, 1.76, nil)
addWeapon(1017, "Straight Razor", DMG_SLASH, "secondary", "weapon_straightrazor", "models/Halokiller38/fallout/weapons/Melee/straightrazor.mdl", 1120, 2.5, 525, 2, 15, 25, 2.75,  1.76, nil)
addWeapon(1018, "Switchblade", DMG_SLASH, "secondary", "weapon_switchblade", "models/Halokiller38/fallout/weapons/Melee/switchblade.mdl", 1120, 2.5, 1725, 28, 40, 50, 80, 1.76, nil)
addWeapon(1019, "Straight Razor", DMG_SLASH, "secondary", "weapon_trenchknife", "models/Halokiller38/fallout/weapons/Melee/trenchknife.mdl", 1120, 2.5, 1825, 19, 35, 40, 50, 1.76, nil)
addWeapon(1020, "Cattle Prod", DMG_SLASH, "secondary", "weapon_cattleprod", "models/Halokiller38/fallout/weapons/Melee/cattleprod.mdl", 1120, 2.5, 100, 1, 10, 15, 1, 1.76, nil)
addWeapon(1021, "Dirty Baseball Bat", DMG_SLASH, "secondary", "weapon_bballbatdirty", "models/Halokiller38/fallout/weapons/Melee/baseballbatdirty.mdl", 1120, 2.5, 150, 1, 10, 20, 5, 1.76, nil)
addWeapon(1022, "Dress Cane", DMG_SLASH, "secondary", "weapon_dresscane", "models/Halokiller38/fallout/weapons/Melee/dresscane.mdl", 1120, 2.5, 500, 1, 20, 25, 10, 1.76, nil)
addWeapon(1023, "Lead Pipe", DMG_SLASH, "secondary", "weapon_leadpipe", "models/Halokiller38/fallout/weapons/Melee/leadpipe.mdl", 1120, 2.5, 200 , 1, 10, 20, 5, 1.76, nil)
addWeapon(1024, "Nail Board", DMG_SLASH, "secondary", "weapon_nailboard", "models/Halokiller38/fallout/weapons/Melee/nailboard.mdl", 1120, 2.5, 200, 1, 10, 20, 5, 1.76, nil)
addWeapon(1025, "Nine Iron", DMG_SLASH, "secondary", "weapon_nineiron", "models/Halokiller38/fallout/weapons/Melee/9iron.mdl", 1120, 2.5, 300, 1, 15, 25, 3, 1.76, nil)
addWeapon(1026, "Police Baton", DMG_SLASH, "secondary", "weapon_policebaton", "models/Halokiller38/fallout/weapons/Melee/baton.mdl", 1120, 2.5, 500, 1, 20, 25, 5, 2.75, nil)
addWeapon(1027, "Pool Cue", DMG_SLASH, "secondary", "weapon_poolcue", "models/Halokiller38/fallout/weapons/Melee/poolcue.mdl", 1120, 2.5, 550, 1, 20, 25, 10, 1.76, nil)
addWeapon(1028, "Rebar Club", DMG_SLASH, "secondary", "weapon_rebarclub", "models/Halokiller38/fallout/weapons/Melee/rebar.mdl", 1120, 2.5, 750, 12, 30, 50, 10, 1.76, nil)
addWeapon(1029, "Shovel", DMG_SLASH, "secondary", "weapon_shovel", "models/Halokiller38/fallout/weapons/Melee/shovel.mdl", 1120, 2.5, 100, 1, 10, 15, 5, 1.76,  nil)
addWeapon(1030, "Sledge Hammer", DMG_SLASH, "secondary", "weapon_sledgehammer", "models/Halokiller38/fallout/weapons/Melee/sledgehammer.mdl", 1120, 2.5, 300, 1, 15, 25, 10, 1.76, nil)
addWeapon(1031, "Super Sledge", DMG_SLASH, "secondary", "weapon_supersledge", "models/Halokiller38/fallout/weapons/Melee/supersledge.mdl", 1120, 2.5, 400, 11, 35, 50, 20, 1.76, nil)
addWeapon(1032, "Tire Iron", DMG_SLASH, "secondary", "weapon_tireiron", "models/Halokiller38/fallout/weapons/Melee/tireiron.mdl", 1120, 2.5, 550, 1, 20, 30, 10, 1.76,  nil)

addWeapon(1033, "Automatic Plasma Defender", DMG_PLASMA, "primary", "weapon_plasmadefender", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmadefender.mdl", 1120, 2.5, 3000, 36, 30, 50, 2.75, 1.76, 3021)

addWeapon(1034, "Gatling Laser", DMG_SONIC, "primary", "weapon_gatlinglaser", "models/Halokiller38/fallout/weapons/Energy Weapons/gatlinglaser.mdl", 1120, 2.5, 5000, 44, 30, 50, 5, 1.76, 3020)
addWeapon(1035, "Laser Pistol", DMG_SONIC, "secondary", "weapon_laserpistol", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpistol.mdl", 1120, 2.5, 3200, 35, 40, 55, 2.75, 1.76, 3021)
addWeapon(1036, "Laser RCW", DMG_SONIC, "primary", "weapon_laserpdw", "models/Halokiller38/fallout/weapons/Energy Weapons/laserpdw.mdl", 1120, 2.5, 5000, 37, 45, 60, 15, 1.76, 3020)
addWeapon(1037, "Laser Rifle", DMG_SONIC, "primary", "weapon_laserrifle", "models/Halokiller38/fallout/weapons/Energy Weapons/laserrifle.mdl", 1120, 2.5, 5500, 38, 50, 65, 20, 1.76, 3023)
addWeapon(1038, "Laser Rifle (Scope)", DMG_SONIC, "primary", "weapon_laserriflescp", "models/Halokiller38/fallout/weapons/Energy Weapons/laserriflescope.mdl", 1120, 2.5, 5600, 43, 50, 70, 25, 1.76, 3023)
addWeapon(1039, "Modified Multiplas Rifle", DMG_SONIC, "primary", "weapon_multiplasrifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/multiplasrifle.mdl", 1120, 2.5, 2620, 25, 30, 40, 10, 1.76, 3023)

addWeapon(1040, "Modified Tribeam Rifle", DMG_SONIC, "primary", "weapon_tribeam", "models/Halokiller38/fallout/weapons/Energy Weapons/tribeamlaserrifle.mdl", 1120, 2.5, 2620, 30, 30, 50, 15, 1.76, 3023)

addWeapon(1041, "Plasma Pistol", DMG_PLASMA, "secondary", "weapon_plasmapistol", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmapistol.mdl", 1120, 2.5, 2760, 18, 20, 35, 20, 1.76, 3021)

addWeapon(1042, "Plasma Rifle", DMG_PLASMA, "primary", "weapon_plasmarifle", "models/Halokiller38/fallout/weapons/Plasma Weapons/plasmarifle.mdl", 1120, 2.5, 2860, 30, 50, 70, 2.75, 1.76, 3021)

addWeapon(1043, "Minigun", DMG_BULLET, "primary", "weapon_minigun", "models/halokiller38/fallout/weapons/heavy weapons/minigun.mdl", 1120, 2.5, 6000, 44, 40, 60, 10, 1.76, 3016)

addWeapon(1044, "Maria", DMG_BULLET, "secondary", "weapon_9mmpistolmaria", "models/Halokiller38/fallout/weapons/Pistols/9mmunique.mdl", 1120, 2.5, 500, 1, 15, 25, 5, 1.76, 3017)
addWeapon(1045, ".357 Magnum Revolver", DMG_BULLET, "secondary", "weapon_357revolverlonghdcyl", "models/Halokiller38/fallout/weapons/Pistols/357revolverhdcyl.mdl", 1120, 2.5, 2060, 15, 30, 50, 10, 1.76, 3004)
addWeapon(1046, ".44 Magnum Revolver", DMG_BULLET, "secondary", "weapon_44revolver", "models/Halokiller38/fallout/weapons/Pistols/44magnumrevolver.mdl", 1120, 2.5, 2360, 16, 35, 55, 15, 1.76, 3005)
addWeapon(1047, ".45 Auto Pistol", DMG_BULLET, "secondary", "weapon_45autopistol", "models/Halokiller38/fallout/weapons/Pistols/45pistol.mdl", 1120, 2.5, 1820, 17, 20, 40, 10, 1.76, 3006)
addWeapon(1048, "10mm Pistol", DMG_BULLET, "secondary", "weapon_10mmpistol", "models/Halokiller38/fallout/weapons/pistols/10mmpistol.mdl", 1120, 2.5, 570, 4, 10, 20, 5, 1.76, 3009)
addWeapon(1049, "12.7mm Pistol", DMG_BULLET, "secondary", "weapon_127mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/127mmpistolsilencer.mdl", 1120, 2.5, 1770, 18, 25, 35, 10, 1.76, 3011)
addWeapon(1050, "9mm Pistol", DMG_BULLET, "secondary", "weapon_9mmpistol", "models/Halokiller38/fallout/weapons/Pistols/9mmpistol.mdl", 1120, 2.5, 750, 5, 15, 25, 5, 1.76, 3017)
addWeapon(1051, "Light in Darkness", DMG_BULLET, "secondary", "weapon_45autopistolu", "models/Halokiller38/fallout/weapons/Pistols/45autopistolunique.mdl", 1120, 2.5, 2760, 23, 25, 45, 12, 1.76, 3006)
addWeapon(1052, "Chinese Pistol", DMG_BULLET, "secondary", "weapon_chinesepistol", "models/Halokiller38/fallout/weapons/Pistols/chinesepistol.mdl", 1120, 2.5, 2950, 24, 30, 50, 10, 1.76, 3009)
addWeapon(1053, "Hunting Revolver", DMG_BULLET, "secondary", "weapon_huntingrevolver", "models/Halokiller38/fallout/weapons/Pistols/huntingrevolver.mdl", 1120, 2.5, 4460, 29, 30, 60, 15, 1.76, 3007)
addWeapon(1054, "Police Pistol", DMG_BULLET, "secondary", "weapon_policepistol", "models/Halokiller38/fallout/weapons/Pistols/policepistol.mdl", 1120, 2.5, 4620, 30, 35, 60, 20, 1.76, 3004)
addWeapon(1055, "Ranger Sequoia", DMG_BULLET, "secondary", "weapon_rangersequoia", "models/Halokiller38/fallout/weapons/Pistols/rangersequoia.mdl", 1120, 2.5, 3970, 31, 40, 50, 10, 1.76, 3007)
addWeapon(1056, "Silence .22", DMG_BULLET, "secondary", "weapon_22mmpistolsil", "models/Halokiller38/fallout/weapons/Pistols/silenced22pistol.mdl", 1120, 2.5, 740, 8, 15, 30, 10, 1.76, 3007)

addWeapon(1057, "Battle Rifle", DMG_BULLET, "primary", "weapon_battlerifle", "models/Halokiller38/fallout/weapons/Rifles/thismachine.mdl", 1120, 2.5, 970, 10, 20, 30, 2.75, 5, 3002)
addWeapon(1058, "Hunting Rifle", DMG_BULLET, "primary", "weapon_huntingrifleext", "models/Halokiller38/fallout/weapons/Rifles/huntingrifleext.mdl", 1120, 2.5, 2870, 20, 30, 40, 15, 1.76, 3002)
addWeapon(1059, "Hunting Rifle (Scope)", DMG_BULLET, "primary", "weapon_huntingriflescp", "models/Halokiller38/fallout/weapons/Rifles/huntingriflescoped.mdl", 1120, 2.5, 5470, 32, 40, 50, 15, 1.76, 3002)
addWeapon(1060, "Railway Rifle", DMG_BULLET, "primary", "weapon_railwayrifle", "models/Halokiller38/fallout/weapons/Rifles/railwayrifle.mdl", 1120, 2.5, 4560, 33, 40, 60, 2.75, 1.76, 3026)
addWeapon(1061, "Varmint Rifle", DMG_BULLET, "primary", "weapon_varmintriflesilext", "models/Halokiller38/fallout/weapons/Rifles/varmintriflesilext.mdl", 1120, 2.5, 400, 1, 15, 20, 10, 1.76, 3015)
addWeapon(1062, "Combat Shotgun", DMG_BULLET, "primary", "weapon_combatshotgun", "models/Halokiller38/fallout/weapons/Shotguns/combatshotgun.mdl", 1120, 2.5, 850, 5, 20, 30, 10, 1.76, 3012)
addWeapon(1063, "Hunting Shotgun", DMG_BULLET, "primary", "weapon_huntingshotgun", "models/Halokiller38/fallout/weapons/Shotguns/huntingshotgun.mdl", 1120, 2.5, 2500, 34, 40, 60, 20, 1.76, 3010)
addWeapon(1064, "Riot Shotgun", DMG_BULLET, "primary", "weapon_riotshotgun", "models/Halokiller38/fallout/weapons/Shotguns/riotshotgun.mdl", 1120, 2.5, 2750, 39, 45, 70, 25, 1.76, 3010)
addWeapon(1065, "Anti-Material Rifle", DMG_BULLET, "primary", "weapon_antimaterielrifle", "models/Halokiller38/fallout/weapons/SniperRifles/antimaterielrifle.mdl", 1120, 2.5, 5000, 45, 70, 90, 40, 1.76, 3008)
addWeapon(1066, "Sniper Rifle", DMG_BULLET, "primary", "weapon_sniperriflesil", "models/Halokiller38/fallout/weapons/SniperRifles/sniperriflesupressor.mdl", 1120, 2.5, 4000, 40, 40, 70, 40, 1.76, 3002)

addWeapon(1067, ".45 Sub-Machine Gun", DMG_BULLET, "primary", "weapon_45smg", "models/Halokiller38/fallout/weapons/SMGs/45smg.mdl", 1120, 2.5, 910, 8, 20, 30, 5, 1.76, 3006)

addWeapon(1068, "10mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_10mmsmgext", "models/weapons/w_Pistol.mdl", 1120, 2.5, 780, 7, 15, 30, 5, 1.76, 3009)
addWeapon(1069, "12.7mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_127mmsmgsil", "models/Halokiller38/fallout/weapons/SMGs/127smgsilencer.mdl", 1120, 2.5, 3000, 41, 30, 50, 15, 1.76, 3011)
addWeapon(1070, "9mm Sub-Machine Gun", DMG_BULLET, "primary", "weapon_9mmsmgdrum", "models/Halokiller38/fallout/weapons/SMGs/9mmsmgdrum.mdl", 1120, 2.5, 3200, 41, 40, 55, 20, 1.76, 3017)

addWeapon(1071, "Brass Knuckles", DMG_SLASH, "primary", "weapon_brassknuckles", "models/Halokiller38/fallout/weapons/Melee/brassknuckles.mdl", 1120, 2.5, 1090, 9, 20, 30, 20, 1.76, nil)
addWeapon(1072, "Deathclaw Gauntlet", DMG_SLASH, "primary", "weapon_deathclawgauntlet", "models/Halokiller38/fallout/weapons/Melee/deathclawgauntlet.mdl", 1120, 2.5, 2360, 25, 35, 60, 65, 1.76, nil)
addWeapon(1073, "Spiked Knuckles", DMG_SLASH, "primary", "weapon_spikedknuckles", "models/Halokiller38/fallout/weapons/Melee/spikedknuckles.mdl", 1120, 2.5, 1350, 9, 30, 50, 25, 1.76, nil)

addWeapon(1074, "Lockpick", DMG_SLASH, "primary", "lockpick", "models/weapons/w_crowbar.mdl", 1120, 2.5, 130, 2, 0, 0, 2.75, 1.76, nil)
addWeapon(1075, "Pickaxe", DMG_SLASH, "primary", "eoti_tool_miningpick", "models/pickaxe/pickaxe_w.mdl", 1120, 2.5, 55, 1, 0, 0, 2.75, 1.76, nil)





