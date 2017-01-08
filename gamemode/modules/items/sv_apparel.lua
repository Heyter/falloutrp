
//Server

local meta = FindMetaTable("Player")

function createApparel(item)
	local damageThreshold = math.random(getApparelMinDamageThreshold(item.classid), getApparelMaxDamageThreshold(item.classid))
	local damageReflection = math.random(getApparelMinDamageReflection(item.classid), getApparelMaxDamageReflection(item.classid))
	local bonusHp = math.random(getApparelMinBonusHp(item.classid), getApparelMaxBonusHp(item.classid))
	local durability = getApparelMaxDurability(item.classid)
	
	item.damageThreshold = damageThreshold
	item.damageReflection = damageReflection
	item.bonusHp = bonusHp
	item.durability = durability
	
	return item
end