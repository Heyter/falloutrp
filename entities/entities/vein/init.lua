AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:hit(attacker, hitPos)
	if IsValid(attacker) and attacker:IsPlayer() then
		local roll = util.roll(20 + attacker:getLevel(), 100)

		if roll then
			attacker:ViewPunch(Angle(7, 0, 0))
			self:EmitSound(VEIN_SOUND)
			local loot = self:generateLoot()

			createLoot(hitPos, loot)
			self:reduceOres(#loot)

			attacker:addExp(VEINS[self:getType()]["Experience"])
			attacker:notify("Mined chunk.", NOTIFY_GENERIC)
		end
	end
end

function ENT:OnTakeDamage(dmg)

end

function ENT:generateLoot()
	local loot = {}

	// Add the default item and subtract ore amount
	table.insert(loot, createItem(VEINS[self:getType()]["Default"], 1))

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
		VEINS[self:getType()]["Positions"][self.key]["Active"] = false
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
