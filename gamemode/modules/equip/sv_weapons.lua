
util.AddNetworkString("unequipWeapon")

// Server
local meta = FindMetaTable("Player")

function meta:hasCurrentWeapon(type)
	return self:getCurrentWeapon(type) != nil
end

function meta:getCurrentWeaponClass(type)
	return self:getCurrentWeapon(type).classid
end

function meta:getCurrentWeaponId(type)
	return self:getCurrentWeapon(type).uniqueid
end

function meta:getCurrentWeapon(type)
	return self.equipped.weapons[type]
end

function meta:canEquipWeapon(classid)
	return self:getStrength() >= getWeaponStrength(classid)
end

function meta:unequipWeapon(uniqueid, classid)
	// Strip weapon
	self:StripWeapon(getWeaponEntity(classid))
		
	// Remove from tables
	self.equipped.weapons[getWeaponType(classid)] = nil
	self.inventory.weapons[uniqueid]["equipped"] = false
			
	// Remove from MySQL
	MySQLite.query("UPDATE weapons SET equipped = 0 WHERE uniqueid = " ..uniqueid)
	
	// Update clientside
	net.Start("unequipWeapon")
		net.WriteInt(uniqueid, 8)
		net.WriteInt(classid, 8)
	net.Send(self)
end

function meta:equipWeapon(uniqueid, classid)
	print(classid)
	if self:canEquipWeapon(classid) then
		print(classid)
		local weaponType = getWeaponType(classid)
	
		// Remove current weapon
		if self:hasCurrentWeapon(weaponType) then
			local currentId = self:getCurrentWeaponId(weaponType)
			local currentClass = self:getCurrentWeaponClass(weaponType)
			
			self:unequipWeapon(currentId, currentClass)
		end
		
		// Give and select weapon
		local weaponClass = getWeaponEntity(classid)
		self:Give(weaponClass)
		self:SelectWeapon(weaponClass)
		
		//Update in lua
		self.inventory.weapons[uniqueid]["equipped"] = true
		self.equipped.weapons[weaponType] = self.inventory.weapons[uniqueid]
			
		//Update client
		net.Start("equipItem")
			
		net.Send(self)
			
		//Update MySQL
		MySQLite.query("UPDATE weapons SET equipped = 1 WHERE uniqueid = " ..uniqueid)
	else
		// Not enough strength
	end
end