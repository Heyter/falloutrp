
// Server
local function getRandomSize(type)
	local info, size = table.Random(SCAVENGE[type]["Sizes"])

	return info, size
end

local function getScavengeLimit(type)
	return SCAVENGE[type]["Limit"]
end

function getActiveScavenge(type)
	local active = 0
	local inactive = {}
	
	for k, v in pairs(SCAVENGE[type]["Positions"]) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end
	 
	return active, inactive
end

function spawnScavenge(type, inactiveScavenge)
	local randomLocation = table.Random(inactiveScavenge)
	local location = SCAVENGE[type]["Positions"][randomLocation]
		
	local sizeInfo, size = getRandomSize(type)
	local prop = table.Random(sizeInfo.Props)
	local count = math.random(sizeInfo.Amount[1], sizeInfo.Amount[2])	
	
	SCAVENGE[type]["Positions"][randomLocation]["Active"] = true
	
	local ent = ents.Create("scavenge")
	ent:SetPos(location["Position"] + Vector(0, 0, 50))
	ent:SetModel(prop)
	ent:setType(type)
	ent:setCount(count)
	ent:Spawn()
	ent:DropToFloor()
	ent.key = randomLocation // So we know which position to restore to inactive when the npc dies
end

function addScavenge(type)
	local numActive, inactiveScavenge = getActiveScavenge(type)
	 
	if numActive < getScavengeLimit(type) then
		// Haven't hit the limit for amount of this npc's yet
		spawnScavenge(type, inactiveScavenge)
	end
end

function createScavengeTimers()
	for type, info in pairs(SCAVENGE) do
		timer.Create(type .." spawner", SCAVENGE_TIMER, 0, function()
			addScavenge(type)
		end)
		
		// Create some scavenge on server start, so it isn't bare
		for i = 1, SCAVENGE_START do
			// Space out these timers some so we don't create a million entities all at once and stress the server
			timer.Simple(1 * i, function()
				addScavenge(type)
			end)
		end
	end
end


function spawnAllScavenge()
	for k,v in pairs(SCAVENGE) do
		for a, b in pairs(v.Positions) do
			addScavenge(k)
		end
	end
end

hook.Add("InitPostEntity", "createScavengeTimers", function()
	timer.Simple(1, function()
		createScavengeTimers()
	end)
end)

function printScavengePositions()
	for k,v in pairs(ents.FindByModel("models/props_borealis/bluebarrel001.mdl")) do
		local p = v:GetPos()
		print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) .."), Active = false},")
	end
end
// Server