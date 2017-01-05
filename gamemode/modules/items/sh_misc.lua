
Misc = {}

local meta = FindMetaTable("Player")

function meta:getMiscWeightTotal()
	local weight = 0
	
	for k,v in pairs(self.inventory.misc) do
		local itemWeight = v.quantity * getMiscWeight(v.classid)
		
		weight = weight + itemWeight
	end
	
	return weight
end

function meta:hasMiscItem(classid)
	for k,v in pairs(self.inventory.misc) do
		if v.classid == classid then
			return self.inventory.misc[v.uniqueid]
		end
	end
	
	return false
end

function addMisc(id, name, model, weight, value)
	Misc[id] = {
		name = name,
		model = model,
		weight = weight,
		value = value,
	}
end

function findMisc(id)
	if id then
		return Misc[id]
	end
end

// Base functions that have data that will not change
function getMiscName(id)
	return findMisc(id).name
end
function getMiscModel(id)
	return findMisc(id).model
end
function getMiscWeight(id)
	return findMisc(id).weight
end
function getMiscValue(id)
	return findMisc(id).value
end

// Functions that have data which can change
function getMiscNameQuantity(id, quantity)
	local name = getMiscName(id)
	
	if util.positive(quantity) then
		name = name .." (" ..quantity ..")"
	end
	
	return name
end

function meta:getMiscQuantity(uniqueid)
	local quantity = self.inventory.misc[uniqueid]["quantity"]
	
	return quantity or 1
end

addMisc(5001, "Broken helicopter piece", "models/Gibs/helicopter_brokenpiece_02.mdl", 1.5, 15)