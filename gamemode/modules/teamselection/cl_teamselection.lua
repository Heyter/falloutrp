
local main
local frameW, frameH = 800, 600
local nameFrameW, nameFrameH = 800, 600
local paddingW, paddingH = 40, 40
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
		Description = "Increased damage with energy weapon.\nMaximum armour increase."
	},
	[TEAM_NCR] = {
		Name = "New California Republic", 
		Emblem = "falloutrp/factions/NewCaliforniaRepublicEmblem.png",
		Reputation = "falloutrp/factions/NewCaliforniaRepublicReputation.png",
		Description = "Increased damage with guns.\nMaximum health increase."
	},	
	[TEAM_LEGION] = {
		Name = "Legion", 
		Emblem = "falloutrp/factions/LegionEmblem.png",
		Reputation = "falloutrp/factions/LegionReputation.png",
		Description = "Increased damage with melee weapons and explosives.\nIncreased critical chance and critical damage."
	}
}

net.Receive("createCharacter", function(len, ply)
	if main then
		main:Remove()
	end
end)

local function validateRegistration(name, teamId, values)
	print("validate name")
	net.Start("registrationValidation")
		net.WriteString(name)
		net.WriteInt(teamId, 8)
		net.WriteTable(values)
	net.SendToServer()
end

net.Receive("registrationValidation", function(len, ply)
	local errorId = net.ReadInt(8)
	local name = net.ReadString()
	local extra = net.ReadString()
	
	print("validated name")
	
	if errorId and errorId > 0 then
		if errorId == 1 then
			print("Name must be atleast " ..NAME_MIN .." characters.")
		elseif errorId == 2 then
			print("Name must not exceed " ..NAME_MAX .." characters.")
		elseif errorId == 3 then
			print("Name must not contain the following: " ..extra)
		elseif errorId == 4 then
			print("You must use all of your available points.") 
		elseif errorId == 5 then
			print("The name " ..name .." is already in use.")
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
		local frame = vgui.Create("FalloutRP_Menu", main)
		frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
		frame:SetSize(frameW, frameH)
		frame:SetFontTitle("FalloutRP3", "Faction Registration")
		
		local nextY = paddingH
		for id, v in pairs(teams) do
			local teamFrame = vgui.Create("DPanel", frame)
			teamFrame:SetPos(paddingW, nextY)
			teamFrame:SetSize(teamW, teamH)
			teamFrame.Paint = function(self, w, h)
				surface.SetDrawColor(COLOR_AMBER)
				surface.DrawOutlinedRect(0, 0, w, h)
				//draw.RoundedBox(2, 0, 0, w, h, COLOR_BROWN)
				
				surface.SetMaterial(Material(v["Emblem"]))
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.DrawTexturedRect(picPaddingW, picPaddingH + 5, picSize, picSize - 10)
							
				surface.SetMaterial(Material(v["Reputation"]))
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.DrawTexturedRect(picPaddingW * 2 + picSize, picPaddingH + 5, picSize, picSize - 10) 
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
		local frame = vgui.Create("FalloutRP_Menu", main)
		frame:SetPos(ScrW()/2 - nameFrameW/2, ScrH()/2 - nameFrameH/2)
		frame:SetSize(nameFrameW, nameFrameH)
		frame:SetFontTitle("FalloutRP3", "Player Registration")
		
		local instructions = vgui.Create("DLabel", frame)
		instructions:SetText("Enter your player's name")
		instructions:SetTextColor(COLOR_AMBER)
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
		
		local offsetY = 0
		local values = {}

		local specialDescription = vgui.Create("DLabel", frame)
		specialDescription:SetFont("FalloutRP1")
		specialDescription:SetText("")			
		specialDescription:SetPos(frame:GetWide()/2 + 50, 150)
		
		for k,v in pairs(SPECIAL) do
			local specialBox = vgui.Create("DPanel", frame)
			specialBox:SetSize(frame:GetWide()/2 - 100, 30)
			specialBox:SetPos(50, 150 + offsetY)
			specialBox.Paint = function(self, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 0))
				surface.DrawRect(0, 0, w, h)
				
				if self.hovered then
					surface.SetDrawColor(Color(255, 182, 66, 30))
					surface.DrawRect(0, 0, w, h)
				
					surface.SetDrawColor(COLOR_AMBER)
					surface.DrawOutlinedRect(0, 0, w, h)
				end
			end
			values[k] = 1
			
			local specialLabel = vgui.Create("DLabel", specialBox)
			specialLabel:SetPos(10, specialBox:GetTall()/2 - specialLabel:GetTall()/2)
			specialLabel:SetFont("FalloutRP2")
			specialLabel:SetText(v.Name)
			specialLabel:SizeToContents()
			specialLabel:SetTextColor(COLOR_AMBER)
			
			specialBox.OnCursorEntered = function(self)
				self.hovered = true
				
				specialLabel:SetTextColor(COLOR_BLUE)
				
				specialDescription:SetText(SPECIAL[k].Description)
				specialDescription:SizeToContents()
			end
			specialBox.OnCursorExited = function(self)
				self.hovered = false
			
				specialLabel:SetTextColor(COLOR_AMBER)
				specialDescription:SetText("")
			end
			
			local value = vgui.Create("DLabel", specialBox)
			value:SetFont("FalloutRP1")
			value:SetText(values[k])
			value:SetPos(200, specialBox:GetTall()/2 - value:GetTall()/2)
			
			local downButton = vgui.Create("DButton", specialBox)
			downButton:SetText("-")
			downButton:SetSize(15, 15)
			downButton:SetPos(150, specialBox:GetTall()/2 - downButton:GetTall()/2)
			downButton.OnCursorEntered = function(self)
				self:GetParent().hovered = true
				
				specialLabel:SetTextColor(COLOR_BLUE)
				
				specialDescription:SetText(SPECIAL[k].Description)
				specialDescription:SizeToContents()
			end
			downButton.OnCursorExited = function(self)
				self:GetParent().hovered = false
			
				specialLabel:SetTextColor(COLOR_AMBER)
				specialDescription:SetText("")
			end
			downButton.DoClick = function()
				if values[k] > 1 then
					values[k] = values[k] - 1
					
					value:SetText(values[k]) // Update the label
				end
				
				value:SetText(values[k])
			end
			
			local upButton = vgui.Create("DButton", specialBox)
			upButton:SetText("+")
			upButton:SetSize(15, 15)
			upButton:SetPos(250, specialBox:GetTall()/2 - upButton:GetTall()/2)
			upButton.OnCursorEntered = function(self)
				self:GetParent().hovered = true
				
				specialLabel:SetTextColor(COLOR_BLUE)
				
				specialDescription:SetText(SPECIAL[k].Description)
				specialDescription:SizeToContents()
			end
			upButton.OnCursorExited = function(self)
				self:GetParent().hovered = false
			
				specialLabel:SetTextColor(COLOR_AMBER)
				specialDescription:SetText("")
			end
			upButton.DoClick = function()
				local total = 0
				for k,v in pairs(values) do
					total = total + v
				end
				
				if total < REGISTRATION_POINTS + #SPECIAL then
					values[k] = values[k] + 1
					
					value:SetText(values[k])
				end
			end
			
			offsetY = offsetY + 40
		end
		
		local continueButton = vgui.Create("FalloutRP_Button", frame)
		continueButton:SetSize(buttonW, buttonH)
		continueButton:SetPos(frame:GetWide()/2 + continueButton:GetWide()/2, frame:GetTall() - 20 - continueButton:GetTall()*2)
		continueButton.DoClick = function(self)
			if canContinue then
				canContinue = false // Don't allow another submit until we hear back from server
				
				local name = nameEntry:GetValue()
				 
				validateRegistration(name, id, values)
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
	
	timer.Simple(25, function()
		main:Remove()
		gui.EnableScreenClicker(false)
	end)
end

net.Receive("teamSelection", function(len, ply)
	teamSelection()
end)