AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );
include( "shared.lua" );


function ENT:Initialize()
	self:SetModel(LOOT_MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	timer.Simple(LOOT_TIMER, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end;

function ENT:OnTakeDamage(dmg)

end

function ENT:Use( activator )
	if activator:IsPlayer() then

	end
end
