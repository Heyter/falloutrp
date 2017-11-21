
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
	if frame then close() end // Don't open multiple instances of the same menu

	local tokens = LocalPlayer():getTokens()

	frame = vgui.Create("FalloutRP_Multiple_Choice")
	local frameX, frameY = frame:GetPos()
	frame:SetPos(frameX, ScrH() - frame:GetTall() - 100)
	frame:SetFontTitle("FalloutRP3", "Token Shop")
	frame:AddCloseButton()
	frame:HideSideBars()
	frame:MakePopup()

	frame:AddIntro("Hi, welcome to the token shop! What would you like to do?")
	frame:AddButton("Switch to another faction", function()
		if tokens >= getFactionTokens() then
			// Open the faction change menu
			openFactionChange()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end)
	frame:AddButton("Change your name", function()
		if tokens >= getNameTokens() then
			// Open the name change menu
			openNameChange()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end)
	frame:AddButton("Create a custom title", function()
		if tokens >= getTitleTokens() then
			// Open the title creation menu
			openTitleCreation()

			surface.PlaySound("garrysmod/ui_click.wav")
			close()
		else
			LocalPlayer():notify("You do not have enough tokens available.", NOTIFY_ERROR)
		end
	end)
end)
