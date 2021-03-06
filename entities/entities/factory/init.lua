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

		hook.Call("FactoryOpened", GAMEMODE, activator, self:GetPlace())
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

function ENT:getOwners()
	local owners = {}

	for k,v in pairs(player.GetAll()) do
		if self:GetController() == v:Team() then
			table.insert(owners, v)
		end
	end

	return owners
end

function ENT:getInfo()
	return FACTORY.Setup[game.GetMap()][self:GetPlace()]
end

function ENT:findExistingItem(classid, ply)
	// There is currently no loot at the factory for the player, so by default there would be no existing item
	if !(self.loot and self.loot[ply]) then
		return false
	end

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

	// Increase the iteration for the slot of the next item
	self.iteration = self.iteration + 1
end

local function getRandomItem(items, rarity)
	// Workaround for categories that only have white rarity
	if rarity > RARITY_ORANGE then
		rarity = RARITY_WHITE
	end

	if items[rarity] and #items[rarity] <= 0 then
		return getRandomItem(items, rarity + 1)
	else
		return items[rarity][math.random(1, #items[rarity])]
	end
end

function ENT:addRandomItem(ply)
	local level = util.normalizeLevel(ply:getLevel())
	local type = self:getInfo().Type
	local rarities = getRarityFactories()
	local item

	local roll = math.random(1, 1000)

	for i = RARITY_ORANGE, RARITY_GREEN, -1 do
		if roll <= rarities[i] then
			self:addItem(createItem(getRandomItem(LOOT_STRUCTURE_FACTORY[level][type], i)), ply)
			ply:notify("An item has been added for you at the " ..self:GetPlace() ..", use the factory to loot it!", NOTIFY_HINT, 10)

			return
		end
	end
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
