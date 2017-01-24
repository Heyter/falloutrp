AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:OnTakeDamage(dmg)
	local attacker = dmg:GetAttacker()
	
	if IsValid(attacker) and attacker:IsPlayer() and attacker:GetActiveWeapon():GetClass() == "eoti_tool_miningpick" then
		local random = math.random(1, 5)
		
		if random == 1 then
			createLoot(self:GetPos() + Vector(40, 0, 0), {createItem(5028, 1)})
			self:reduceCount()
		end
	end
end

function ENT:reduceOres()
	self.ore = self.ore - 1
	
	if self.ore == 0 then
		SafeRemoveEntity(self)
		self:SetColor(Color(0, 0, 0, 0))
		
		timer.Simple(60, function()
			self.ore = 5
			self:SetColor(Color(255, 255, 255, 255))
		end)
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