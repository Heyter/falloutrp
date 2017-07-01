
ENT.Label_BG = Color(52, 73, 94, 120)
ENT.Label_TextColor = Color(255, 255, 255, 255)
ENT.PrintName = "Chest"

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "Gaming_Unlimited"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Locked")
	self:NetworkVar("Int", 0, "Level")
end
