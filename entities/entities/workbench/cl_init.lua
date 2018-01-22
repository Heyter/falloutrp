include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(self:GetPos() + self:GetUp()*110, ang, 0.35)
		draw.SimpleTextOutlined("Workbench", "FalloutRP4", 0, 0, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
	cam.End3D2D()

	self:DrawModel()
end

function ENT:Think()

end
