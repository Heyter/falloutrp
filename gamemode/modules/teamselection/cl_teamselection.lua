
local main
local frameW, frameH = 800, 600
local nameFrameW, nameFrameH = 400, 300
local paddingW, paddingH = 20, 20
local teamW, teamH = frameW - (paddingW * 2), (frameH - (paddingH * 4)) / 3
local picSize = 150
local picPaddingW, picPaddingH = 10, (teamH - picSize) / 2
local buttonW, buttonH = 80, 40
local teamSelect
local nameSelect
local canContinue = true // Don't allow players to keep trying to submit names while validating on server still

local teams = {
	[TEAM_BOS] = {
		Name = "Brotherhood of Steel", 
		Emblem = "falloutrp/factions/BrotherhoodOfSteelEmblem.png",
		Reputation = "falloutrp/factions/BrotherhoodOfSteelReputation.png",
		Description = "We are awesome.\nYou need to join."
	},
	[TEAM_NCR] = {
		Name = "New California Republic", 
		Emblem = "falloutrp/factions/NewCaliforniaRepublicEmblem.png",
		Reputation = "falloutrp/factions/NewCaliforniaRepublicReputation.png",
		Description = "We are awesome.\nYou need to join."
	},	
	[TEAM_LEGION] = {
		Name = "Legion", 
		Emblem = "falloutrp/factions/LegionEmblem.png",
		Reputation = "falloutrp/factions/LegionReputation.png",
		Description = "We are awesome.\nYou need to join."
	}
}

net.Receive("createCharacter", function(len, ply)
	if main then
		main:Remove()
	end
end)

local function validateName(name, teamId)
	net.Start("nameValidation")
		net.WriteString(name)
		net.WriteInt(teamId, 8)
	net.SendToServer()
end

net.Receive("nameValidation", function(len, ply)
	local errorId = net.ReadInt(8)
	local name = net.ReadString()
	local extra = net.ReadString()
	
	if errorId and errorId > 0 then
		if errorId == 1 then
			print("Name must be atleast " ..NAME_MIN .." characters.")
		elseif errorId == 2 then
			print("Name must not exceed " ..NAME_MAX .." characters.")
		elseif errorId == 3 then
			print("Name must not contain the following: " ..extra)
		end
	end
	
	canContinue = true // Allow the user to try and submit a name again
end) 

local function teamSelection()
	//Enable mouse
	gui.EnableScreenClicker(true)
	
	main = vgui.Create("DFrame")
	main.startTime = SysTime()
	main:SetPos(0, 0)
	main:SetSize(ScrW(), ScrH())
	main.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 100, 0))
		Derma_DrawBackgroundBlur(self, self.startTime)
	end
	main:ShowCloseButton(false)
	main:SetTitle("")
	main:MakePopup()
	
	teamSelect = function()
		local frame = vgui.Create("DPanel", main)
		frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
		frame:SetSize(frameW, frameH)
		frame.Paint = function(self, w, h)
			draw.RoundedBox(2, 0, 0, w, h, COLOR_BLACKFADE)
		end
		
		local nextY = paddingH
		for id, v in pairs(teams) do
			local teamFrame = vgui.Create("DPanel", frame)
			teamFrame:SetPos(paddingW, nextY)
			teamFrame:SetSize(teamW, teamH)
			teamFrame.Paint = function(self, w, h)
				draw.RoundedBox(2, 0, 0, w, h, COLOR_BROWN)
				
				surface.SetMaterial(Material(v["Emblem"]))
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.DrawTexturedRect(picPaddingW, picPaddingH, picSize, picSize)
							
				surface.SetMaterial(Material(v["Reputation"]))
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.DrawTexturedRect(picPaddingW * 2 + picSize, picPaddingH, picSize, picSize) 
			end
			
			local name = vgui.Create("DLabel", teamFrame)
			name:SetText(v["Name"])
			name:SetTextColor(COLOR_AMBER)
			name:SetFont("FalloutRP3")
			name:SizeToContents()
			name:SetPos(picPaddingW * 3 + picSize * 2, picPaddingH)
			
			local nameX, nameY = name:GetSize()
			
			local description = vgui.Create("DLabel", teamFrame)
			description:SetText(v["Description"])
			description:SetTextColor(COLOR_AMBER)
			description:SetFont("FalloutRP2")
			description:SizeToContents()
			description:SetPos(picPaddingW * 3 + picSize * 2, picPaddingH * 2 + nameY)
			
			local button = vgui.Create("FalloutRP_Button", teamFrame)
			button:SetSize(buttonW, buttonH)
			button:SetPos(teamW - paddingW - buttonW, teamH/2 - buttonH/2)
			button.DoClick = function(self)
				surface.PlaySound("garrysmod/ui_click.wav")
				
				nameSelect(id)
				
				frame:Remove()
			end
			button:SetText("Select")
			button:SetFont("FalloutRP1")
			
			nextY = nextY + teamH + paddingH
		end
	end
	teamSelect()
	
	nameSelect = function(id)
		print(id)
		local frame = vgui.Create("DPanel", main)
		frame:SetPos(ScrW()/2 - nameFrameW/2, ScrH()/2 - nameFrameH/2)
		frame:SetSize(nameFrameW, nameFrameH)
		frame.Paint = function(self, w, h)
			draw.RoundedBox(2, 0, 0, w, h, COLOR_BLACKFADE)
		end
		
		local instructions = vgui.Create("DLabel", frame)
		instructions:SetText("Enter your player's name")
		instructions:SetTextColor(COLOR_AMBER)
		instructions:SetFont("FalloutRP3")
		instructions:SizeToContents()
		instructions:SetPos(frame:GetWide()/2 - instructions:GetWide()/2, 20 + instructions:GetTall()/2)
		
		local nameEntry = vgui.Create("DTextEntry", frame)
		nameEntry:SetSize(instructions:GetWide(), instructions:GetTall())
		nameEntry:SetPos(frame:GetWide()/2 - nameEntry:GetWide()/2, 20 + nameEntry:GetTall()*2)
		nameEntry:SetText("John Doe")
		nameEntry:SetFont("FalloutRP1")
		nameEntry.OnEnter = function(self)
			
		end
		
		local continueButton = vgui.Create("FalloutRP_Button", frame)
		continueButton:SetSize(buttonW, buttonH)
		continueButton:SetPos(frame:GetWide()/2 + continueButton:GetWide()/2, frame:GetTall() - 20 - continueButton:GetTall()*2)
		continueButton.DoClick = function(self)
			if canContinue then
				canContinue = false // Don't allow another submit until we hear back from server
				
				local name = nameEntry:GetValue()
				 
				validateName(name, id)
			end
		end
		continueButton:SetText("Continue")
		continueButton:SetFont("FalloutRP1")
		
		local backButton = vgui.Create("FalloutRP_Button", frame)
		backButton:SetSize(buttonW, buttonH)
		backButton:SetPos(frame:GetWide()/2 - backButton:GetWide()*1.5, frame:GetTall() - 20 - backButton:GetTall()*2)
		backButton.DoClick = function(self)
			surface.PlaySound("garrysmod/ui_click.wav")
			
			frame:Remove() //Remove the current screen
			teamSelect() //Go back to the first screen
		end
		backButton:SetText("Back")
		backButton:SetFont("FalloutRP1")
	end
	
	timer.Simple(10, function()
		main:Remove()
		gui.EnableScreenClicker(false)
	end)
end

net.Receive("teamSelection", function(len, ply)
	teamSelection()
end)