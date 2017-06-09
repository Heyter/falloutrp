
//Server
function createApparel(item, quantity, useLower, useHigher)
	local damageThreshold
	local damageReflection
	local bonusHp
	local durability = getApparelMaxDurability(item.classid)

	if useLower then
		damageThreshold = math.random(getApparelMinDamageThreshold(item.classid), getApparelMedianDamageThreshold(item.classid))
		damageReflection = math.random(getApparelMinDamageReflection(item.classid), getApparelMedianDamageReflection(item.classid))
		bonusHp = math.random(getApparelMinBonusHp(item.classid), getApparelMedianBonusHp(item.classid))
	elseif useHigher then
		damageThreshold = math.random(getApparelMedianDamageThreshold(item.classid), getApparelMaxDamageThreshold(item.classid))
		damageReflection = math.random(getApparelMedianDamageReflection(item.classid), getApparelMaxDamageReflection(item.classid))
		bonusHp = math.random(getApparelMedianBonusHp(item.classid), getApparelMaxBonusHp(item.classid))
	else
		damageThreshold = math.random(getApparelMinDamageThreshold(item.classid), getApparelMaxDamageThreshold(item.classid))
		damageReflection = math.random(getApparelMinDamageReflection(item.classid), getApparelMaxDamageReflection(item.classid))
		bonusHp = math.random(getApparelMinBonusHp(item.classid), getApparelMaxBonusHp(item.classid))
	end

	item.damageThreshold = damageThreshold
	item.damageReflection = damageReflection
	item.bonusHp = bonusHp
	item.durability = durability

	return item
end
