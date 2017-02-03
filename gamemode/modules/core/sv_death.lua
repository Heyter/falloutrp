
function GM:PlayerDeath(victim, inflictor, attacker)
	if IsValid(attacker) and attacker:IsPlayer() then
		attacker:addExp(victim:playerDeathExp())
		attacker:notify("You have slayed " ..victim:getName(), NOTIFY_GENERIC)
		
		victim:notify("You have been slayed by " ..attacker:getName(), NOTIFY_GENERIC)
	else
		victim:notify("You have been slayed.", NOTIFY_GENERIC)
	end
	
	// Drop all items
	victim:dropAllInventory()
end