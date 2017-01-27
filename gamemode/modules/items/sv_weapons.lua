
// Server
function createWeapon(item)
	local damage = math.random(getWeaponMinDamage(item.classid), getWeaponMaxDamage(item.classid))
	local durability = getWeaponMaxDurability(item.classid)
	
	item.damage = damage
	item.durability = durability
	
	return item
end