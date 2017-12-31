
local Ammo = Ammo or {}

local mt = {
	__call = function(table, id, name, rarity, type, entity, model, weight, value)
		local ammo = {
			name = name,
			rarity = rarity,
			type = type,
			entity = entity,
			model = model,
			weight = weight,
			value = value,
		}
		setmetatable(ammo, {__index = ITEM})

		Ammo[id] = ammo
		return ammo
	end
}
setmetatable(Ammo, mt)

function getAmmo()
	return Ammo
end

function findAmmo(id)
	if id then
		return Ammo[id]
	end
end

local meta = FindMetaTable("Player")

function meta:getAmmoWeightTotal()
	local weight = 0

	for k,v in pairs(self.inventory.ammo) do
		local itemWeight = v.quantity * findAmmo(v.classid):getWeight()

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

function meta:getAmmoQuantity(uniqueid)
	local quantity = self.inventory.ammo[uniqueid]["quantity"]

	return quantity or 1
end

timer.Simple(5, function()
	Ammo(3001, "Bullets", RARITY_WHITE, "Bullets", "5mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
	Ammo(3002, "Plasma", RARITY_WHITE, "Plasma", "alienpowercells", "models/items/boxsrounds.mdl", 0.10, 0.25)
	Ammo(3003, "Energy", RARITY_WHITE, "Energy", "energycells", "models/items/boxsrounds.mdl", 0.10, 0.25)
	Ammo(3004, "Grenade", RARITY_WHITE, "Grenade", "halo_ammo_40mm", "models/items/boxsrounds.mdl", 0.10, 0.25)
end)
