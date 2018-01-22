
// Server
function createWeapon(item, quantity, useLower, useHigher)
	local weapon = findWeapon(item.classid)
	local damage, durability
	
	if useLower then
		damage = math.random(weapon:getMinDamage(), weapon:getMedianDamage())
		durability = weapon:getMaxDurability()
	elseif useHigher then
		damage = math.random(weapon:getMedianDamage(), weapon:getMaxDamage())
		durability = weapon:getMaxDurability()
	else
		damage = math.random(weapon:getMinDamage(), weapon:getMaxDamage())
		durability = weapon:getMaxDurability()
	end

	item.damage = damage
	item.durability = durability

	return item
end
