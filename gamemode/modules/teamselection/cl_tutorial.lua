
local frameW, frameH = 800, 600
local nameFrameW, nameFrameH = 800, 600

function tutorialSlideShow()
	local frame = vgui.Create("FalloutRP_Menu", main)
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "TUTORIAL")
	frame:AddCloseButton()
	
	
end