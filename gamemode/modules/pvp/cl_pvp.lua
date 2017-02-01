
// Client

net.Receive("pvpProtection", function()
	pvpProtectionMenu()
end)

function pvpProtectionMenu()
	local frame = vgui.Create("FalloutRP_Menu", main)
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "PVP PROTECTION")
	frame:AddCloseButton()
end