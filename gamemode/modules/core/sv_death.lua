
function GM:PlayerDeath(victim, inflictor, attacker)
	if IsValid(attacker) and attacker:IsPlayer() then
		if attacker != victim then
			attacker:addExp(victim:playerDeathExp())
			attacker:addKill()

			attacker:notify("You have slayed " ..victim:getName(), NOTIFY_GENERIC)
			victim:notify("You have been slayed by " ..attacker:getName(), NOTIFY_GENERIC)
		end
	else
		victim:notify("You have been slayed.", NOTIFY_GENERIC)
	end

	// Drop all items
	// victim:dropAllInventory()
end
