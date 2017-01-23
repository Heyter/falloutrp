AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(CHEST_MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self.iteration = 1
	self.loot = {}
end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(activator)
	if activator:IsPlayer() then
		if self:isLocked() then
			// Chest is locked
			self:notify("This chest is locked.", NOTIFY_ERROR)
		else
			// Chest is not locked
			activator:loot(self)
		end
	end
end

function ENT:getLevel()
	return self:GetLevel() or 1
end

function ENT:lock(level)
	self:SetLocked(true)
	self:SetLevel(level)
end

function ENT:unlock()
	self:SetLocked(false)
end

function ENT:isLocked()
	return self:GetLocked() or false
end

function ENT:remove()
	CHEST_LOCATIONS[self.key]["Active"] = false
	SafeRemoveEntity(self)
end

function ENT:addItem(item)
	self.loot[self.iteration] = item
	
	// Increate the iteration for the slot of the next item
	self.iteration = self.iteration + 1
end

function ENT:hasLoot()
	if self.loot then
		for k,v in pairs(self.loot) do
			// There is something in the loot table if we reach this block of code
			return true
		end
	end
	
	return false
end

function ENT:hasItem(id, amount)
	if self:hasLoot() and self.loot[id] then
		local quantity = self.loot[id].quantity
		if util.positive(amount) then
			if util.positive(quantity) and (quantity >= amount) then
				return true
			else
				return false
			end
		end
		
		return true
	end
	
	return false
end

function ENT:getItem(id)
	return self.loot[id]
end

function ENT:removeQuantity(id, quantity)
	self.loot[id].quantity = self.loot[id].quantity - quantity
end

function ENT:removeItem(id, quantity)
	if quantity and self.loot[id].quantity then
		self:removeQuantity(id, quantity)

		// If the item has 0 quantity then remove it from the loot
		if self.loot[id].quantity <= 0 then
			self.loot[id] = nil
		
			if !self:hasLoot() then	
				self:remove()
			end
		end
	else
		self.loot[id] = nil
		
		if !self:hasLoot() then
			self:remove()
		end
	end
end

function ENT:getLoot()
	return self.loot
end