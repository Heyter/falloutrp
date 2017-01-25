ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true // This entity will animate itself
 
function ENT:SetAutomaticFrameAdvance(usingAnim)
	self.AutomaticFrameAdvance = usingAnim
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Nickname")
end

 