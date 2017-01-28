
function GM:PlayerDeath(victim, inflictor, attacker)
	if IsValid(attacker) and attacker:IsPlayer() then
		attacker:addExp(100)
		attacker:notify("You have slayed " ..victim:getName(), NOTIFY_HINT)
		
		victim:notify("You have been slayed.", NOTIFY_HINT)
	end
	
	// Drop all items
	victim:dropAllInventory()
end