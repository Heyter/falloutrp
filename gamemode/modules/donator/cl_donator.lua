
local frame
local frameW, frameH = 500, 300

local function close()
	
end

net.Receive("openTokenShop", function()
	gui.EnableScreenClicker(true)

	frame = vgui.Create("FalloutRP_Menu")
	frame:SetSize(frameW, frameH)
	local frameX, frameY = frame:GetPos()
	frame:SetPos(frameX, ScrH() - frame:GetTall() - 100)
	frame:SetFontTitle("FalloutRP3", "Token Shop")
	frame:AddCloseButton()
	frame:HideSideBars()
	
	local intro = vgui.Create("DLabel", frame)
	intro:SetFont("FalloutRP2")
	intro:SetText(" Hi, welcome to the token shop!\n What would you like to do?")
	intro:SetTextColor(COLOR_WHITE)
	intro:SetPos(25, 50)
	intro:SizeToContents()
	
	local choice1 = vgui.Create("FalloutRP_Button", frame)
	choice1:SetText("Switch to another faction")
	choice1:SetFont("FalloutRP2")
	choice1:SetSize(frameW - 50, 40)
	choice1:SetPos(25, 110)	
	choice1.DoClick = function()
	
	end
	
	local choice2 = vgui.Create("FalloutRP_Button", frame)
	choice2:SetText("Change your name")
	choice2:SetFont("FalloutRP2")
	choice2:SetSize(frameW - 50, 40)
	choice2:SetPos(25, 160)	
	choice2.DoClick = function()
	
	end
	
	local choice3 = vgui.Create("FalloutRP_Button", frame)
	choice3:SetText("Create a custom title")
	choice3:SetFont("FalloutRP2")
	choice3:SetSize(frameW - 50, 40)
	choice3:SetPos(25, 210)
	choice3.DoClick = function()
	
	end	
end)