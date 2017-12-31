
//Server
function createApparel(item, quantity, useLower, useHigher)
	local apparel = findApparel(item.classid)
	local damageThreshold
	local damageReflection
	local bonusHp
	local durability = apparel:getMaxDurability()

	if useLower then
		damageThreshold = math.random(apparel:getMinDamageThreshold(), apparel:getMedianDamageThreshold())
		damageReflection = math.random(apparel:getMinDamageReflection(), apparel:getMedianDamageReflection())
		bonusHp = math.random(apparel:getMinBonusHp(), apparel:getMedianBonusHp())
	elseif useHigher then
		damageThreshold = math.random(apparel:getMedianDamageThreshold(), apparel:getMaxDamageThreshold())
		damageReflection = math.random(apparel:getMedianDamageReflection(), apparel:getMaxDamageReflection())
		bonusHp = math.random(apparel:getMedianBonusHp(), apparel:getMaxBonusHp())
	else
		damageThreshold = math.random(apparel:getMinDamageThreshold(), apparel:getMaxDamageThreshold())
		damageReflection = math.random(apparel:getMinDamageReflection(), apparel:getMaxDamageReflection())
		bonusHp = math.random(apparel:getMinBonusHp(), apparel:getMaxBonusHp())
	end

	item.damageThreshold = damageThreshold
	item.damageReflection = damageReflection
	item.bonusHp = bonusHp
	item.durability = durability

	return item
end
