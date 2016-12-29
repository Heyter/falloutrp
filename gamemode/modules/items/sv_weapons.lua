
//Server

local meta = FindMetaTable("Player")

function meta:loadInvWeapons()
	// Get weapons (get NOT equipped)
	MySQLite.query("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		for k, v in pairs(results) do
			self.inventory["weapons"][v.uniqueid] = {
				classid = v.classid,
				stat1 = v.stat1,
				equipped = tobool(v.equipped),
				uniqueid = v.uniqueid
			}
		end
		
		self:loadInventoryCount()
	end)	
end