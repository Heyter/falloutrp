
hook.Add("PlayerInitialSpawn", "LoadPlayerData", function(ply)
	// Load player, inventory, equipment, bank
	print("Loading " ..ply:SteamID() .."'s data.")
	ply:load()
end)

hook.Add("PlayerDisconnected", "UnloadPlayerData", function(ply)
	// Unload player, inventory, equipment, bank
	ply:unload()
end)