include("shared.lua")

local LabelBackgroundColor 	= ENT.Label_BG
local LabelTextColor 		= ENT.Label_TextColor

function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	txt1 = self.PrintName

	surface.SetFont("FalloutRP1")
	local TextWidthLabel = surface.GetTextSize(txt1);
	Ang:RotateAroundAxis( Ang:Up(), 90 );

	cam.Start3D2D(Pos + Ang:Up() * 25, Ang + Angle(0, 270, 90), 0.09)
		draw.WordBox( 6, -TextWidthLabel * 0.5 - 5, -50, txt1, "FalloutRP1", LabelBackgroundColor, LabelTextColor)
	cam.End3D2D()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
end;

function ENT:Think()

end
