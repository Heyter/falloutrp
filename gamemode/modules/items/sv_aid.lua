
//Server

local meta = FindMetaTable("Player")

function meta:loadInvAid()
	// Get aid
	MySQLite.query("SELECT * FROM aid WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)	
end