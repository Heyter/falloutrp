
local meta = FindMetaTable("Player")

Weapons = {}

function addWeapon(id, name, type, entity, model, minDamage, maxDamage, fireRate, criticalChance, criticalDamage, actionPoints, weaponSpread, ammoType, magazineCapacity, durability, weight, value, strength)
	Weapons[id] = {
		name = name,
		type = type,
		entity = entity,
		model = model,
		minDamage = minDamage,
		maxDamage = maxDamage,
		fireRate = fireRate, 
		criticalChance = criticalChance,
		criticalDamage = criticalDamage,
		actionPoints = actionPoints,
		weaponSpread = weaponSpread,
		ammoType = ammoType,
		magazineCapacity = magazineCapacity,
		durability = durability,
		weight = weight,
		value = value,
		strength = strength
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
function getWeaponEntity(id)
	print(id)
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
function getWeaponStrength(id)
	return findWeapon(id).strength
end
function getWeaponCriticalDamage(id)
	return findWeapon(id).criticalDamage
end

// Functions that have data which can change
function meta:getWeaponDamage(uniqueId)
	return self.inventory.weapons[uniqueId]["damage"] or 0
end
function meta:getWeaponDurability(uniqueId)
	return self.inventory.weapons[uniqueId]["durability"] or 0
end

addWeapon(1001, "Lucky", "secondary", "weapon_9mmpistolmaria", "models/Halokiller38/fallout/weapons/Pistols/9mmunique.mdl", 30, 50, 82.5, 2.75, 30, 1.76, 0.3, ".357 magnum round", 6, 1120, 2.5, 1500, 3)
addWeapon(1002, "R91 Assault Rifle", "primary", "weapon_r91assaultrifle", "models/Halokiller38/fallout/weapons/AssaultRifles/r91assaultrifle.mdl", 30, 50, 82.5, 2.75, 30, 1.76, 0.3, "556mmammo", 6, 1120, 2.5, 1500, 3)