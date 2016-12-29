
//Server

local meta = FindMetaTable("Player")

function meta:loadInvMisc()
	// Get misc
	MySQLite.query("SELECT * FROM misc WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)	
end