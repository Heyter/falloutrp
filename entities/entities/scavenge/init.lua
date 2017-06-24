AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.nextUse = 0
end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(activator)
	if IsValid(activator) and activator:IsPlayer() and (self.count > 0) then
		self:EmitSound(SCAVENGE_SOUND)
		local loot = self:generateLoot()
		local hitPos = activator:GetEyeTrace().HitPos

		createLoot(hitPos, loot)
		self:reduceCount(#loot)

		activator:addExp(5)

		activator:notify("Scavenged object.", NOTIFY_GENERIC)
	end
end


function ENT:generateLoot()
	local loot = {}

	// Add the default item and subtract item amount
	table.insert(loot, createItem(SCAVENGE[self:getType()]["Default"], 1))

	local extras = SCAVENGE[self:getType()]["Extras"]

	for item, chance in pairs(extras) do
		if (self:getCount() - #loot > 0) then
			if util.roll(chance) then
				table.insert(loot, createItem(item, 1))
			end
		end
	end

	return loot
end



function ENT:reduceCount(amount)
	self.count = self.count - amount

	if self.count == 0 then
		SCAVENGE[self:getType()]["Positions"][self.key]["Active"] = false
		util.fadeRemove(self)
	end
end


function ENT:setType(type)
	self.type = type
end

function ENT:getType()
	return self.type
end

function ENT:setCount(count)
	self.count = count
end

function ENT:getCount()
	return self.count
end
