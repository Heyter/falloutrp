
// Pvp Protection


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
	
	return true
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