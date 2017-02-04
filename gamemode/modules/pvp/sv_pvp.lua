
util.AddNetworkString("pvpProtection")
util.AddNetworkString("togglePvp")

local meta = FindMetaTable("Player")

function meta:playerDeathExp()
	local level = self:getLevel()
	
	return level * PVP_EXPERIENCE_LEVEL
end

// Pvp Protection
function meta:pvpProtection()
	if self:getLevel() <= PVP_PROTECTION_LEVEL then
		net.Start("pvpProtection")
		
		net.Send(self)
	else
		self.pvpProtected = false
	end
end

net.Receive("togglePvp", function(len, ply)
	local toggle = net.ReadBool()

	if IsValid(ply) then
		ply.pvpProtected = toggle
		
		if toggle then
			ply:notify("PvP protection enabled.", NOTIFY_GENERIC)
		else
			ply:notify("PvP protection disabled.", NOTIFY_ERROR)
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "PvpProtection", function(victim, attacker)
	if victim.pvpProtected and IsValid(attacker) and attacker:IsPlayer() then
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
	local safeStart, safeEnd = SAFEZONE_START, SAFEZONE_END

	timer.Create("spawnZone", 0.5, 0, function()
		for k,v in pairs(ents.FindInBox(SAFEZONE_START, SAFEZONE_END)) do
			if IsValid(v) and v:IsPlayer() then
				v.spawnProtected = true
				
				if !v.onSpawnTimer then
					v.onSpawnTimer = true
					
					timer.Simple(10, function()
						if IsValid(v) then
							if !table.HasValue(ents.FindInBox(SAFEZONE_START, SAFEZONE_END), v) then
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