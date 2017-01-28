
// Server
function createWeapon(item, quantity, useBase)
	local damage, durability
	if useBase then
		damage = math.random(getWeaponMinDamage(item.classid), math.floor((getWeaponMinDamage(item.classid) + getWeaponMaxDamage(item.classid))/2))
		durability = getWeaponMaxDurability(item.classid)
	else
		damage = math.random(getWeaponMinDamage(item.classid), getWeaponMaxDamage(item.classid))
		durability = getWeaponMaxDurability(item.classid)
	end
	
	item.damage = damage
	item.durability = durability
	
	return item
end