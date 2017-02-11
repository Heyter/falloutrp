include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()
end 

hook.Add("PostDrawOpaqueRenderables", "TutorialHead", function()
	for _, ent in pairs (ents.FindByClass("tutorial")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
				draw.SimpleTextOutlined("Tutorial", "FalloutRP3", 0, 0, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))			
			cam.End3D2D()
		end
	end
end)
