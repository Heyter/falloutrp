AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/humans/group01/female_04.mdl")
	self:SetHullType(HULL_HUMAN)

	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE, CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)

	self:SetMaxYawSpeed(90)
end

function ENT:AcceptInput(type, activator)
	if type == "Use" and IsValid(activator) and activator:IsPlayer() and activator.loaded then
		print("TEST")
		// Menu
		net.Start("openQuestMenu")
			net.WriteString(self:GetNickname())
		net.Send(activator)
	end
end
