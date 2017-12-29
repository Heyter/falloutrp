
hook.Add("OnNPCKilled", "restoreNpcPosition", function(npc, attacker, inflictor)
	if npc.key then
		NPCS.npcs[npc:GetClass()]["Positions"][npc.key]["Active"] = false
	end
end)

hook.Add("OnNPCKilled", "npcExpLoot", function(npc, attacker, inflictor)
	local type = npc:GetClass()

	local npcLoot = getNpcLoot(type)
	local luckModifier = 0
	if IsValid(attacker) and attacker:IsPlayer() then
		luckModifier = attacker:getLuckModifier()
	end
	local randomLoot = generateRandomLoot(getNpcLevel(type), false, luckModifier)
	local actualLoot = {}

	for k,v in pairs(npcLoot) do
		// Don't drop quest items for players that don't have the quest
		if IsValid(attacker) and attacker:IsPlayer() and isQuestItem(k) then
			local quest = QUESTS:getItemQuest(k)
			if !attacker:hasQuest(quest) or attacker:isQuestComplete(quest) then
				continue
			end
		end

		local quantity = v.quantity
		quantity = math.random(quantity[1], quantity[2])

		local prob = v.prob

		if util.roll(prob, 100) then
			local item = createItem(k, quantity)

			table.insert(actualLoot, item)
		end
	end
	for k,v in pairs(randomLoot) do
		table.insert(actualLoot, v)
	end

	if actualLoot and #actualLoot > 0 then
		createLoot(npc:GetPos(), actualLoot)
	end

	if IsValid(attacker) and attacker:IsPlayer() then
		if attacker:hasXpShareParty() then
			attacker:shareXpParty(getNpcExp(type))
		else
			attacker:addExp(getNpcExp(type))
		end
	end
end)

function getActiveNpcs(type)
	local active = 0
	local inactive = {}

	for k, v in pairs(NPCS.npcs[type]["Positions"]) do
		if v.Active then
			active = active + 1
		else
			table.insert(inactive, k)
		end
	end

	return active, inactive
end

local function getNpcLimit(type)
	return NPCS.npcs[type]["Limit"]
end

function npcOutOfRange(npc, ply)
	if !IsValid(npc) or !IsValid(ply) or (npc:Health() <= 0) then return false end

	local recheck = NPCS.regenChecker

	if npc.lastHit and npc.lastHit + recheck > CurTime() then return false end
	if npc.lastRangeTest and npc.lastRangeTest + recheck > CurTime() then return false end

	npc.lastRangeTest = CurTime()

	local trace = {
		start = util.getFeetPosition(npc) + Vector(0, 0, 10),
		endpos = ply:GetShootPos() - Vector(0, 0, 20),
		filter = npc
	}

	local result = util.TraceLine(trace)

	local heightDistance = ply:GetPos().z - npc:GetPos().z

	if result.Entity != ply or (heightDistance > 225) then
		local maxHealth = getNpcHealth(npc:GetClass())

		// If it's a fallout configured npc
		if maxHealth != 100 then
			local regen = maxHealth * NPCS.regenPercentage

			if npc:Health() + regen > maxHealth then
				npc:SetHealth(maxHealth)
			else
				npc:SetHealth(npc:Health() + regen)
			end
		end

		return true
	else
		// Check if they havent moved since last chest
		if npc.lastPositionCheck and (npc.lastPositionCheck:Distance(npc:GetPos()) < 4) then
			npc.attackerBehindDoor = true
		end
	end

	npc.lastPositionCheck = npc:GetPos()

	return false
end

function spawnNpc(npc, inactiveNpcs)
	local randomLocation = table.Random(inactiveNpcs)
	local location = NPCS.npcs[npc]["Positions"][randomLocation]

	NPCS.npcs[npc]["Positions"][randomLocation]["Active"] = true

	local ent = ents.Create(npc)
	ent:SetPos(location["Position"] + Vector(0, 0, 40))
	ent:Spawn()
	ent:DropToFloor()
	ent:SetHealth(getNpcHealth(npc))
	ent.Damage = NPCS.npcs[npc]["Damage"]
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
	for npc, info in pairs(NPCS.npcs) do
		timer.Create(npc .." spawner", info.SpawnRate, 0, function()
			addNpc(npc)
		end)

		// Create some npcs on server start, so it isn't bare
		for i = 1, info.StartAmount do
			// Space out these timers some so we don't create a million entities all at once and stress the server
			timer.Simple(5 * i, function()
				addNpc(npc)
			end)
		end
	end
end

function spawnAllNpcs()
	local count = 1
	for k,v in pairs(NPCS) do
		for a, b in pairs(v.Positions) do
			if count < 175 then
				timer.Simple(0.25 * count, function()
					local ent = ents.Create(k)
					ent:SetPos(b.Position + Vector(0, 0, 40))
					ent:Spawn()
					ent:DropToFloor()
					ent:SetHealth(v.Health)
				end)
			end
			count = count + 1
		end
	end
end

hook.Add("InitPostEntity", "createNpcTimers", function()
	timer.Simple(1, function()
		createNpcTimers()
	end)

	// Set NPC damages
	timer.Simple(2, function()
		// Rat
		RunConsoleCommand("sk_giantrat_dmg_slash", 7)
		RunConsoleCommand("sk_giantrat_dmg_slash_power", 13)

		// Gecko
		RunConsoleCommand("sk_gecko_dmg_slash", 9)
		RunConsoleCommand("sk_gecko_dmg_slash_power", 15)

		// Trog
		RunConsoleCommand("sk_streettrog_dmg_slash", 13)
		RunConsoleCommand("sk_streettrog_dmg_slash_power", 19)

		// Mirelurk
		RunConsoleCommand("sk_mirelurk_dmg_slash", 10)
		RunConsoleCommand("sk_mirelurk_dmg_slash_power", 16)
		RunConsoleCommand("sk_mirelurk_dmg_strike", 20)

		// Cazador
		RunConsoleCommand("sk_cazador_dmg_slash", 12)
		RunConsoleCommand("sk_cazador_dmg_slash_power", 17)

		// Spore Carrier
		RunConsoleCommand("sk_sporecarrier_dmg_slash", 18)
		RunConsoleCommand("sk_sporecarrier_dmg_slash_power", 26)

		// Ghoul
		RunConsoleCommand("sk_ghoulferal_dmg_slash", 17)
		RunConsoleCommand("sk_ghoulferal_dmg_slash_power", 24)

		// Ghoul Roamer
		RunConsoleCommand("sk_ghoulferal_roamer_dmg_slash", 18)
		RunConsoleCommand("sk_ghoulferal_roamer_dmg_slash_power", 25)

		// Ghoul Swamp
		RunConsoleCommand("sk_ghoulferal_swamp_dmg_slash", 19)
		RunConsoleCommand("sk_ghoulferal_swamp_dmg_slash_power", 26)

		// Ghoul Reaver
		RunConsoleCommand("sk_ghoulferal_reaver_dmg_slash", 25)
		RunConsoleCommand("sk_ghoulferal_reaver_dmg_slash_power", 34)
		RunConsoleCommand("sk_ghoulferal_reaver_dmg_grenade", 45)

		// Swamplurk / Nukalurk
		RunConsoleCommand("sk_mirelurk_dmg_slash", 22)
		RunConsoleCommand("sk_mirelurk_dmg_slash_power", 26)
		RunConsoleCommand("sk_mirelurk_dmg_strike", 40)

		// Green Gecko
		RunConsoleCommand("sk_gecko_green_dmg_slash", 22)
		RunConsoleCommand("sk_gecko_green_dmg_slash_power", 26)
		RunConsoleCommand("sk_gecko_green_dmg_spit", 32)

		// Fire Gecko
		RunConsoleCommand("sk_gecko_fire_dmg_slash", 32)
		RunConsoleCommand("sk_gecko_fire_dmg_slash_power", 36)
		RunConsoleCommand("sk_gecko_fire_dmg_flame", 2)

		// Deathclaw
		RunConsoleCommand("sk_deathclaw_dmg_slash", 40)
		RunConsoleCommand("sk_deathclaw_dmg_slash_power", 45)
		RunConsoleCommand("sk_deathclaw_dmg_slash_power_jump", 55)

		// Deathclaw alphamale
		RunConsoleCommand("sk_deathclaw_alphamale_dmg_slash", 60)
		RunConsoleCommand("sk_deathclaw_alphamale_dmg_slash_power", 65)
		RunConsoleCommand("sk_deathclaw_alphamale_dmg_slash_power_jump", 75)
	end)
end)

function printNpcPositions()
	for k,v in pairs(ents.FindByModel("models/props_borealis/bluebarrel001.mdl")) do
		if v:GetColor().r == 63 and v:GetColor().g == 0 and v:GetColor().b == 0 then
			local p = v:GetPos()
			print("{Position = Vector(" ..math.floor(p[1]) ..", " ..math.floor(p[2]) ..", " ..math.floor(p[3]) .."), Active = false},")
		end
	end
end
