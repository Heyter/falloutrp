AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/de_nuke/coolingtank.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	self.loot = {}
	self.iteration = 1
	
	self:SetController(4)
end

function ENT:OnTakeDamage(dmg)
	return false
end


function ENT:Use(activator)
	if activator:IsPlayer() then
		activator:loot(self)
	end
end

function ENT:OnCooldown()
	return self:GetCooldown() > CurTime()
end

function ENT:GetCooldown()
	return self.cooldown or 0
end

function ENT:SetCooldown()
	self.cooldown = CurTime() + FACTORY.Cooldown
end

function ENT:Use(activator)
	print(1)
	if activator:IsPlayer() then
		print(2)
		activator:loot(self)
	end
end

function ENT:getInfo()
	return FACTORY.Setup[game.GetMap()][self:GetPlace()]
end

function ENT:findExistingItem(classid, ply)
	for k, v in pairs(self.loot[ply]) do
		if v.classid == classid then
			return k // Return the index to add quantity on to
		end
	end
	
	return false
end

function ENT:addItem(item, ply)
	// Initialize the loot table for this player if it isn't already
	if !self.loot[ply] then
		self.loot[ply] = {}
	end
	
	local existingItem
	if item.quantity then
		existingItem = self:findExistingItem(item.classid)
	end
	
	if existingItem then
		self.loot[ply][self.iteration].quantity = self.loot[ply][self.iteration].quantity + item.quantity
	else
		self.loot[ply][self.iteration] = item
	end
	
	// Increate the iteration for the slot of the next item
	self.iteration = self.iteration + 1
end

function ENT:addRandomItem(ply)
	local itemTable = self:getInfo().Items
	local randomItem, index = table.Random(itemTable)
	
	local item = createItem(randomItem)
	
	self:addItem(item, ply)
end

function ENT:hasLoot(ply)
	if self.loot and self.loot[ply] then
		for k,v in pairs(self.loot[ply]) do
			// There is something in the loot table if we reach this block of code
			return true
		end
	end
	
	return false
end

function ENT:hasItem(id, amount, ply)
	if self:hasLoot(ply) and self.loot[ply] and self.loot[ply][id] then
		local quantity = self.loot[ply][id].quantity
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

function ENT:getItem(id, ply)
	return self.loot[ply][id]
end

function ENT:removeQuantity(id, quantity, ply)
	self.loot[ply][id].quantity = self.loot[ply][id].quantity - quantity
end

function ENT:removeItem(id, quantity, ply)
	if quantity and self.loot[ply][id].quantity then
		self:removeQuantity(id, quantity, ply)

		// If the item has 0 quantity then remove it from the loot
		if self.loot[ply][id].quantity <= 0 then
			self.loot[ply][id] = nil
		end
	else
		self.loot[ply][id] = nil
	end
end

function ENT:getLoot(ply)
	return self.loot[ply]
end
