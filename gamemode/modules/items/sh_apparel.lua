
local Apparel = {}

local meta = FindMetaTable("Player")

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

addApparel(2001, "Hard hat", "helmet", "models/props_2fort/hardhat001.mdl", 1000, 2.5, 900, 1, 5, 10)

addApparel(2002, "Dirty Fedora", "helmet", "IDK", 1000, 0.5, 500, 1, 3, 5, 0, 0)

addApparel(2003, "Green Rag Hat", "IDK", 1000, 0.5, 200, 1, 1, 2, 0, 0)

addApparel(2004, "Rusty Metal Helmet", "helmet", "IDK", 1200, 3.0, 1000, 4, 2, 4, 0, 0)

addApparel(2005, "Golf Visored", "helmet", "IDK", 1000, 1.0, 950, 5, 1, 1, 2)

addApparel(2006, "Batting Helmet",  "Helmet", "IDK",1300, 2.5, 1020, 10, 3, 4 ,0 ,0)

addApparel(2007, "Army Helmet",  "Helmet", "IDK",1500, 3.0, 1010, 15, 1,  6, 1, 3, 0, 0)

addApparel(2008, "Security Helmet",  "Helmet", "IDK", 1550, 3.5, 1150, 20, 3, 5, 2, 2, 0, 0)

addApparel(2009, "Gas Mask",  "Helmet", "IDK", 1600, 2.5, 1100, 25, 3, 4, 2, 2, 0, 0)

addApparel(2010, "Military Cap",  "Helmet", "IDK", 1600, 3.5, 1150, 25, 3, 6, 1, 3, 0, 0)

addApparel(2011, "Gas Mask",  "Helmet", "IDK", 1600, 2.5, 1100, 25, 3, 4, 2, 2, 1, 2)

addApparel(2012, "Medical Helmet",  "Helmet", "IDK", 1600, 2.0, 1100, 30, 2, 3, 2, 4, 2, 4)

addApparel(2013, "Assault Gas Mask",  "Helmet", "IDK", 1600, 2.5, 1100, 35, 3, 4, 2, 2, 3, 5)

addApparel(2014, "Russian Ushanka",  "Helmet", "IDK", 1600, 3.0, 1150, 40, 3, 5, 2, 3, 0, 0)

addApparel(2015, "General's Hat",  "Helmet", "IDK", 1600, 3.0, 1500, 50, 4, 7, 2, 6, 5, 7)

addApparel(2016, "Construction T-Shirt ",  "chest", "IDK", 1000, 2.0, 1000, 1, 1, 2, 1, 2, 0, 0)

addApparel(2017, "Business Shirt",  "chest", "IDK", 1100, 2.5, 1100, 1, 4, 7, 2, 3, 0, 0)

addApparel(2018, "Green Rags",  "chest", "IDK", 1105, 2.5, 1105, 4, 4, 7, 2, 4, 0, 0)

addApparel(2019, "Rusty Metal Chestplate",  "chest", "IDK", 1600, 3.5, 1300, 5, 5, 7, 2, 7, 0, 0)

addApparel(2020, "Golf Shirt",  "chest", "IDK", 1150, 2.5, 1100, 10, 4, 7, 2, 5, 1, 2)

addApparel(2021, "Batting Jacket",  "chest", "IDK", 1200, 3.0, 1100, 15, 4, 7, 2, 3, 1, 1)

addApparel(2022, "Army ACU",  "chest", "IDK", 1200, 3.5, 1140, 20, 5, 8, 2, 5, 1, 4)

addApparel(2023, "Security Jacket",  "chest", "IDK", 1200, 3.0, 1150, 25, 4, 9, 2, 3, 1, 5)

addApparel(2024, "Secure Hazmat Jacket",  "chest", "IDK", 1200, 3.0, 1500, 30, 6, 10, 3, 5, 1, 3)

addApparel(2025, "Officer ACU",  "chest", "IDK", 1200, 3.0, 2000, 30, 7, 12, 4, 6, 1, 5)

addApparel(2026, "Medical Jacket",  "chest", "IDK", 2120, 3.0, 1160, 30, 8, 13, 5, 7, 2, 5)

addApparel(2027, "Assault Hazmat Jacket",  "chest", "IDK", 2130, 3.0, 1100, 35, 9, 13, 5, 8, 5, 6)

addApparel(2027, "Russian ACU",  "chest", "IDK", 2140, 3.0, 2140, 40, 9, 14, 5, 9, 5, 7)

addApparel(2027, "Generals Jacket",  "chest", "IDK", 2150, 3.0, 1100, 50, 11, 17, 7, 10, 5, 8)

addApparel(2028, "Construction Slacks",  "pants", "IDK", 1000, 2.0, 900, 1, 2, 6, 2, 6, 1, 2)

addApparel(2029, "Business Slacks",  "pants", "IDK", 1100, 2.2, 1000, 1, 2, 6, 2, 6, 1, 3)

addApparel(2030, " Raggedy Green Slacks",  "pants", "IDK", 1200, 2.3, 1100, 4, 3, 6, 3, 6, 2, 3)

addApparel(2031, "Rusty Metal Pants",  "pants", "IDK", 1300, 3.0, 1200, 5, 3, 7, 3, 7, 2, 4)

addApparel(2032, "Golf Pants",  "pants", "IDK", 1400, 2.4, 1300, 10, 3, 8, 3, 9, 2, 5)

addApparel(2033, "Batting Jeans",  "pants", "IDK", 1500, 2.5, 1400, 15, 3, 9, 3, 10, 2, 6)

addApparel(2034, "Army Jeans",  "pants", "IDK", 1600, 2.6, 1500, 20, 3, 10, 4, 10, 3, 6)

addApparel(2035, "Security Jeans",  "pants", "IDK", 1700, 2.7, 1600, 25, 4, 10, 5, 10, 3, 7)

addApparel(2036, "Secure Hazmat Bottoms",  "pants", "IDK", 1800, 2.8, 1700, 30, 5, 10, 6, 10, 4, 7)

addApparel(2037, "Officer Slacks",  "pants", "IDK", 1900, 2.9, 1800, 35, 6, 10, 7, 10, 4, 8)

addApparel(2038, "Medical Slacks",  "pants", "IDK", 2000, 3.0, 1900, 40, 7, 10, 8, 10, 5, 8)

addApparel(2039, "Assault Hazmat Bottoms",  "pants", "IDK", 2100, 3.1, 2000, 45, 8, 10, 9, 10, 5, 9)

addApparel(2040, "Generals Slacks",  "pants", "IDK", 2200, 3.2, 2100, 50, 10, 10, 10, 10, 5, 10)

addApparel(2071, "Construction Boots",  "shoes", "IDK", 500, 1.0, 500, 1, 1, 1, 0, 0, 0, 0)

addApparel(2072, "Business Shoes",  "shoes", "IDK", 600, 1.1, 550, 1, 1, 2, 1, 1, 1, 1)

addApparel(2073, "Ripped Green Sneakers ",  "shoes", "IDK", 650, 1.2, 600, 4, 1, 3, 1, 2, 1, 2)

addApparel(2074, "Rusty Shoes",  "shoes", "IDK", 700, 1.3, 650, 5, 1, 4, 1, 3, 1, 2)

addApparel(2075, "Golf Sneakers",  "shoes", "IDK", 750, 1.4, 700, 10, 2, 4, 1, 3, 1, 2)

addApparel(2076, "Batting Converse",  "shoes", "IDK", 800, 1.5, 750, 15, 2, 5, 1, 4, 1, 3)

addApparel(2077, "Army Combat Boots",  "shoes", "IDK", 850, 1.6, 800, 20, 2, 6, 2, 5, 1, 3)

addApparel(2078, "Black Security Boots",  "shoes", "IDK", 900, 1.7, 850, 25, 2, 7, 2, 6, 1, 4)

addApparel(2079, "Secure Hazmat Boots",  "shoes", "IDK", 950, 1.8, 900, 30, 2, 8, 2, 6, 1, 5)

addApparel(2080, "Officer Dress Boots",  "shoes", "IDK", 1000, 1.9, 950, 35, 3, 8, 2, 7, 2, 5)

addApparel(2081, "Medical Shoes",  "shoes", "IDK", 1200, 2.0, 1200, 40, 3, 5, 2, 4, 3, 7)

addApparel(2082, "Assault Hazmat Boots",  "shoes", "IDK", 1100, 2.0, 1000, 45, 4, 9, 3, 8, 3, 5)

addApparel(2083, "Generals Dress Shoes",  "shoes", "IDK", 1500, 2.0, 1500, 50, 5, 10, 5, 10, 5, 10)

addApparel(2084, "Construction Gloves",  "gloves", "IDK", 500, 1.0, 500, 1, 1, 1, 0, 0, 0, 0)

addApparel(2085, "Business Formal Gloves",  "gloves", "IDK", 600, 1.1, 550, 1, 1, 2, 1, 1, 1, 1)

addApparel(2086, "Ragged Green Gloves",  "gloves", "IDK", 650, 1.2, 600, 4, 1, 3, 1, 2, 1, 2)

addApparel(2087, "Rusty Gloves",  "gloves", "IDK", 700, 1.3, 650, 5, 1, 4, 1, 3, 1, 2)

addApparel(2088, "Golfing Gloves",  "gloves", "IDK", 750, 1.4, 700, 10, 2, 4, 1, 3, 1, 2)

addApparel(2089, "Batting gloves",  "gloves", "IDK", 800, 1.5, 750, 15, 2, 5, 1, 4, 1, 3)

addApparel(2090, "Army Combat Gloves",  "gloves", "IDK", 850, 1.6, 800, 20, 2, 6, 2, 5, 1, 3)

addApparel(2091, "Black Security Gloves",  "gloves", "IDK", 900, 1.7, 850, 25, 2, 7, 2, 6, 1, 4)

addApparel(2092, "Secure Hazmat Gloves",  "gloves", "IDK", 950, 1.8, 900, 30, 2, 8, 2, 6, 1, 5)

addApparel(2093, "Officer Dress Gloves",  "gloves", "IDK", 1000, 1.9, 950, 35, 3, 8, 2, 7, 2, 5)

addApparel(2094, "Medical Gloves",  "gloves", "IDK", 1200, 2.0, 1200, 40, 3, 5, 2, 4, 3, 7)

addApparel(2095, "Assault Hazmat Gloves",  "gloves", "IDK", 1100, 2.0, 1000, 45, 4, 9, 3, 8, 3, 5)

addApparel(2096, "Generals Dress Gloves",  "gloves", "IDK", 1500, 2.0, 1500, 50, 5, 10, 5, 10, 5, 10)

// Cloth
addApparel(2041, "Standard Chest",  "chest", "IDK", 1500, 2.2, 675, 1, 1, 5, 0, 0, 0, 0)
addApparel(2042, "Standard Pants",  "pants", "IDK", 1400, 2.2, 360, 2, 1, 1, 4, 0, 0, 0, 0)
addApparel(2043, "Standard Helmet",  "helmet", "IDK", 1300, 2.2, 225, 3, 1, 3, 0, 0, 0, 0)
addApparel(2044, "Standard Gloves",  "gloves", "IDK", 1200, 2.2, 270, 4, 1, 2, 0, 0, 0, 0)
addApparel(2045, "Standard Shoes",  "shoes", "IDK", 1100, 2.2, 225, 5, 1, 1, 0, 0, 0, 0)

// Leather
addApparel(2046, "Leather Chest",  "chest", "IDK", 1600, 2.2, 1125, 6, 1, 6, 1, 2, 0, 0)
addApparel(2047, "Leather Pants",  "pants", "IDK", 1500, 2.2, 600, 7, 1, 5, 1, 2, 0, 0)
addApparel(2048, "Leather Helmet",  "helmet", "IDK", 1400, 2.2, 375, 8, 1, 4, 1, 2, 0, 0)
addApparel(2049, "Leather Gloves",  "gloves", "IDK", 1300, 2.2, 450, 9, 1, 3, 1, 2, 0, 0)
addApparel(2050, "Leather Shoes",  "shoes", "IDK", 1200, 2.2, 375, 10, 1, 2, 1, 2, 0, 0)

// Rock                        
addApparel(2051, "Sturdy Chest",  "chest", "IDK", 1700, 2.2, 900, 11, 1, 7, 1, 3, 1, 1)
addApparel(2052, "Sturdy Pants",  "pants", "IDK", 1600, 2.2, 490, 12,1, 6, 1, 3, 1, 1)
addApparel(2053, "Sturdy Helmet",  "helmet", "IDK", 1500, 2.2, 280, 13, 1, 5, 1, 3, 1, 1)
addApparel(2054, "Sturdy Gloves",  "gloves", "IDK", 1400, 2.2, 360, 14, 1, 4, 1, 3, 1, 1)
addApparel(2055, "Sturdy Shoes",  "shoes", "IDK", 1300, 2.2, 280, 15, 1, 3, 1, 3, 1, 1)

// Copper and silver
addApparel(2056, "Medium Chest",  "chest", "IDK", 1800, 2.2, 2790, 16, 1, 8, 1, 4, 1, 2)
addApparel(2057, "Medium Pants",  "pants", "IDK", 1700, 2.2, 1460, 18, 1, 7, 1, 4, 1, 2)
addApparel(2058, "Medium Helmet",  "helmet", "IDK", 1600, 2.2, 980, 20, 1, 6, 1, 4, 1, 2)
addApparel(2059, "Medium Gloves",  "gloves", "IDK", 1500, 2.2, 1110, 22, 1, 5, 1, 4, 1, 2)
addApparel(2060, "Medium Shoes",  "shoes", "IDK", 1400, 2.2, 980, 25, 1, 4, 1, 4, 1, 2)

// Gold
addApparel(2061, "Heavy Chest",  "chest", "IDK", 1900, 2.2, 6200, 28, 1, 9, 1, 5, 1, 3)
addApparel(2062, "Heavy Pants",  "pants", "IDK", 1800, 2.2, 4750, 30, 1, 8, 1, 5, 1, 3)
addApparel(2063, "Heavy Helmet",  "helmet", "IDK", 1700, 2.2, 1350, 34, 1, 7, 1, 5, 1, 3)
addApparel(2064, "Heavy Gloves",  "gloves", "IDK", 1600, 2.2, 2700, 37, 1, 6, 1, 5, 1, 3)
addApparel(2065, "Heavy Shoes",  "shoes", "IDK", 1500, 2.2, 1350, 40, 1, 5, 1, 5, 1, 3)

// Crystal
addApparel(2066, "Power Armor Chest",  "chest", "IDK", 2000, 2.2, 2000, 42, 1, 10, 1, 5, 1, 5)
addApparel(2067, "Power Armor Pants",  "pants", "IDK", 2000, 2.2, 1900, 44, 1, 9, 1, 5, 1, 5)
addApparel(2068, "Power Armor Helmet",  "helmet", "IDK", 2000, 2.2, 1800, 46, 1, 8, 1, 5, 1, 5)
addApparel(2069, "Power Armor Gloves",  "gloves", "IDK", 1900, 2.2, 1700, 48, 1, 7, 1, 5, 1, 5)
addApparel(2070, "Power Armor Shoes",  "shoes", "IDK", 1900, 2.2, 1600, 50, 1, 6, 1, 5, 1, 5)







































