
local Apparel = Apparel or {}

local mt = {
	__call = function(table, id, name, rarity, slot, model, durability, weight, value, level, minDamageThreshold, maxDamageThreshold, minDamageReflection, maxDamageReflection, minBonusHp, maxBonusHp)
		local apparel = {
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
		setmetatable(apparel, {__index = ITEM})

		function apparel:getMinDamageThreshold()
			return self.minDamageThreshold
		end
		function apparel:getMedianDamageThreshold()
			return math.floor((apparel.minDamageThreshold + apparel.maxDamageThreshold) / 2)
		end
		function apparel:getMaxDamageThreshold()
			return self.maxDamageThreshold
		end
		function apparel:getMinDamageReflection()
			return self.minDamageReflection
		end
		function apparel:getMedianDamageReflection()
			return math.floor((apparel.minDamageReflection + apparel.maxDamageReflection) / 2)
		end
		function apparel:getMaxDamageReflection()
			return self.maxDamageReflection
		end
		function apparel:getMinBonusHp()
			return self.minBonusHp
		end
		function apparel:getMedianBonusHp()
			return math.floor((apparel.minBonusHp + apparel.maxBonusHp) / 2)
		end
		function apparel:getMaxBonusHp()
			return self.maxBonusHp
		end

		Apparel[id] = apparel
		return apparel
	end
}
setmetatable(Apparel, mt)

function getApparel()
	return Apparel
end

function findApparel(id)
	if id then
		return Apparel[id]
	end
end

local meta = FindMetaTable("Player")

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

timer.Simple(5, function()
	//Level 1
	// Cloth
	Apparel(2003, "Green Rag Hat", RARITY_WHITE, "helmet", "IDK", 800, 0.5, 400, 1, 1, 1, 0, 0, 1, 2)
	Apparel(2018, "Green Rags", "chest", RARITY_WHITE, "IDK", 1105, 2.5, 500, 1, 1, 3, 0, 0, 1, 3)
	Apparel(2030, "Raggedy Green Slacks", RARITY_WHITE, "pants", "IDK", 900, 2.3, 350, 1, 1, 2, 0, 0, 1, 1)
	Apparel(2073, "Ripped Green Sneakers ", RARITY_WHITE, "shoes", "IDK", 650, 1.2, 250, 1, 1, 1, 0, 0, 1, 1)
	Apparel(2086, "Ragged Green Gloves", RARITY_WHITE, "gloves", "IDK", 650, 1.2, 250, 1, 1, 1, 0, 0, 1, 1)

	//Level 2:

	//Level 3:

	//Level 4:
	// Golf Suit
	Apparel(2005, "Golf Beanie", RARITY_GREEN, "helmet", "IDK", 1000, 1.0, 500, 4, 1, 3, 0, 1, 1, 4)
	Apparel(2020, "Golf Shirt", RARITY_GREEN, "chest", "IDK", 770, 2.5, 700, 4, 2, 4, 0, 1, 2, 7)
	Apparel(2032, "Golf Pants", RARITY_GREEN, "pants", "IDK", 1400, 2.4, 600, 4, 1, 3, 0, 1, 1, 5)
	Apparel(2075, "Golf Sneakers", RARITY_GREEN, "shoes", "IDK", 750, 1.4, 400, 4, 1, 2, 0, 1, 1, 2)
	Apparel(2088, "Golfing Gloves", RARITY_GREEN, "gloves", "IDK", 750, 1.4, 400, 4, 1, 2, 0, 1, 1, 2)

	//Level 5:

	//Level 6:

	//Level 7:
	// Business
	Apparel(2002, "Dirty Fedora", RARITY_BLUE, "helmet", "IDK", 2000, 0.5, 600, 7, 3, 5, 0, 1, 4, 7)
	Apparel(2017, "Business Shirt", RARITY_BLUE, "chest", "IDK", 2100, 2.5, 800, 7, 4, 6, 0, 1, 7, 12)
	Apparel(2029, "Business Slacks", RARITY_BLUE, "pants", "IDK", 2100, 2.2, 700, 7, 4, 5, 0, 1, 4, 10)
	Apparel(2072, "Business Shoes", RARITY_BLUE, "shoes", "IDK", 1200, 1.1, 500, 7, 3, 4, 0, 1, 4, 6)
	Apparel(2085, "Business Formal Gloves", RARITY_BLUE, "gloves", "IDK", 1000, 7.1, 250, 7, 3, 4, 0, 1, 3, 5)
	//Level 8:

	//Level 9:

	//Level 10:
	// Construction Armor
	Apparel(2001, "Hard hat", RARITY_GREEN, "helmet", "models/props_2fort/hardhat001.mdl", 1000, 2.5, 700, 10, 3, 4, 0, 0, 2, 4)
	Apparel(2016, "Construction T-Shirt ", RARITY_GREEN, "chest", "IDK", 1400, 2.0, 900, 10, 4, 5, 0, 0, 4, 7)
	Apparel(2028, "Construction Slacks", RARITY_GREEN, "pants", "IDK", 1000, 2.0, 800, 10, 3, 4, 0, 0, 3, 6)
	Apparel(2071, "Construction Boots", RARITY_GREEN, "shoes", "IDK", 500, 1.0, 600, 0, 10, 3, 4, 0, 1, 3)
	Apparel(2084, "Construction Gloves", RARITY_GREEN, "gloves", "IDK", 500, 1.0, 600, 10, 2, 3, 0, 0, 1, 3)

	//Level 11:

	//Level 12:

	//Level 13:
	// Security Clothing
	Apparel(2097, "Security Helmet", RARITY_PURPLE, "helmet", "IDK", 2500, 3.5, 800, 13, 5, 7, 0, 2, 7, 9)
	Apparel(2098, "Security Jacket", RARITY_PURPLE, "chest", "IDK", 3400, 3.0, 1000, 13, 6, 8, 0, 3, 12, 14)
	Apparel(2099, "Security Jeans", RARITY_PURPLE, "pants", "IDK", 3400, 2.7, 900, 13, 6, 8, 0, 3, 8, 12)
	Apparel(2100, "Black Security Boots", RARITY_PURPLE, "shoes", "IDK", 1800, 1.7, 750, 13, 4, 5, 0, 2, 6, 9)
	Apparel(2101, "Black Security Gloves", RARITY_PURPLE, "gloves", "IDK", 1800, 1.7, 750, 13, 4, 5, 0, 2, 5, 8)

	//Level 14:

	//Level 15:

	//Level 16:

	//Level 17:
	// Standard Armor
	Apparel(2043, "Standard Helmet", RARITY_WHITE, "chest", "IDK", 2000, 2.2, 1400, 19, 4, 5, 0, 0, 4, 5)
	Apparel(2041, "Standard Chest", RARITY_WHITE, "helmet", "IDK", 1600, 2.2, 1200, 19, 5, 5, 0, 0, 6, 9)
	Apparel(2042, "Standard Pants", RARITY_WHITE, "pants", "IDK", 2000, 2.2, 1300, 19, 5, 6, 0, 0, 7, 10)
	Apparel(2044, "Standard Gloves", RARITY_WHITE, "gloves", "IDK", 1600, 2.2, 1000, 19, 3, 4, 0, 0, 6, 7)
	Apparel(2045, "Standard Shoes", RARITY_WHITE, "shoes", "IDK", 1500, 2.2, 1000, 19, 3, 4, 0, 0, 3, 4)

	//Level 18:

	//Level 19:

	//Level 20:

	//Level 21:

	//Level 22:
	// Reinforced Leather Armor
	Apparel(2046, "Reinforced Leather Chest", RARITY_GREEN, "chest", "IDK", 2500, 2.2, 1600, 22, 6, 7, 0, 1, 6, 8)
	Apparel(2047, "Reinforced Leather Pants", RARITY_GREEN, "pants", "IDK", 3000, 2.2, 1500, 22, 7, 9, 0, 2, 11, 14)
	Apparel(2048, "Reinforced Leather Helmet", RARITY_GREEN, "helmet", "IDK", 3000, 2.2, 1400, 22, 6, 8, 0, 2, 10, 13)
	Apparel(2049, "Reinforced Leather Gloves", RARITY_GREEN, "gloves", "IDK", 2000, 2.2, 1100, 22, 5, 7, 0, 1, 8, 9)
	Apparel(2050, "Reinforced Leather Shoes", RARITY_GREEN, "shoes", "IDK", 2000, 2.2, 1100, 22, 5, 6, 0, 1, 6, 9)

	//Level 23:

	//Level 24:

	//Level 25:
	// Medium Armor
	Apparel(2058, "Medium Helmet", RARITY_GREEN, "helmet", "IDK", 2500, 2.2, 1400, 25, 7, 8, 0, 2, 9, 11)
	Apparel(2056, "Medium Chest", RARITY_GREEN, "chest", "IDK", 3500, 2.2, 1800, 25, 8, 10, 1, 3, 15, 17)
	Apparel(2057, "Medium Pants", RARITY_GREEN, "pants", "IDK", 3500, 2.2, 1600, 25, 8, 10, 1, 3, 14, 16)
	Apparel(2059, "Medium Gloves", RARITY_GREEN, "gloves", "IDK", 2500, 2.2, 1200, 25, 7, 8, 0, 2, 10, 12)
	Apparel(2060, "Medium Shoes", RARITY_GREEN, "shoes", "IDK", 2500, 2.2, 1200, 25, 7, 8, 0, 1, 10, 12)

	//Level 26:

	//Level 27:

	//Level 28:
	// Officer Suit
	Apparel(2010, "Officer Helmet", RARITY_PURPLE, "helmet", "IDK", 5000, 3.5, 1700, 28, 9, 11, 1, 3, 13, 20)
	Apparel(2025, "Officer ACU", RARITY_PURPLE, "chest", "IDK", 7000, 3.0, 2000, 28, 11, 12, 3, 4, 19, 24)
	Apparel(2037, "Officer Slacks", RARITY_PURPLE, "pants", "IDK", 7000, 2.9, 1800, 28, 11, 12, 3, 4, 18, 23)
	Apparel(2093, "Officer Dress Gloves", RARITY_PURPLE, "gloves", "IDK", 5000, 1.9, 1600, 28, 9, 10, 3, 4, 15, 19)
	Apparel(2080, "Officer Dress Boots", RARITY_PURPLE, "shoes", "IDK", 5000, 1.9, 1600, 28, 9, 10, 2, 3, 14, 19)
	//Level 29:

	//Level 30:

	//Level 31:
	// Rusty Metal Armor
	Apparel(2004, "Rusty Metal Helmet", RARITY_WHITE, "helmet", "IDK", 2500, 3.0, 1900, 31, 7, 8, 0, 0, 9, 12)
	Apparel(2019, "Rusty Metal Chestplate", RARITY_WHITE, "chest", "IDK", 3500, 3.5, 2300, 31, 9, 10, 0, 0, 16, 18)
	Apparel(2031, "Rusty Metal Pants", RARITY_WHITE, "pants", "IDK", 3500, 3.0, 2000, 31, 9, 10, 0, 0, 15, 17)
	Apparel(2087, "Rusty Gloves", RARITY_WHITE, "gloves", "IDK", 2500, 1.3, 1800, 31, 7, 8, 0, 0, 13, 14)
	Apparel(2074, "Rusty Shoes", RARITY_WHITE, "shoes", "IDK", 2500, 1.3, 1800, 31, 7, 8, 0, 0, 12, 14)

	//Level 33:

	//Level 34:
	// Batting Armor
	Apparel(2006, "Batting Helmet", RARITY_GREEN, "helmet", "IDK", 3000, 2.5, 2200, 34, 8, 10, 0, 2, 13, 15)
	Apparel(2021, "Batting Jacket", RARITY_GREEN, "chest", "IDK", 4000, 3.0, 2600, 34, 10, 12, 0, 2, 19, 22)
	Apparel(2033, "Batting Jeans", RARITY_GREEN, "pants", "IDK", 4000, 2.5, 2300, 34, 10, 12, 0, 2, 18, 21)
	Apparel(2089, "Batting Gloves", RARITY_GREEN, "gloves", "IDK", 3000, 1.5, 2100, 34, 8, 9, 0, 2, 15, 17)
	Apparel(2076, "Batting Converse", RARITY_GREEN, "shoes", "IDK", 3000, 1.5, 2100, 34, 8, 9, 0, 2, 14, 16)

	//Level 35:

	//Level 36:

	//Level 37:
	// Advanced Security Armor
	Apparel(2008, "Advanced Security Helmet", RARITY_BLUE, "helmet", "IDK", 4000, 3.5, 2500, 37, 11, 12, 1, 3, 22, 24)
	Apparel(2023, "Advanced Security Jacket", RARITY_BLUE,  "chest", "IDK", 5000, 3.0, 3000, 37, 13, 15, 1, 4, 24, 28)
	Apparel(2035, "Advanced Security Jeans", RARITY_BLUE, "pants", "IDK", 5000, 2.7, 2600, 37, 7, 13, 15, 1, 24, 28)
	Apparel(2091, "Black Advanced Security Gloves", RARITY_BLUE, "gloves", "IDK", 4000, 1.7, 2400, 10, 12, 1, 3, 8, 21, 23)
	Apparel(2078, "Black Advanced Security Boots", RARITY_BLUE, "shoes", "IDK", 400, 1.7, 2400, 37, 10, 12, 1, 3, 21, 23)

	//Level 38:

	//Level 39:

	//Level 40:
	// Hazmat Set
	Apparel(2009, "Gas Mask", RARITY_PURPLE, "helmet", "IDK", 6000, 2.5, 2900, 40, 12, 13, 3, 5, 25, 30)
	Apparel(2024, "Secure Hazmat Jacket", RARITY_PURPLE, "chest", "IDK", 7000, 3.0, 3400, 40, 14, 15, 6, 8, 31, 35)
	Apparel(2036, "Secure Hazmat Bottoms", RARITY_PURPLE, "pants", "IDK", 7000, 2.8, 3000, 40, 14, 15, 6, 8, 31, 35)
	Apparel(2092, "Secure Hazmat Gloves", RARITY_PURPLE, "gloves", "IDK", 6000, 1.8, 2700, 40, 12, 13, 3, 5, 26, 29)
	Apparel(2079, "Secure Hazmat Boots", RARITY_PURPLE, "shoes", "IDK", 6000, 1.8, 2700, 40, 12, 13, 3, 5, 26, 29)

	//Level 41:

	//Level 42:

	//Level 43:
	// General Suit
	Apparel(2015, "General's Hat", RARITY_PURPLE, "helmet", "IDK", 6000, 3.0, 3200, 43, 12, 13, 2, 3, 35, 40)
	Apparel(2027, "Generals Jacket", RARITY_PURPLE, "chest", "IDK", 7000, 3.0, 3800, 43, 14, 15, 2, 5, 41, 50)
	Apparel(2040, "Generals Slacks", RARITY_PURPLE, "pants", "IDK", 7000, 3.2, 3400, 43, 14, 15, 2, 5, 41, 50)
	Apparel(2096, "Generals Dress Gloves", RARITY_PURPLE, "gloves", "IDK", 6000, 2.0, 3000, 43, 12, 13, 2, 3, 35, 40)
	Apparel(2083, "Generals Dress Shoes", RARITY_PURPLE, "shoes", "IDK", 6000, 2.0, 3000, 43, 12, 13, 2, 3, 35, 40)

	//Level 44:

	//Level 45:

	//Level 46:
	// Heavy Armor
	Apparel(2061, "Heavy Chest", RARITY_GREEN, "chest", "IDK", 4000, 2.2, 4400, 46, 11, 12, 1, 2, 20, 22)
	Apparel(2062, "Heavy Pants", RARITY_GREEN, "pants", "IDK", 5000, 2.2, 3900, 46, 12, 13, 1, 2, 24, 26)
	Apparel(2063, "Heavy Helmet", RARITY_GREEN, "helmet", "IDK", 5000, 2.2, 3700, 46, 12, 13, 1, 2, 24, 26)
	Apparel(2064, "Heavy Gloves", RARITY_GREEN, "gloves", "IDK", 4000, 2.2, 3400, 46, 11, 12,  1, 2, 20, 22)
	Apparel(2065, "Heavy Shoes", RARITY_GREEN, "shoes", "IDK", 4000, 2.2, 3400, 46, 11, 12, 1, 2, 20, 22)

	//Level 47:

	//Level 48:

	//Level 49:

	//Level 50:
	// Power Armor
	Apparel(2068, "Power Armor Helmet", RARITY_ORANGE, "helmet", "IDK", 1800, 2.2, 4200, 50, 14, 15, 6, 7, 45, 55)
	Apparel(2066, "Power Armor Chest", RARITY_ORANGE, "chest", "IDK", 2000, 2.2, 5000, 50, 16, 17, 8, 10, 60, 70)
	Apparel(2067, "Power Armor Pants", RARITY_ORANGE, "pants", "IDK", 1900, 2.2, 4600, 50, 16, 17, 8, 10, 60, 70)
	Apparel(2069, "Power Armor Gloves", RARITY_ORANGE, "gloves", "IDK",1700, 2.2, 4000, 50, 14, 15, 6, 7, 45, 55)
	Apparel(2070, "Power Armor Shoes", RARITY_ORANGE, "shoes", "IDK", 1600, 2.2, 4000, 50, 14, 15, 6, 7, 45, 55)
end)
