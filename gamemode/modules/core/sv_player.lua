
util.AddNetworkString("loadPlayerData")
util.AddNetworkString("loadPlayerDataFinish")
util.AddNetworkString("loadClientside")

local meta = FindMetaTable("Player")

// Called after 'playerData' table is set on client
function meta:postLoadPlayer()
	// Send the players data to the clientside
	self:sendClientside()

	// The player has been loaded in
	self.loaded = true
	
	// Set team
	self:SetTeam(self.playerData.faction)
	
	self:Spawn()
end

// Get data from 'playerdata' for specific player, send them to team selection if they aren't in the table
function meta:loadPlayer()
	MySQLite.query("SELECT * FROM playerdata WHERE steamid = '" ..self:SteamID() .."'", function(results)
		// The player is not in the 'playerdata' table. They haven't selected a faction yet
		if !results then
			self:selectTeam()
		else
			// The player is in the playerdata table
			self.playerData = results[1] // Load their playerData
			self:initializeRank() // Load their rank
			
			net.Start("loadPlayerData")
				net.WriteTable(self.playerData)
				net.WriteEntity(self)
			net.Send(self)
		end
	end)
end

// Get the data of all existing players that are loaded on the server
function meta:loadAllClientside()
	for k,v in pairs(player.GetAll()) do
		if v != self and v.loaded then
			self:loadClientside(v)
		end
	end
end

// Send newly loaded player to all the players on their clientside
function meta:sendClientside()
	print("Sending to clients")

	// Send the new player to all client's on the server
	local data = self.playerData
	net.Start("sendClientside")
		net.WriteEntity(self)
		net.WriteString(data.name)
		net.WriteInt(data.experience, 32)
		net.WriteInt(data.strength, 8)
		net.WriteTable(self.equipped)
		
		net.WriteInt(self:getKills(), 16)
		net.WriteString(self:getRank())
	net.Broadcast()
end

// Get the data of an existing player that's loaded on the server
function meta:loadClientside(ply)
	local data = ply.playerData
	net.Start("loadClientside")
		net.WriteEntity(ply)
		net.WriteString(data.name)
		net.WriteInt(data.experience, 32)
		net.WriteInt(data.strength, 8)
		net.WriteTable(ply.equipped)
		
		net.WriteInt(ply:getKills(), 16)
		net.WriteString(ply:getRank())
	net.Send(self)
end

// Get all data related to a player when they join
function meta:load()
	self:Team(TEAM_FACTIONLESS) //Temporarily set their team while they're still loading

	//Load Player
	self:loadPlayer()
	
	//Load Inventory and Equipped
	self:loadInventory()
	
	//Load Bank
	self:loadBank()
	
	//Load Titles
	self:loadTitles()
	
	//Load existing players data to clientside
	self:loadAllClientside()
end

// Make all of the data nil that is related to the player who disconnected
function meta:unload()
	//Unload Player

	//Unload Inventory
	
	//Unload Equipped
	
	//Unload Bank
end

net.Receive("loadPlayerDataFinish", function(len, ply)
	if IsValid(ply) then
		ply:postLoadPlayer()
	end
end)