
// Server
hook.Add("OnNPCKilled", "restoreNpcPosition", function(npc, attacker, inflictor)
	if npc.key then
		print(NPCS[npc:GetClass()]["Positions"][npc.key]["Active"])
		NPCS[npc:GetClass()]["Positions"][npc.key]["Active"] = false
	end
end)

function getActiveNpcs(type)
	local active = 0
	local inactive = {}
	
	for k, v in pairs(NPCS[type]["Positions"]) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end
	 
	return active, inactive
end

local function getNpcLimit(type)
	return NPCS[type]["Limit"]
end

function getNpcHealth(type)
	return NPCS[type]["Health"] or 100
end

function spawnNpc(npc, inactiveNpcs)
	local randomLocation = table.Random(inactiveNpcs)
	local location = NPCS[npc]["Positions"][randomLocation]
		
	NPCS[npc]["Positions"][randomLocation]["Active"] = true
	
	local ent = ents.Create(npc)
	ent:SetPos(location["Position"])
	ent:Spawn()
	ent:SetHealth(getNpcHealth(npc))
	ent.key = randomLocation // So we know which position to restore to inactive when the npc dies
end

function addNpc(npc)
	local numActive, inactiveNpcs = getActiveNpcs(npc)
	 
	if numActive < getNpcLimit(npc) then
		// Haven't hit the limit for amount of this npc's yet
		spawnNpc(npc, inactiveNpcs)
	end
end

function createNpcTimers()
	for npc, info in pairs(NPCS) do
		timer.Create(npc .." spawner", info.SpawnRate, 0, function()
			addNpc(npc)
		end)
		
		// Create some npcs on server start, so it isn't bare
		for i = 1, info.StartAmount do
			// Space out these timers some so we don't create a million entities all at once and stress the server
			timer.Simple(1 * i, function()
				addNpc(npc)
			end)
		end
	end
end

function spawnAllNpcs()
	for k,v in pairs(NPCS) do
		for a, b in pairs(v.Positions) do
			local ent = ents.Create(k)
			ent:SetPos(b.Position)
			ent:Spawn()
			ent:SetHealth(v.Health)
		end
	end
end

hook.Add("InitPostEntity", "createNpcTimers", function()
	timer.Simple(1, function()
		createNpcTimers()
	end)
end)

function printNpcPositions()
	for k,v in pairs(ents.FindByModel("models/props_borealis/bluebarrel001.mdl")) do
		local p = v:GetPos()
		print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) .."), Active = false},")
	end
end