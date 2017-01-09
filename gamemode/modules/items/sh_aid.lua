
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

function addAid(id, name, entity, model, weight, value)
	Aid[id] = {
		name = name,
		entity = entity,
		model = model,
		weight = weight,
		value = value,
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

addAid(4001, "12 Gauge", "12Gauge", "models/items/boxbuckshot.mdl", 0.10, 0.25)