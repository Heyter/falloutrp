
Weapons = {}

function addWeapon(id, name, damage, fireRate, criticalChance, criticalDamage, actionPoints, weaponSpread, ammoType, magazineCapacity, durability, weight, caps, strength)
	Weapons[id] = {
		name = name,
		damage = damage,
		fireRate = fireRate, 
		criticalChance = criticalChance,
		criticalDamage = criticalDamage,
		actionPoints = actionPoints,
		weaponSpread = weaponSpread,
		ammoType = ammoType,
		magazineCapacity = magazineCapacity,
		durability = durability,
		weight = weight,
		caps = caps,
		strength = strength
	}
end

addWeapon(1001, "Lucky", 30, 82.5, 2.75, 30, 1.76, 0.3, ".357 magnum round", 6, 1120, 2.5, 1500, 3)