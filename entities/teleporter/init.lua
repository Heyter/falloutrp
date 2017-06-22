AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)
end

function ENT:OnTakeDamage(dmg)

end

function ENT:StartTouch(ent)
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
		print("Teleport me")
	end
end

function ENT:Use(activator)

end

hook.Add("InitPostEntity", "SpawnTeleporter", function()
	local ent = ents.Create("teleporter")
	ent:SetPos(-721, -889, -2261)
	ent:SetAngles(Angle(0, -90, 0))
	ent:Spawn()
end)
