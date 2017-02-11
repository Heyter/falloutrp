ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.Spawnable = true
ENT.AutomaticFrameAdvance = true // This entity will animate itself
 
function ENT:SetAutomaticFrameAdvance(usingAnim)
	self.AutomaticFrameAdvance = usingAnim
end
