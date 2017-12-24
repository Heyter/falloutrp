
util.AddNetworkString("updateKills")
util.AddNetworkString("updateRank")

local meta = FindMetaTable("Player")

function meta:addKill()
	self.playerData.playerkills = self:getKills() + 1
	
	local kills = self:getKills()
	
	DB:RunQuery("UPDATE playerdata SET playerkills = " ..kills .." WHERE steamid = '" ..self:SteamID() .."'")
	
	net.Start("updateKills")
		net.WriteEntity(self)
		net.WriteInt(kills, 16)
	net.Broadcast()
	
	// Unlocked a new rank at this level
	if getRanks()[self:Team()][kills] then
		self:setRank(getRanks()[self:Team()][kills])
	end
	
end

// Get the player's rank based on their kills when they join the server
function meta:initializeRank()
	local rank = ""
	local amount = -1
	
	for kills, name in pairs(getRanks()[self.playerData.faction]) do
		if (kills > amount) and (self:getKills() >= kills) then
			rank = name
		end
	end
	
	self.playerData.rank = rank
end

function meta:setRank(rank)
	self.playerData.rank = rank or ""
	
	net.Start("updateRank")
		net.WriteEntity(self)
		net.WriteString(self:getRank())
	net.Broadcast()
end