
local Aid = {}

local meta = FindMetaTable("Player")

function meta:getAidWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.aid) do
		local itemWeight = v.quantity * getAidWeight(v.classid)

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

function addAid(id, name, model, weight, value, healthPercent, health, timeInterval, timeLength, hunger, thirst)
	Aid[id] = {
		name = name,
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
end

function findAid(id)
	if id then
		return Aid[id]
	end
end

// Base functions that have data that will not change
function getAidName(id)
	return findAid(id).name
end
function getAidEntity(id)
	return findAid(id).entity
end
function getAidModel(id)
	return findAid(id).model
end
function getAidWeight(id)
	return findAid(id).weight
end
function getAidValue(id)
	return findAid(id).value
end
function getAidHealthPercent(id)
	return findAid(id).healthPercent
end
function getAidHealth(id)
	return findAid(id).health
end
function getAidTimeInterval(id)
	return findAid(id).timeInterval
end
function getAidTimeLength(id)
	return findAid(id).timeLength
end
function getAidHunger(id)
	return findAid(id).hunger
end
function getAidThirst(id)
	return findAid(id).thirst
end
function getAidHealthOverTime(id)
	local health = getAidHealth(id)
	local time = getAidTimeLength(id)

	if health and time then
		return health .." HP over " ..time .." seconds"
	end
end

// Functions that have data which can change
function getAidNameQuantity(id, quantity)
	local name = getAidName(id)

	if util.positive(quantity) then
		name = name .." (" ..quantity ..")"
	end

	return name
end

function meta:getAidQuantity(uniqueid)
	local quantity = self.inventory.aid[uniqueid]["quantity"]

	return quantity or 1
end

addAid(4001, "Stimpack", "models/mosi/fallout4/props/aid/stimpak.mdl", 0.2, 150, 25)
addAid(4002, "Super Stimpack", "models/mosi/fallout4/props/aid/stimpak.mdl", 0.2, 300, 50)
addAid(4003, "Lay of Hands", "models/mosi/fallout4/props/aid/syringeammo.mdl", 0.2, 1500, 100)
addAid(4004, "Blood Bag", "models/mosi/fallout4/props/aid/bloodbag.mdl", 5, 300, nil, 100)
addAid(4005, "Blood Serum", "models/mosi/fallout4/props/aid/mysteriousserum.mdl", 5, 600, nil, 200, 2, 10)
addAid(4006, "Water Bottle", "models/props/cs_office/Water_bottle.mdl", 4, 50, nil, nil, nil, nil, nil, 45)
addAid(4007, "Milk", "models/props_junk/garbage_milkcarton002a.mdl", 4, 20, nil, nil, nil, nil, nil, 20)
addAid(4008, "Watermelon", "models/props_junk/watermelon01.mdl", 4, 75, nil, nil, nil, nil, 50, 20)
addAid(4009, "Chinese Takeout", "models/props_junk/garbage_takeoutcarton001a.mdl", 4, 50, nil, nil, nil, nil, 45)
addAid(4010, "Can of Beans", "models/props_junk/garbage_metalcan001a.mdl", 4, 30, nil, nil, nil, nil, 25)
addAid(4011, "Soda", "models/props_junk/PopCan01a.mdl", 4, 15, nil, nil, nil, nil, nil, 20)
addAid(4012, "Malt Liquor", "models/props_junk/garbage_glassbottle001a.mdl", 4, 10, nil, nil, nil, nil, nil, 15)
addAid(4013, "Cactus", "models/props_lab/cactus.mdl", 4, 40, nil, -5, nil, nil, 35)
addAid(4014, "Chunk of Meat", "models/Gibs/Antlion_gib_Large_2.mdl", 4, 40, nil, -5, nil, nil, 30)
