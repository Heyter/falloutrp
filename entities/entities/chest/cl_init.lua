include("shared.lua")

local LabelBackgroundColor 	= ENT.Label_BG
local LabelTextColor 		= ENT.Label_TextColor

function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:Think()

end
