
util.AddNetworkString("updateTitleCreations")

local meta = FindMetaTable("Player")

// Get data from 'titles' for specific player
function meta:loadTitles()
	self.titles = {}

	MySQLite.query("SELECT * FROM titles WHERE steamid = '" ..self:SteamID() .."'", function(results)
		// The player has no titles
		if results then
			for k,v in pairs(results) do
				local tbl = {title = v.title, equipped = v.equipped, right = v.right}
				
				table.insert(self.titles, tbl)
				
				// Remember whether or not the title is currently equipped
				if tobool(v.equipped) then
					self.title = tbl
				end
			end
		end
	end)
end

function meta:addTitleCreation()
	self.playerData.titlecreations = self:getTitleCreations() + 1
	
	local creations = self:getTitleCreations()
	
	MySQLite.query("UDPATE SET titlecreations = " ..creations .." WHERE steamid = '" ..self:SteamID() .."'")
	
	net.Start("updateTitleCreations")
		net.WriteInt(creations, 8)
	net.Send(self)
end

function meta:addTitle(title)
	table.insert(self.titles, {title})

	MySQLite.query("INSERT INTO titles (steamid, title, right) VALUES ('" ..self:SteamID() .."', " ..title.title ..", " ..title.right ..")")
end

function meta:equipTitle(title)

end