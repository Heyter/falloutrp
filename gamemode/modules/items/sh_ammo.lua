
local Ammo = {}

local meta = FindMetaTable("Player")

function meta:getAmmoWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.ammo) do
		local itemWeight = v.quantity * getAmmoWeight(v.classid)

		weight = weight + itemWeight
	end

	return weight
end

function meta:hasAmmoItem(classid)
	for k,v in pairs(self.inventory.ammo) do
		if v.classid == classid then
			return self.inventory.ammo[v.uniqueid]
		end
	end

	return false
end

function addAmmo(id, name, type, entity, model, weight, value)
	Ammo[id] = {
		name = name,
		type = type,
		entity = entity,
		model = model,
		weight = weight,
		value = value,
	}
end

function findAmmo(id)
	if id then
		return Ammo[id]
	end
end

// Base functions that have data that will not change
function getAmmoName(id)
	if tonumber(id) then
		return (findAmmo(id) and findAmmo(id).name) or "N/A"
	end
end
function getAmmoType(id)
	return findAmmo(id).type
end
function getAmmoEntity(id)
	return findAmmo(id).entity
end
function getAmmoModel(id)
	return findAmmo(id).model
end
function getAmmoWeight(id)
	return findAmmo(id).weight
end
function getAmmoValue(id)
	return findAmmo(id).value
end

// Functions that have data which can change
function getAmmoNameQuantity(id, quantity)
	local name = getAmmoName(id)

	if util.positive(quantity) then
		name = name .." (" ..quantity ..")"
	end

	return name
end

function meta:getAmmoQuantity(uniqueid)
	local quantity = self.inventory.ammo[uniqueid]["quantity"]

	return quantity or 1
end

addAmmo(3001, "Bullets", "Bullets", "5mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3002, "Plasma", "Plasma", "alienpowercells", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3003, "Energy", "Energy", "energycells", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3004, "Grenade", "Grenade", "halo_ammo_40mm", "models/items/boxsrounds.mdl", 0.10, 0.25)
