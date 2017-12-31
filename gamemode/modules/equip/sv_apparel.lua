
util.AddNetworkString("unequipApparel")
util.AddNetworkString("equipApparel")

local meta = FindMetaTable("Player")

function meta:hasCurrentApparel(type)
	return self:getCurrentApparel(type) != nil
end

function meta:getCurrentApparelClass(type)
	return self:getCurrentApparel(type).classid
end

function meta:getCurrentApparelId(type)
	return self:getCurrentApparel(type).uniqueid
end

function meta:getCurrentApparel(type)
	return self.equipped.apparel[type]
end

function meta:canEquipApparel(classid)
	local apparel = findApparel(classid)

	return self:getLevel() >= apparel:getLevel()
end

function meta:unequipApparel(uniqueid, classid)
	local apparel = findApparel(classid)

	self.equipped.apparel[apparel:getSlot()] = nil
	self.inventory.apparel[uniqueid]["equipped"] = false

	DB:RunQuery("UPDATE apparel SET equipped = 0 WHERE uniqueid = " ..uniqueid)

	net.Start("unequipApparel")
		net.WriteInt(uniqueid, 32)
	net.Send(self)

	self:updateClientEquipment()
end

function meta:equipApparel(uniqueid, classid)
	local apparel = findApparel(classid)

	if self:canEquipApparel(classid) then
		local apparelSlot = apparel:getSlot()

		// Remove current weapon
		if self:hasCurrentApparel(apparelSlot) then
			local currentId = self:getCurrentApparelId(apparelSlot)
			local currentClass = self:getCurrentApparelClass(apparelSlot)

			self:unequipApparel(currentId, currentClass)
		end

		self.inventory.apparel[uniqueid]["equipped"] = true
		self.equipped.apparel[apparelSlot] = self.inventory.apparel[uniqueid]

		self:updateClientEquipment()

		DB:RunQuery("UPDATE apparel SET equipped = 1 WHERE uniqueid = " ..uniqueid)

		net.Start("equipApparel")
			net.WriteInt(uniqueid, 32)
		net.Send(self)
	else
		self:notify("Must be level " ..apparel:getLevel() .." to equip that", NOTIFY_ERROR)
	end
end
