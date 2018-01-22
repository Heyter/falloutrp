
util.AddNetworkString("pickUpApparel")

local meta = FindMetaTable("Player")

function meta:loadInvApparel()
	DB:RunQuery("SELECT * FROM apparel WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(query, status, data)
		if data and data[1] then
			for k, v in pairs(data) do
				local apparel = findApparel(v.classid)

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
					self.equipped["apparel"][apparel:getSlot()] = {
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
	DB:RunQuery("INSERT INTO apparel (steamid, classid, damageThreshold, damageReflection, bonusHp, durability) VALUES ('" ..self:SteamID() .."', " ..apparel.classid ..", " ..apparel.damageThreshold ..", " ..apparel.damageReflection ..", " ..apparel.bonusHp ..", " ..apparel.durability .."); SELECT LAST_INSERT_ID();", function(query, status, data)
		// Get the last inserted id so we can store that in lua
		local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
		apparel.uniqueid = uniqueid
		self.inventory.apparel[uniqueid] = apparel

		net.Start("pickUpApparel")
			net.WriteInt(uniqueid, 32)
			net.WriteTable(apparel)
		net.Send(self)
	end)
end
