AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(WORKBENCH_MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:OnTakeDamage(dmg)

end

function ENT:Use(activator)
	if IsValid(activator) and activator:IsPlayer() and activator:Alive() then
		activator:openCrafting()
	end
end