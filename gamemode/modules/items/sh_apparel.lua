
local meta = FindMetaTable("Player")

Apparel = {}

function addApparel(id, name, slot, model, durability, weight, value, level, minDamageThreshold, maxDamageThreshold, minDamageReflection, maxDamageReflection, minBonusHp, maxBonusHp)
	Apparel[id] = {
		name = name,
		slot = slot,
		model = model,
		durability = durability,
		weight = weight,
		value = value,
		level = level,
		minDamageThreshold = minDamageThreshold,
		maxDamageThreshold = maxDamageThreshold,
		minDamageReflection = minDamageReflection,
		maxDamageReflection = maxDamageReflection,
		minBonusHp = minBonusHp,
		maxBonusHp = maxBonusHp
	}
end

function findApparel(id)
	if id then
		return Apparel[id]
	end
end

// Base functions that have data that will not change
function getApparelName(id)
	return findApparel(id).name
end
function getApparelSlot(id)
	return findApparel(id).slot
end
function getApparelModel(id)
	return findApparel(id).model
end
function getApparelWeight(id)
	return findApparel(id).weight
end
function getApparelValue(id)
	return findApparel(id).value
end
function getApparelLevel(id)
	return findApparel(id).level
end
function getApparelMaxDurability(id)
	return findApparel(id).durability
end
function getApparelMinDamageThreshold(id)
	return findApparel(id).minDamageThreshold
end
function getApparelMaxDamageThreshold(id)
	return findApparel(id).maxDamageThreshold
end
function getApparelMinDamageReflection(id)
	return findApparel(id).minDamageReflection or 0
end
function getApparelMaxDamageReflection(id)
	return findApparel(id).maxDamageReflection or 0
end
function getApparelMinBonusHp(id)
	return findApparel(id).minBonusHp or 0
end
function getApparelMaxBonusHp(id)
	return findApparel(id).maxBonusHp or 0
end

// Functions that have data which can change
function meta:getApparelDamageThreshold(uniqueid, location)
	local location = location or "inventory"
	
	return self[location].apparel[uniqueid]["damageThreshold"] or 0
end
function meta:getApparelDurability(uniqueid, location)
	local location = location or "inventory"
	
	return self[location].apparel[uniqueid]["durability"] or 0
end
function meta:getApparelDamageReflection(uniqueid, location)
	local location = location or "inventory"
	
	return self[location].apparel[uniqueid]["damageReflection"] or 0
end
function meta:getApparelBonusHp(uniqueid, location)
	local location = location or "inventory"
	
	return self[location].apparel[uniqueid]["bonusHp"] or 0
end

addApparel(2001, "Hard hat", "helmet", "models/props_2fort/hardhat001.mdl", 1000, 2.5, 900, 1, 5, 10)
