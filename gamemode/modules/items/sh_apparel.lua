
local Apparel = {}

local meta = FindMetaTable("Player")

function addApparel(id, name, rarity, slot, model, durability, weight, value, level, minDamageThreshold, maxDamageThreshold, minDamageReflection, maxDamageReflection, minBonusHp, maxBonusHp)
	Apparel[id] = {
		name = name,
		rarity = rarity,
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

function getApparel()
	return Apparel
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
function getApparelRarity(id)
	return findApparel(id).rarity
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
function getApparelMedianDamageThreshold(id)
	return math.floor((findApparel(id).minDamageThreshold + findApparel(id).maxDamageThreshold) / 2)
end
function getApparelMaxDamageThreshold(id)
	return findApparel(id).maxDamageThreshold
end
function getApparelMinDamageReflection(id)
	return findApparel(id).minDamageReflection or 0
end
function getApparelMedianDamageReflection(id)
	return math.floor((getApparelMinDamageReflection(id) + getApparelMaxDamageReflection(id)) / 2)
end
function getApparelMaxDamageReflection(id)
	return findApparel(id).maxDamageReflection or 0
end
function getApparelMinBonusHp(id)
	return findApparel(id).minBonusHp or 0
end
function getApparelMedianBonusHp(id)
	return math.floor((getApparelMinBonusHp(id) + getApparelMaxBonusHp(id)) / 2)
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

//Level 1
// Cloth (Craftable)
addApparel(2003, "Green Rag Hat", RARITY_WHITE, "helmet", "IDK", 800, 0.5, 400, 1, 1, 1, 0, 0, 1, 2)
addApparel(2018, "Green Rags", "chest", RARITY_WHITE, "IDK", 1105, 2.5, 500, 1, 1, 3, 0, 0, 1, 3)
addApparel(2030, "Raggedy Green Slacks", RARITY_WHITE, "pants", "IDK", 900, 2.3, 350, 1, 1, 2, 0, 0, 1, 1)
addApparel(2073, "Ripped Green Sneakers ", RARITY_WHITE, "shoes", "IDK", 650, 1.2, 250, 1, 1, 1, 0, 0, 1, 1)
addApparel(2086, "Ragged Green Gloves", RARITY_WHITE, "gloves", "IDK", 650, 1.2, 250, 1, 1, 1, 0, 0, 1, 1)

//Level 2:

//Level 3:

//Level 4:
// Golf Suit (Non Craftable)
addApparel(2005, "Golf Beanie", RARITY_WHITE, "helmet", "IDK", 1000, 1.0, 500, 4, 1, 2, 0, 0, 1, 2)
addApparel(2020, "Golf Shirt", RARITY_WHITE, "chest", "IDK", 770, 2.5, 700, 4, 2, 3, 0, 0, 2, 5)
addApparel(2032, "Golf Pants", RARITY_WHITE, "pants", "IDK", 1400, 2.4, 600, 4, 1, 3, 0, 0, 1, 4)
addApparel(2075, "Golf Sneakers", RARITY_WHITE, "shoes", "IDK", 750, 1.4, 400, 4, 1, 2, 0, 0, 1, 1)
addApparel(2088, "Golfing Gloves", RARITY_WHITE, "gloves", "IDK", 750, 1.4, 400, 4, 1, 1, 0, 0, 1, 1)

//Level 5:

//Level 6:

//Level 7:
// Business (Non Craftable)
addApparel(2002, "Dirty Fedora", RARITY_WHITE, "helmet", "IDK", 1000, 0.5, 600, 7, 1, 2, 0, 0, 2, 3)
addApparel(2017, "Business Shirt", RARITY_WHITE, "chest", "IDK", 1100, 2.5, 800, 7, 2, 4, 0, 0, 4, 6)
addApparel(2029, "Business Slacks", RARITY_WHITE, "pants", "IDK", 1100, 2.2, 700, 7, 2, 3, 0, 0, 3, 5)
addApparel(2072, "Business Shoes", RARITY_WHITE, "shoes", "IDK", 600, 1.1, 500, 7, 2, 3, 0, 0, 1, 2)
addApparel(2085, "Business Formal Gloves", RARITY_WHITE, "gloves", "IDK", 500, 7.1, 250, 7, 1, 2, 0, 0, 1, 2)
//Level 8:

//Level 9:

//Level 10:
// Construction Armor (Craftable)
addApparel(2001, "Hard hat", RARITY_WHITE, "helmet", "models/props_2fort/hardhat001.mdl", 1000, 2.5, 700, 10, 2, 3, 0, 0, 2, 4)
addApparel(2016, "Construction T-Shirt ", RARITY_WHITE, "chest", "IDK", 1400, 2.0, 900, 10, 3, 5, 0, 0, 4, 7)
addApparel(2028, "Construction Slacks", RARITY_WHITE, "pants", "IDK", 1000, 2.0, 800, 10, 3, 4, 0, 0, 3, 6)
addApparel(2071, "Construction Boots", RARITY_WHITE, "shoes", "IDK", 500, 1.0, 600, 0, 10, 2, 3, 0, 1, 3)
addApparel(2084, "Construction Gloves", RARITY_WHITE, "gloves", "IDK", 500, 1.0, 600, 10, 2, 2, 0, 0, 1, 3)

//Level 11:

//Level 12:

//Level 13:
// Security Clothing (Non Craftable)
addApparel(2097, "Security Helmet", RARITY_WHITE, "helmet", "IDK", 1550, 3.5, 800, 13, 3, 3, 0, 0, 2, 5)
addApparel(2098, "Security Jacket", RARITY_WHITE, "chest", "IDK", 1200, 3.0, 1000, 13, 4, 6, 0, 2, 4, 8)
addApparel(2099, "Security Jeans", RARITY_WHITE, "pants", "IDK", 1700, 2.7, 900, 13, 3, 5, 0, 1, 3, 7)
addApparel(2100, "Black Security Boots", RARITY_WHITE, "shoes", "IDK", 900, 1.7, 750, 13, 2, 3, 0, 0, 2, 4)
addApparel(2101, "Black Security Gloves", RARITY_WHITE, "gloves", "IDK", 900, 1.7, 750, 13, 2, 3, 0, 0, 2, 4)

//Level 14:

//Level 15:

//Level 16:
// Sturdy Armor (Craftable)
addApparel(2051, "Sturdy Chest", RARITY_WHITE, "chest", "IDK", 1600, 2.2, 1200, 16, 3, 4, 1, 3, 3, 6)
addApparel(2052, "Sturdy Pants", RARITY_WHITE, "pants", "IDK", 1600, 2.2, 1100, 16, 4, 6, 0, 2, 6, 10)
addApparel(2053, "Sturdy Helmet", RARITY_WHITE, "helmet", "IDK", 1500, 2.2, 1000, 16, 3, 5, 0, 0, 5, 9)
addApparel(2054, "Sturdy Gloves", RARITY_WHITE, "gloves", "IDK", 1400, 2.2, 850, 16, 3, 4, 0, 1, 3, 4)
addApparel(2055, "Sturdy Shoes", RARITY_WHITE, "shoes", "IDK", 1300, 2.2, 850, 16, 3, 4, 0, 0, 2, 4)

//Level 17:

//Level 18:

//Level 19:
// Standard Armor (Non Craftable)
addApparel(2041, "Standard Chest", RARITY_WHITE, "chest", "IDK", 1800, 2.2, 1400, 19, 3, 5, 2, 4, 5, 8)
addApparel(2042, "Standard Pants", RARITY_WHITE, "pants", "IDK", 1400, 2.2, 1300, 19, 4, 7, 1, 3, 7, 11)
addApparel(2043, "Standard Helmet", RARITY_WHITE, "helmet", "IDK", 1300, 2.2, 1200, 19, 3, 6, 0, 0, 6, 9)
addApparel(2044, "Standard Gloves", RARITY_WHITE, "gloves", "IDK", 1200, 2.2, 1000, 19, 3, 4, 0, 2, 4, 5)
addApparel(2045, "Standard Shoes", RARITY_WHITE, "shoes", "IDK", 1100, 2.2, 1000, 19, 3, 4, 0, 0, 3, 5)

//Level 20:

//Level 21:

//Level 22:
// Reinforced Leather Armor(Craftable)
addApparel(2046, "Reinforced Leather Chest", RARITY_WHITE, "chest", "IDK", 1600, 2.2, 1600, 22, 4, 6, 3, 6, 7, 9)
addApparel(2047, "Reinforced Leather Pants", RARITY_WHITE, "pants", "IDK", 1500, 2.2, 1500, 22, 5, 7, 2, 4, 9, 11)
addApparel(2048, "Reinforced Leather Helmet", RARITY_WHITE, "helmet", "IDK", 1400, 2.2, 1400, 22, 4, 6, 0, 0, 8, 10)
addApparel(2049, "Reinforced Leather Gloves", RARITY_WHITE, "gloves", "IDK", 1100, 2.2, 1100, 22, 3, 5, 1, 2, 5, 7)
addApparel(2050, "Reinforced Leather Shoes", RARITY_WHITE, "shoes", "IDK", 1100, 2.2, 1100, 22, 3, 5, 0, 0, 4, 6)

//Level 23:

//Level 24:

//Level 25:
// Medium Armor (Craftable)
addApparel(2056, "Medium Chest", RARITY_WHITE, "chest", "IDK", 2300, 2.2, 1800, 25, 4, 6, 4, 6, 7, 9)
addApparel(2057, "Medium Pants", RARITY_WHITE, "pants", "IDK", 1700, 2.2, 1600, 25, 6, 8, 3, 5, 10, 14)
addApparel(2058, "Medium Helmet", RARITY_WHITE, "helmet", "IDK", 1600, 2.2, 1400, 25, 5, 7, 0, 0, 9, 11)
addApparel(2059, "Medium Gloves", RARITY_WHITE, "gloves", "IDK", 1500, 2.2, 1200, 25, 4, 6, 2, 4, 5, 7)
addApparel(2060, "Medium Shoes", RARITY_WHITE, "shoes", "IDK", 1400, 2.2, 1200, 25, 3, 5, 0, 0, 4, 6)

//Level 26:

//Level 27:

//Level 28:
// Officer Suit (Non Craftable)
addApparel(2010, "Officer Helmet", RARITY_WHITE, "helmet", "IDK", 1600, 3.5, 1700, 28, 4, 6, 0, 0, 8, 10)
addApparel(2025, "Officer ACU", RARITY_WHITE, "chest", "IDK", 2000, 3.0, 2000, 28, 7, 9, 5, 8, 12, 14)
addApparel(2037, "Officer Slacks", RARITY_WHITE, "pants", "IDK", 1900, 2.9, 1800, 28, 6, 8, 4, 6, 10, 13)
addApparel(2080, "Officer Dress Boots", RARITY_WHITE, "shoes", "IDK", 1600, 1.9, 1600, 28, 4, 6, 0, 0, 6, 8)
addApparel(2093, "Officer Dress Gloves", RARITY_WHITE, "gloves", "IDK", 1600, 1.9, 1600, 28, 4, 6, 3, 4, 5, 7)
//Level 29:

//Level 30:

//Level 31:
// Rusty Metal Armor (Craftable)
addApparel(2004, "Rusty Metal Helmet", RARITY_WHITE, "helmet", "IDK", 1200, 3.0, 1900, 31, 5, 8, 0, 0, 9, 12)
addApparel(2019, "Rusty Metal Chestplate", RARITY_WHITE, "chest", "IDK", 1300, 3.5, 2300, 31, 8, 9, 7, 9, 13, 15)
addApparel(2031, "Rusty Metal Pants", RARITY_WHITE, "pants", "IDK", 1300, 3.0, 2000, 31, 6, 8, 5, 8, 11, 14)
addApparel(2074, "Rusty Shoes", RARITY_WHITE, "shoes", "IDK", 700, 1.3, 1800, 31, 5, 7, 0, 0, 7, 9)
addApparel(2087, "Rusty Gloves", RARITY_WHITE, "gloves", "IDK", 700, 1.3, 1800, 31, 4, 6, 3, 4, 5, 7)

//Level 33:

//Level 34:
// Batting Armor (Non Craftable)
addApparel(2006, "Batting Helmet", RARITY_WHITE, "helmet", "IDK",1300, 2.5, 2200, 34, 6, 8 ,0 ,0, 11, 14)
addApparel(2021, "Batting Jacket", RARITY_WHITE, "chest", "IDK", 1200, 3.0, 2600, 34, 8, 10, 8, 9, 14, 17)
addApparel(2033, "Batting Jeans", RARITY_WHITE, "pants", "IDK", 1500, 2.5, 2300, 34, 7, 9, 6, 8, 12, 15)
addApparel(2076, "Batting Converse", RARITY_WHITE, "shoes", "IDK", 800, 1.5, 2100, 34, 6, 8, 0, 0, 7, 9)
addApparel(2089, "Batting gloves", RARITY_WHITE, "gloves", "IDK", 800, 1.5, 2100, 34, 5, 6, 4, 7, 5, 7)

//Level 35:

//Level 36:

//Level 37:
// Advanced Security Armor (Craftable)
addApparel(2008, "Advanced Security Helmet", RARITY_WHITE, "helmet", "IDK", 1550, 3.5, 2500, 37, 7, 9, 0, 0, 12, 14)
addApparel(2023, "Advanced Security Jacket", RARITY_WHITE,  "chest", "IDK", 1800, 3.0, 3000, 37, 9, 11, 9, 10, 15, 17)
addApparel(2035, "Advanced Security Jeans", RARITY_WHITE, "pants", "IDK", 1700, 2.7, 2600, 37, 7, 9, 7, 9, 13, 15)
addApparel(2078, "Black Advanced Security Boots", RARITY_WHITE, "shoes", "IDK", 900, 1.7, 2400, 37, 6, 8, 0, 0, 9, 12)
addApparel(2091, "Black Advanced Security Gloves", RARITY_WHITE, "gloves", "IDK", 900, 1.7, 2400, 37, 5, 7, 6, 8, 8, 10)

//Level 38:

//Level 39:

//Level 40:
// Hazmat Set (Non Craftable)
addApparel(2009, "Gas Mask", RARITY_WHITE, "helmet", "IDK", 1600, 2.5, 2900, 40, 7, 9, 0, 0, 14, 15)
addApparel(2024, "Secure Hazmat Jacket", RARITY_WHITE, "chest", "IDK", 1000, 3.0, 3400, 40, 9, 11, 10, 11, 16, 19)
addApparel(2036, "Secure Hazmat Bottoms", RARITY_WHITE, "pants", "IDK", 900, 2.8, 3000, 40, 8, 10, 9, 9, 14, 16)
addApparel(2079, "Secure Hazmat Boots", RARITY_WHITE, "shoes", "IDK", 950, 1.8, 2700, 40, 7, 9, 0, 0, 10, 13)
addApparel(2092, "Secure Hazmat Gloves", RARITY_WHITE, "gloves", "IDK", 950, 1.8, 2700, 40, 6, 8, 6, 9, 8, 10)

//Level 41:

//Level 42:

//Level 43:
// General Suit (Non Craftable)
addApparel(2015, "General's Hat", RARITY_WHITE, "helmet", "IDK", 1600, 3.0, 3200, 43, 8, 10, 0, 0, 15, 17)
addApparel(2027, "Generals Jacket", RARITY_WHITE, "chest", "IDK", 2500, 3.0, 3800, 43, 10, 12, 11, 12, 16, 19)
addApparel(2040, "Generals Slacks", RARITY_WHITE, "pants", "IDK", 2200, 3.2, 3400, 43, 9, 11, 10, 11, 15, 18)
addApparel(2083, "Generals Dress Shoes", RARITY_WHITE, "shoes", "IDK", 1500, 2.0, 3000, 43, 7, 9, 0, 0, 11, 13)
addApparel(2096, "Generals Dress Gloves", RARITY_WHITE, "gloves", "IDK", 1500, 2.0, 3000, 43, 6, 8, 7, 9, 9, 11)

//Level 44:

//Level 45:

//Level 46:
// Heavy Armor (Craftable)
addApparel(2061, "Heavy Chest", RARITY_WHITE, "chest", "IDK", 1900, 2.2, 4400, 46, 8, 10, 11, 13, 16, 18)
addApparel(2062, "Heavy Pants", RARITY_WHITE, "pants", "IDK", 1800, 2.2, 3900, 46, 11, 13, 10, 12, 18, 22)
addApparel(2063, "Heavy Helmet", RARITY_WHITE, "helmet", "IDK", 1700, 2.2, 3700, 46, 9, 11, 0, 0, 16, 19)
addApparel(2064, "Heavy Gloves", RARITY_WHITE, "gloves", "IDK", 1600, 2.2, 3400, 46, 8, 10,  8, 10, 11, 13)
addApparel(2065, "Heavy Shoes", RARITY_WHITE, "shoes", "IDK", 1500, 2.2, 3400, 46, 7, 9, 0, 0, 9, 11)

//Level 47:

//Level 48:

//Level 49:

//Level 50:
// Power Armor  (Craftable)
addApparel(2066, "Power Armor Chest", RARITY_WHITE, "chest", "IDK", 2000, 2.2, 5000, 50, 8, 10, 13, 15, 18, 23)
addApparel(2067, "Power Armor Pants", RARITY_WHITE, "pants", "IDK", 1900, 2.2, 4600, 50, 11, 13, 11, 13, 21, 25)
addApparel(2068, "Power Armor Helmet", RARITY_WHITE, "helmet", "IDK", 1800, 2.2, 4200, 50, 9, 11, 0, 0, 20, 24)
addApparel(2069, "Power Armor Gloves", RARITY_WHITE, "gloves", "IDK",1700, 2.2, 4000, 50, 8, 10, 9, 11, 13, 15)
addApparel(2070, "Power Armor Shoes", RARITY_WHITE, "shoes", "IDK", 1600, 2.2, 4000, 50, 7, 9, 0, 0, 12, 14)
