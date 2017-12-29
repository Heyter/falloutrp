
local frame
local nameFrameW, nameFrameH = 800, 600
local buttonW, buttonH = 80, 40
local canContinue = true // Don't allow players to keep trying to submit names while validating on server still

local function close()
	if frame then
		frame:Remove()
		frame = nil

		gui.EnableScreenClicker(false)
	end
end

function openNameChange()
	frame = vgui.Create("FalloutRP_Menu")
	frame:SetPos(ScrW()/2 - nameFrameW/2, ScrH()/2 - nameFrameH/2)
	frame:SetSize(nameFrameW, nameFrameH)
	frame:SetFontTitle("FalloutRP3", "Player Registration")
	frame:AddCloseButton()
	frame:MakePopup()

	local instructions = vgui.Create("DLabel", frame)
	instructions:SetText("Enter your player's name")
	instructions:SetTextColor(COLOR_SLEEK_GREEN)
	instructions:SetFont("FalloutRP3")
	instructions:SizeToContents()
	instructions:SetPos(frame:GetWide()/2 - instructions:GetWide()/2, 40 + instructions:GetTall()/2)

	local nameEntry = vgui.Create("DTextEntry", frame)
	nameEntry:SetSize(instructions:GetWide(), instructions:GetTall())
	nameEntry:SetPos(frame:GetWide()/2 - nameEntry:GetWide()/2, 40 + nameEntry:GetTall()*2)
	nameEntry:SetText("John Doe")
	nameEntry:SetFont("FalloutRP1")
	nameEntry.OnEnter = function(self)

	end

	local continueButton = vgui.Create("FalloutRP_Button", frame)
	continueButton:SetSize(buttonW, buttonH)
	continueButton:SetPos(frame:GetWide()/2 + continueButton:GetWide()/2, frame:GetTall() - 20 - continueButton:GetTall()*2)
	continueButton.DoClick = function(self)
		if !LocalPlayer():hasVguiDelay() then
			LocalPlayer():setVguiDelay() // Don't allow another submit until we hear back from server

			local name = nameEntry:GetValue()

			// Validate the name on the server
			net.Start("validateNameChange")
				net.WriteString(name)
			net.SendToServer()
		end
	end
	continueButton:SetText("Continue")
	continueButton:SetFont("FalloutRP1")
end

net.Receive("updateNameChange", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()

	ply.playerData.name = name

	if LocalPlayer() == ply then
		close()
		LocalPlayer():notify("You have changed your name to " ..LocalPlayer():getName(), NOTIFY_GENERIC)
		LocalPlayer():removeVguiDelay()
	end
end)
