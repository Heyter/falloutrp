
util.AddNetworkString("pickUpApparel")

local meta = FindMetaTable("Player")

function meta:loadInvApparel()
	MySQLite.query("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(results)
		if results then
			for k, v in pairs(results) do
				self.inventory["apparel"][v.uniqueid] = {
					classid = v.classid,
					damageThreshold = v.damageThreshold,
					damageReflection = v.damageReflection,
					bonusHp = v.bonusHp,
					durability = v.durability,
					equipped = tobool(v.equipped),
					uniqueid = v.uniqueid
				}
				
				if tobool(v.equipped) then
					self.equipped["apparel"][getApparelType(v.classid)] = {
						classid = v.classid,
						damageThreshold = v.damageThreshold,
						damageReflection = v.damageReflection,
						bonusHp = v.bonusHp,
						durability = v.durability,
						uniqueid = v.uniqueid
					}
				end
			end
		end
	
		self:loadInventoryCount()
	end)	
end

function meta:pickUpApparel(apparel)
	print("Printing before insert")
	PrintTable(apparel)
	MySQLite.query("INSERT INTO apparel (steamid, classid, damageThreshold, damageReflection, bonusHp, durability) VALUES ('" ..self:SteamID() .."', " ..apparel.classid ..", " ..apparel.damageThreshold ..", " ..apparel.damageReflection ..", " ..apparel.bonusHp ..", " ..apparel.durability ..")", function()
		// Get the last inserted id so we can store that in lua
		MySQLite.query("SELECT uniqueid FROM weapons ORDER BY uniqueid DESC LIMIT 1", function(results)
			local uniqueid = 0
			if results and results[1] then
				uniqueid = results[1]["uniqueid"]
			end
			
			// Do the inventory logic for inserting below here
			apparel.uniqueid = uniqueid
			self.inventory.apparel[uniqueid] = apparel
			
			net.Start("pickUpApparel")
				net.WriteInt(uniqueid, 32)
				net.WriteTable(apparel)
			net.Send(self)
		end)
	end)
end