
local frameW, frameH = 800, 600
local screenW, screenH = 389, 376

function pipboy()
	local main = vgui.Create("DFrame")
	main.startTime = SysTime()
	main:SetPos(0, 0)
	main:SetSize(ScrW(), ScrH())
	main.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 100, 0))
		Derma_DrawBackgroundBlur(self, self.startTime)
	end
	main:ShowCloseButton(true)
	main:SetTitle("")
	main:MakePopup()
	
	local frame = vgui.Create("DPanel", main)
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame.Paint = function(self, w, h)
		surface.SetMaterial(Material("falloutrp/PipBoy3000.png"))
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(0, 0, w, h)
		
		surface.SetDrawColor(Color(60, 125, 80, 255))
		surface.DrawRect(233, 44, screenW, screenH)
	end
	
	timer.Simple(10, function()
		main:Remove()
	end)
end