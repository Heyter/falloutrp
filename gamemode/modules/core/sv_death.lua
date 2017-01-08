
function GM:PlayerDeath(victim, inflictor, attacker)
	// Drop all items
	victim:dropAllInventory()
end