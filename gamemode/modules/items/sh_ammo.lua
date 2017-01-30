
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

addAmmo(3001, ".22 LR", "22LR", "22lrammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3002, ".308", "308", "308ammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3003, ".32", "32", "32ammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3004, ".357 Magnum", "357Magnum", "357magnumammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3005, ".44 Magnum", "44Magnum", "44magnumammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3006, ".45 Auto", "45Auto", "45autoammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3007, ".45-70 Govt.", "45-70Govt", "45-70govtammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3008, ".50 MG", "50MG", "50mgammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3009, "10mm", "10mm", "10mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3010, "12 Gauge", "12Gauge", "12gaugeammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3011, "12.7mm", "127mm", "127mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3012, "20 Gauge", "20Gauge", "20gaugeammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3013, "25mm Grenade", "25mmGrenade", "halo_ammo_25mm", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3014, "40mm Grenade", "40mmGrenade", "halo_ammo_40mm", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3015, "5.56m", "556mm", "556mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3016, "5mm", "5mm", "5mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3017, "9mm", "9mm", "9mmammo", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3018, "Alien Power Cell", "AlienPowerCell", "alienpowercells", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3019, "Dart", "Dart", "darts", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3020, "Electron Charge Pack", "ElectronChargePack", "electronchargepacks", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3021, "Energy Cell", "EnergyCell", "energycells", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3022, "Flamer Fuel", "FlamerFuel", "flamerfuel", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3023, "Microfusion Cell", "MicrofusionCell", "microfusioncells", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3024, "Mini Nuke", "MiniNuke", "mininuke", "models/weapons/mininuke.mdl", 0.10, 0.25)
addAmmo(3025, "Missile", "Missile", "missiles", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3026, "Railway Spike", "RailwaySpike", "railwayspikes", "models/items/boxsrounds.mdl", 0.10, 0.25)
addAmmo(3027, "Rocket", "Rocket", "rockets", "models/items/boxsrounds.mdl", 0.10, 0.25)