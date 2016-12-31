
//Server

local meta = FindMetaTable("Player")

function createWeapon(item)
	local damage = math.random(getWeaponMinDamage(item.classId), getWeaponMaxDamage(item.classId))
	
	item.damage = damage
	
	return item
end