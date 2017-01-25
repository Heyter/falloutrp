AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:hit(attacker)
	if IsValid(attacker) and attacker:IsPlayer() then
		local roll = util.roll(15 + attacker:getLevel(), 100)

		if roll then
			self:EmitSound(VEIN_SOUND)
			local loot = self:generateLoot()
			
			createLoot(attacker:GetPos() + Vector(40, 0, 0), loot)
			self:reduceOres(#loot)
		end
	end
end

function ENT:OnTakeDamage(dmg)

end

function ENT:generateLoot()
	local loot = {}
	
	// Add the default item and subtract ore amount
	table.insert(loot, createItem(VEINS[self:getType()]["Default"], 1))
	print(VEINS[self:getType()]["Default"])
	local extras = VEINS[self:getType()]["Extras"]
	
	for ore, chance in pairs(extras) do
		if (self:getOres() - #loot > 0) then
			if util.roll(chance) then
				table.insert(loot, createItem(ore, 1))
			end
		end
	end
	
	return loot
end

function ENT:reduceOres(amount)
	self.ores = self.ores - amount
	
	if self.ores == 0 then
		util.fadeRemove(self)
	end
end

function ENT:setType(type)
	self.type = type
end

function ENT:getType()
	return self.type
end

function ENT:setOres(count)
	self.ores = count
end

function ENT:getOres()
	return self.ores
end