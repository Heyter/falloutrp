AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate1x1.mdl")
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)
end

function ENT:OnTakeDamage(dmg)

end

local spawnPositions = {
	Vector(-9679, 3651, 127),
	Vector(-9558, 2285, 127),
	Vector(-9907, 1568, 160),
	Vector(-10486, 1381, 127),
	Vector(-10426, 2241, 127),
}

function ENT:TeleportPlayer(ent)
	ent:SetPos(table.Random(spawnPositions) + Vector(0, 0, 120))

	ent:EmitSound("beams/beamstart5.wav")
end

function ENT:StartTouch(ent)
	if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
		self:TeleportPlayer(ent)
	end
end

function ENT:Use(activator)

end

hook.Add("InitPostEntity", "SpawnTeleporter", function()
	timer.Simple(1, function()
		local ent = ents.Create("teleporter")
		ent:SetPos(Vector(-721, -889, -2261))
		ent:SetAngles(Angle(0, -90, 0))
		ent:Spawn()
	end)
end)
