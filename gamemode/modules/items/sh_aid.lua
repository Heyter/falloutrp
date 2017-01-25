
Aid = {}

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

addAid(3001, "Regen Potion", "modelx", 2, 30, nil, 100, 2, 60)

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
		return health .." HP over " ..time " seconds"
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

addAid(4001, "Stimpack", "models/healthvial.mdl", 4, 25, 25)
addAid(4002, "Super Stimpack", "models/items/healthkit.mdl", 4, 50, 50)
addAid(4003, "Water Bottle", "models/drug_mod/the_bottle_of_water.mdl", 4, 15, nil, nil, nil, nil, nil, 40)
addAid(4004, "Watermelon", "models/props_junk/watermelon01.mdl", 4, 15, nil, nil, nil, nil, 30, 15)