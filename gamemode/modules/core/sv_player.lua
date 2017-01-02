
util.AddNetworkString("loadPlayerData")

local meta = FindMetaTable("Player")

// Get data from 'playerdata' for specific player, send them to team selection if they aren't in the table
function meta:loadPlayer()
	MySQLite.query("SELECT * FROM playerdata WHERE steamid = '" ..self:SteamID() .."'", function(results)
		// The player is not in the 'playerdata' table. They haven't selected a faction yet
		if !results then
			self:selectTeam()
		else
			self.playerData = results[1]
			
			net.Start("loadPlayerData")
				net.WriteTable(self.playerData)
				net.WriteEntity(self)
			net.Broadcast()
		end
	end)
end

// Get all data related to a player when they join
function meta:load()
	self:Team(TEAM_FACTIONLESS) //Temporarily set their team while they're still loading

	//Load Player
	self:loadPlayer()
	
	//Load Inventory and Equipped
	self:loadInventory()
	
	//Load Bank
end

// Make all of the data nil that is related to the player who disconnected
function meta:unload()
	//Unload Player

	//Unload Inventory
	
	//Unload Equipped
	
	//Unload Bank
end