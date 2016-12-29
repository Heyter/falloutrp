
//Server

local meta = FindMetaTable("Player")

function meta:loadInvApparel()
	// Get apparel (get NOT equipped)
	MySQLite.query("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)	
end