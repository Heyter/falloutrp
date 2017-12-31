
util.AddNetworkString("pickUpWeapon")

local meta = FindMetaTable("Player")

function meta:loadInvWeapons()
	DB:RunQuery("SELECT * FROM weapons WHERE steamid = '" ..self:SteamID() .."' AND banked IS NULL", function(query, status, data)
		if data and data[1] then
			for k, v in pairs(data) do
				local weapon = findWeapon(v.classid)

				self.inventory["weapons"][v.uniqueid] = {
					classid = v.classid,
					damage = v.damage,
					durability = v.durability,
					equipped = tobool(v.equipped),
					uniqueid = v.uniqueid
				}

				if tobool(v.equipped) then
					self.equipped["weapons"][weapon:getSlot()] = {
						classid = v.classid,
						damage = v.damage,
						durability = v.durability,
						uniqueid = v.uniqueid
					}

					self:wieldWeapon(v.classid)
				end
			end
		end

		self:loadInventoryCount()
	end)
end

function meta:pickUpWeapon(weapon)
	print(weapon)
	DB:RunQuery("INSERT INTO weapons (steamid, classid, damage, durability) VALUES ('" ..self:SteamID() .."', " ..weapon.classid ..", " ..weapon.damage ..", " ..weapon.durability .."); SELECT LAST_INSERT_ID();", function(query, status, data)
		// Get the last inserted id so we can store that in lua
		local uniqueid = query:getNextResults()[1]["LAST_INSERT_ID()"]
		weapon.uniqueid = uniqueid
		self.inventory.weapons[uniqueid] = weapon

		net.Start("pickUpWeapon")
			net.WriteInt(uniqueid, 32)
			net.WriteTable(weapon)
		net.Send(self)
	end)
end
