
local frame
local frameW, frameH = 500, 300

local function close()
	if frame then
		frame:Remove()
		frame = nil

		gui.EnableScreenClicker(false)
	end
end

net.Receive("openTokenShop", function()
	if frame then print("test1") close() end // Don't open multiple instances of the same menu

	local tokens = LocalPlayer():getTokens()

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
		if tokens >= getFactionTokens() then
			// Open the faction change menu
			openFactionChange()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end

	local choice2 = vgui.Create("FalloutRP_Button", frame)
	choice2:SetText("Change your name")
	choice2:SetFont("FalloutRP2")
	choice2:SetSize(frameW - 50, 40)
	choice2:SetPos(25, 160)
	choice2.DoClick = function()
		if tokens >= getNameTokens() then
			// Open the name change menu
			openNameChange()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end

	local choice3 = vgui.Create("FalloutRP_Button", frame)
	choice3:SetText("Create a custom title")
	choice3:SetFont("FalloutRP2")
	choice3:SetSize(frameW - 50, 40)
	choice3:SetPos(25, 210)
	choice3.DoClick = function()
		if tokens >= getTitleTokens() then
			// Open the title creation menu
			openTitleCreation()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end
end)
