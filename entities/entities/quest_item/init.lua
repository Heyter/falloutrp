AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:OnTakeDamage(dmg)

end

function ENT:SetID(id)
	self.id = id
end

function ENT:GetID()
	return self.id
end

function ENT:Use(activator)
	if activator:IsPlayer() and !self.beingRemoved then
		activator:lootQuestItem(self:GetID(), nil, self)
	end
end
