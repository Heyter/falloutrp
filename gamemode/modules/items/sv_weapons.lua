
// Server
function createWeapon(item, quantity, useLower, useHigher)
	local damage, durability
	if useLower then
		damage = math.random(getWeaponMinDamage(item.classid), getWeaponMedianDamage(item.classid))
		durability = getWeaponMaxDurability(item.classid)
	elseif useHigher then
		damage = math.random(getWeaponMedianDamage(item.classid), getWeaponMaxDamage(item.classid))
		durability = getWeaponMaxDurability(item.classid)
	else
		damage = math.random(getWeaponMinDamage(item.classid), getWeaponMaxDamage(item.classid))
		durability = getWeaponMaxDurability(item.classid)
	end

	item.damage = damage
	item.durability = durability

	return item
end
