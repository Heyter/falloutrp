
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
	return self.equipped.weapons[type]
end

function meta:canEquipApparel(classid)
	return self:getLevel() >= getApparelLevel(classid)
end

function meta:unequipApparel(uniqueid, classid)
	// Remove from tables
	self.equipped.apparel[getApparelType(classid)] = nil
	self.inventory.apparel[uniqueid]["equipped"] = false
			
	// Remove from MySQL
	MySQLite.query("UPDATE apparel SET equipped = 0 WHERE uniqueid = " ..uniqueid)
	
	// Update clientside
	net.Start("unequipApparel")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
	net.Send(self)
end

function meta:equipApparel(uniqueid, classid)
	print(classid)
	if self:canEquipApparel(classid) then
		print(classid)
		local apparelType = getApparelType(classid)
	
		// Remove current weapon
		if self:hasCurrentApparel(apparelType) then
			local currentId = self:getCurrentApparelId(apparelType)
			local currentClass = self:getCurrentApparelClass(apparelType)
			
			self:unequipApparel(currentId, currentClass)
		end
		
		//Update in lua
		self.inventory.apparel[uniqueid]["equipped"] = true
		self.equipped.apparel[apparelType] = self.inventory.apparel[uniqueid]
			
		//Update client
		net.Start("equipApparel")
			net.WriteInt(uniqueid, 32)
			net.WriteInt(classid, 16)
		net.Send(self)
			
		//Update MySQL
		MySQLite.query("UPDATE apparel SET equipped = 1 WHERE uniqueid = " ..uniqueid)
	else
		// Not enough strength
	end
end