
local Aid = Aid or {}

local mt = {
	__call = function(table, id, name, rarity, model, weight, value, healthPercent, health, timeInterval, timeLength, hunger, thirst)
		local aid = {
			id = id,
			name = name,
			rarity = rarity,
			model = model,
			weight = weight,
			value = value,
			healthPercent = healthPercent,
			health = health,
			timeInterval = timeInterval,
			timeLength = timeLength,
			hunger = hunger,
			thirst = thirst
		}
		setmetatable(aid, {__index = ITEM})

		function aid:getHealthPercent()
			return self.healthPercent
		end
		function aid:getHealth()
			return self.health
		end
		function aid:getTimeInterval()
			return self.timeInterval
		end
		function aid:getTimeLength()
			return self.timeLength
		end
		function aid:getHunger()
			return self.hunger
		end
		function aid:getThirst()
			return self.thirst
		end 
		function aid:getHealthOverTime()
			if self.health and self.timeLength then
				return self.health .." HP over " ..self.timeLength .." seconds"
			end
		end

		addToLoot(aid)

		Aid[id] = aid
		return aid
	end
}
setmetatable(Aid, mt)

function findAid(id)
	if id then
		return Aid[id]
	end
end

local meta = FindMetaTable("Player")

function meta:getAidWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.aid) do
		local itemWeight = v.quantity * findAid(v.classid):getWeight()

		weight = weight + itemWeight
	end

	return weight
end

function meta:hasAidItem(classid)
	for k,v in pairs(self.inventory.aid) do
		if v.classid == classid then
			return self.inventory.aid[v.uniqueid]
		end
	end

	return false
end

function meta:getAidQuantity(uniqueid)
	local quantity = self.inventory.aid[uniqueid]["quantity"]

	return quantity or 1
end

timer.Simple(5, function()
	Aid(4001, "Stimpak", RARITY_WHITE, "models/mosi/fallout4/props/aid/stimpak.mdl", 0.2, 150, 25)
	Aid(4002, "Super Stimpak", RARITY_WHITE, "models/mosi/fallout4/props/aid/stimpak.mdl", 0.2, 300, 50)
	Aid(4003, "Lay of Hands", RARITY_WHITE, "models/mosi/fallout4/props/aid/syringeammo.mdl", 0.2, 1500, 100)
	Aid(4004, "Blood Bag", RARITY_WHITE, "models/mosi/fallout4/props/aid/bloodbag.mdl", 5, 300, nil, 100)
	Aid(4005, "Blood Serum", RARITY_WHITE, "models/mosi/fallout4/props/aid/mysteriousserum.mdl", 5, 600, nil, 200, 2, 10)
	Aid(4006, "Water Bottle", RARITY_WHITE, "models/props/cs_office/Water_bottle.mdl", 4, 50, nil, nil, nil, nil, nil, 45)
	Aid(4007, "Milk", RARITY_WHITE, "models/props_junk/garbage_milkcarton002a.mdl", 4, 20, nil, nil, nil, nil, nil, 20)
	Aid(4008, "Watermelon", RARITY_WHITE, "models/props_junk/watermelon01.mdl", 4, 75, nil, nil, nil, nil, 50, 20)
	Aid(4009, "Chinese Takeout", RARITY_WHITE, "models/props_junk/garbage_takeoutcarton001a.mdl", 4, 50, nil, nil, nil, nil, 45)
	Aid(4010, "Can of Beans", RARITY_WHITE, "models/props_junk/garbage_metalcan001a.mdl", 4, 30, nil, nil, nil, nil, 25)
	Aid(4011, "Soda", RARITY_WHITE, "models/props_junk/PopCan01a.mdl", 4, 15, nil, nil, nil, nil, nil, 20)
	Aid(4012, "Malt Liquor", RARITY_WHITE, "models/props_junk/garbage_glassbottle001a.mdl", 4, 10, nil, nil, nil, nil, nil, 15)
	Aid(4013, "Cactus", RARITY_WHITE, "models/props_lab/cactus.mdl", 4, 40, nil, -5, nil, nil, 35)
	Aid(4014, "Chunk of Meat", RARITY_WHITE, "models/Gibs/Antlion_gib_Large_2.mdl", 4, 40, nil, nil, nil, nil, 30)
end)
