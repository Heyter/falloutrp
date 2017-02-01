
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
	return self:getLevel() >= getApparelLevel(classid)
end

function meta:unequipApparel(uniqueid, classid)
	// Remove from tables
	self.equipped.apparel[getApparelSlot(classid)] = nil
	self.inventory.apparel[uniqueid]["equipped"] = false
			
	// Remove from MySQL
	MySQLite.query("UPDATE apparel SET equipped = 0 WHERE uniqueid = " ..uniqueid)
	
	self:updateClientEquipment()
end

function meta:equipApparel(uniqueid, classid)
	if self:canEquipApparel(classid) then
		local apparelSlot = getApparelSlot(classid)
	
		// Remove current weapon
		if self:hasCurrentApparel(apparelSlot) then
			local currentId = self:getCurrentApparelId(apparelSlot)
			local currentClass = self:getCurrentApparelClass(apparelSlot)
			
			self:unequipApparel(currentId, currentClass)
		end
		
		//Update in lua
		self.inventory.apparel[uniqueid]["equipped"] = true
		self.equipped.apparel[apparelSlot] = self.inventory.apparel[uniqueid]
			
		self:updateClientEquipment()
			
		//Update MySQL
		MySQLite.query("UPDATE apparel SET equipped = 1 WHERE uniqueid = " ..uniqueid)
	else
		// Not enough level
		self:notify("Level not high enough to equip that.", NOTIFY_ERROR)
	end
end