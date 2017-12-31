include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()

	local pos = self:GetPos()
	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), -90)

	cam.Start3D2D(pos + self:GetUp()*130, ang, 0.6)
		draw.SimpleTextOutlined(".", "FalloutRP7", 0, 0, COLOR_FOREGROUND, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
	cam.End3D2D()

	ang:RotateAroundAxis(ang:Forward(), 180)

	cam.Start3D2D(pos + self:GetUp()*80, ang, 0.6)
		draw.SimpleTextOutlined(".", "FalloutRP7", 0, 0, COLOR_FOREGROUND, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
	cam.End3D2D()
end
