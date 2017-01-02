
hook.Add("PlayerInitialSpawn", "LoadPlayerData", function(ply)
	// Load player, inventory, equipment, bank
	timer.Simple(5, function()
		print("Loading " ..ply:SteamID() .."'s data.")
		ply:load()
	end)
end)

hook.Add("PlayerDisconnected", "UnloadPlayerData", function(ply)
	// Unload player, inventory, equipment, bank
	ply:unload()
end)