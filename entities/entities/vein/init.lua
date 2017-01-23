AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(VEIN_MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	self.ore = 5
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

function ENT:reduceCount()
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

function ENT:getCount()
	return self.ore
end