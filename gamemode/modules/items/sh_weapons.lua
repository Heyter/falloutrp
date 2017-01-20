
local meta = FindMetaTable("Player")

Weapons = {}

function addWeapon(id, name, type, slot, entity, model, durability, weight, value, level, minDamage, maxDamage, fireRate, criticalChance, criticalDamage, actionPoints, weaponSpread, ammoType, magazineCapacity)
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
		fireRate = fireRate, 
		criticalChance = criticalChance,
		criticalDamage = criticalDamage,
		actionPoints = actionPoints,
		weaponSpread = weaponSpread,
		ammoType = ammoType,
		magazineCapacity = magazineCapacity
	}
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
function getWeaponCriticalDamage(id)
	return findWeapon(id).criticalDamage
end
function getWeaponMaxDurability(id)
	return findWeapon(id).durability
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

addWeapon(1001, "Lucky", DMG_BULLET, "secondary", "weapon_9mmpistolmaria", "models/Halokiller38/fallout/weapons/Pistols/9mmunique.mdl", 1120, 2.5, 1500, 3, 30, 50, 82.5, 2.75, 30, 1.76, 0.3, ".357 magnum round", 6)
addWeapon(1002, "R91 Assault Rifle", DMG_BULLET, "primary", "weapon_r91assaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/r91assaultrifle.mdl", 1120, 2.5, 1500, 3, 30, 50, 82.5, 2.75, 30, 1.76, 0.3, "556mmammo", 6)
addWeapon(1003, "Hunting Shotgun", DMG_BULLET, "primary", "weapon_huntingshotgun", "models/Halokiller38/fallout/weapons/Shotguns/huntingshotgun.mdl", 1120, 2.5, 1500, 3, 30, 50, 82.5, 2.75, 30, 1.76, 0.3, "556mmammo", 6)