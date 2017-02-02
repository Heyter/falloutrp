
// Client

local frameW, frameH = 800, 600
local buttonW, buttonH = 120, 80
local description = " All players level " ..PVP_PROTECTION_LEVEL .." and lower have the option to enable PvP protection.\n\n This feature protects you from taking damage from players\n of the opposing factions.\n\n The purpose is to allow lower level players a chance to get items\n and materials without extra hassle.\n\n You will be asked about turning this on everytime you spawn.\n\n Would you like to enable it?"

net.Receive("pvpProtection", function()
	pvpProtectionMenu()
end)

function pvpProtectionMenu()
	gui.EnableScreenClicker(true)

	local frame = vgui.Create("FalloutRP_Menu", main)
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "PVP PROTECTION")
	frame:AddCloseButton()
	
	local intro = vgui.Create("DLabel", frame)
	intro:SetFont("FalloutRP2")
	intro:SetTextColor(COLOR_WHITE)
	intro:SetText(description)
	intro:SetPos(50, 100)
	intro:SizeToContents()
	
	local yes = vgui.Create("FalloutRP_Button", frame)
	yes:SetSize(buttonW, buttonH)
	yes:SetFont("FalloutRP2")
	yes:SetText("Yes please")
	yes:SizeToContents()
	yes:SetPos(frameW/2 - yes:GetWide()*1.5, 500)
	yes.DoClick = function()
		surface.PlaySound("garrysmod/ui_click.wav")
		
		// Toggle pvp protection
		net.Start("togglePvp")
		net.SendToServer()
				
		frame:Remove()
		gui.EnableScreenClicker(false)
	end
	
	local no = vgui.Create("FalloutRP_Button", frame)
	no:SetSize(buttonW, buttonH)
	no:SetFont("FalloutRP2")
	no:SetText("I'm no pussy")
	no:SizeToContents()
	no:SetPos(frameW/2 + no:GetWide(), 500)
	no.DoClick = function()
		surface.PlaySound("garrysmod/ui_click.wav")
				
		frame:Remove()
		gui.EnableScreenClicker(false)
	end
end