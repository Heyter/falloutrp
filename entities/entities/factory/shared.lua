ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Takeover"
ENT.Author = "Gaming_Unlimited"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Place")
	
	self:NetworkVar("Int", 0, "Status")
	self:NetworkVar("Int", 1, "Time")
	self:NetworkVar("Int", 3, "Controller")
end