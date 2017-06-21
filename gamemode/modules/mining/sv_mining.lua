
// Server
local function getRandomSize(type)
	local info, size = table.Random(VEINS[type]["Sizes"])

	return info, size
end

function spawnVein(inactiveVeins, type)
	local randomLocation = table.Random(inactiveVeins)
	local location = VEINS[type]["Positions"][randomLocation]

	local sizeInfo, size = getRandomSize(type)
	local prop = table.Random(sizeInfo.Props)
	local oreCount = math.random(sizeInfo.Amount[1], sizeInfo.Amount[2])

	local vein = ents.Create("vein")
	vein:SetModel(prop)
	vein:SetPos(location["Position"])
	vein:setType(type)
	vein:setOres(oreCount)

	VEINS[type]["Positions"][randomLocation]["Active"] = true // Set the location to active
	vein.key = randomLocation // So we know which location to set inactive when the vein is gone

	vein:Spawn()
end

function getActiveVeins(type)
	local active = 0
	local inactive = {}

	for k, v in pairs(VEINS[type]["Positions"]) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end

	return active, inactive
end

function getVeinLimit(type)
	return VEINS[type]["Limit"]
end

local types = {"Common", "Uncommon", "Rare"}
function addVeins()
	for k,v in pairs(types) do
		local numActive, inactiveVeins = getActiveVeins(v)

		if numActive < getVeinLimit(v) then
			// If we haven't hit the limit for amount of chests on the map
			spawnVein(inactiveVeins, v)
		end
	end
end

function beginVeinTimer()
	timer.Create("veinSpawn", VEIN_TIMER, 0, function()
		addVeins()
	end)
end

hook.Add("InitPostEntity", "startVeinTimer", function()
	timer.Simple(5, function()
		beginVeinTimer()
	end)
end)
