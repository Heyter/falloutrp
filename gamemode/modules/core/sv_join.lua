
hook.Add("InitialPlayerSpawn", "LoadPlayerData", function(ply)
	// Load player, inventory, equipment, bank
	ply:load()
end)

hook.Add("PlayerDisconnected", "UnloadPlayerData", function(ply)
	// Unload player, inventory, equipment, bank
	ply:unload()
end)