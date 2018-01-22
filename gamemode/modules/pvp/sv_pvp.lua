
util.AddNetworkString("pvpProtection")
util.AddNetworkString("togglePvp")

local meta = FindMetaTable("Player")

function meta:playerDeathExp()
	local level = self:getLevel()

	return level * PVP_EXPERIENCE_LEVEL
end

// Pvp Protection
function meta:pvpProtection()
	if self.newPlayer then
		self.pvpProtected = true
		return
	end

	if self:getLevel() <= PVP_PROTECTION_LEVEL then
		net.Start("pvpProtection")

		net.Send(self)
	else
		self.pvpProtected = false
	end
end

function meta:togglePvp(toggle)
	self.pvpProtected = toggle

	if toggle then
		self:notify("PvP protection enabled.", NOTIFY_GENERIC)
	else
		self:notify("PvP protection disabled.", NOTIFY_ERROR)
	end
end

local function sayPvpToggle(ply, text)
	if string.sub(text, 1, #"/pvp") == "/pvp" then
		if ply.spawnProtected then
			if ply:getLevel() <= PVP_PROTECTION_LEVEL then
				ply:togglePvp(!ply.pvpProtected)
			else
				ply:notify("This is only available for players level " ..PVP_PROTECTION_LEVEL .." and below!", NOTIFY_ERROR)
			end
		else
			ply:notify("You can only do this in spawn!", NOTIFY_ERROR)
		end
		return ""
	end
end
hook.Add("PlayerSay", "PvpToggle", sayPvpToggle)

net.Receive("togglePvp", function(len, ply)
	local toggle = net.ReadBool()

	if IsValid(ply) then
		ply:togglePvp(toggle)
	end
end)

hook.Add("PlayerShouldTakeDamage", "PvpProtection", function(victim, attacker)
	if victim.pvpProtected and IsValid(attacker) and attacker:IsPlayer() and (attacker != victim) then
		attacker:notify("That player is PvP protected.", NOTIFY_ERROR)
		return false
	elseif attacker.pvpProtected then
		attacker:notify("You are PvP protected.", NOTIFY_ERROR)
		return false
	end
end)


// Spawn protection
hook.Add("PlayerShouldTakeDamage", "SpawnTeamKill", function(victim, attacker)
	if victim.spawnProtected then
		if IsValid(attacker) and attacker:IsPlayer() then
			attacker:notify("That player is spawn protected.", NOTIFY_ERROR)
		end
		return false
	elseif attacker.spawnProtected then
		attacker:notify("You are spawn protected.", NOTIFY_ERROR)
		return false
	end

	if victim:IsPlayer() and attacker:IsPlayer() then
		return victim:Team() != attacker:Team()
	end
end)
hook.Add("InitPostEntity", "SpawnZoneChecker", function()
	local sanctuaryStart, sanctuaryEnd = SANCTUARYZONE_START, SANCTUARYZONE_END
	local safeStart, safeEnd = SPAWNZONE_START, SPAWNZONE_END

	timer.Create("safeZone", 0.5, 0, function()
		for k,v in pairs(ents.FindInBox(sanctuaryStart, sanctuaryEnd)) do
			if IsValid(v) and v:IsPlayer() then
				v:addQuestProgress(1, 1, 1)

				v.spawnProtected = true

				if !v.onSpawnTimer then
					v.onSpawnTimer = true

					timer.Simple(10, function()
						if IsValid(v) then
							if !table.HasValue(ents.FindInBox(sanctuaryStart, sanctuaryEnd), v) then
								v.spawnProtected = false
							end
							v.onSpawnTimer = false
						end
					end)
				end
			end
		end

		for k,v in pairs(ents.FindInBox(safeStart, safeEnd)) do
			if IsValid(v) and v:IsPlayer() then
				v.spawnProtected = true

				if !v.onSpawnTimer then
					v.onSpawnTimer = true

					timer.Simple(10, function()
						if IsValid(v) then
							if !table.HasValue(ents.FindInBox(safeStart, safeEnd), v) then
								v.spawnProtected = false
							end
							v.onSpawnTimer = false
						end
					end)
				end
			end
		end
	end)
end)
