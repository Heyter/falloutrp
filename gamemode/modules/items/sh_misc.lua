
Misc = {}

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

addMisc(5001, "Broken helicopter piece", "models/Gibs/helicopter_brokenpiece_02.mdl", 1.5, 15)