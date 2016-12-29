
//Server

local meta = FindMetaTable("Player")

function meta:loadInvAmmo()
	// Get ammo
	MySQLite.query("SELECT * FROM ammo WHERE steamid = '" ..self:SteamID() .."'", function(results)
		self:loadInventoryCount()
	end)
end