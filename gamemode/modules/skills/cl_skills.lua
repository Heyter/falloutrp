
local frame
local frameW, frameH = 800, 600
local buttonW, buttonH = 80, 40
local canContinue = true // Don't allow players to keep trying to submit skills while validating on server still

local function close()
	if frame then
		frame:Remove()
		gui.EnableScreenClicker(false)
	end
end

net.Receive("addSkillPoints", function(len, ply)
	local level = net.ReadInt(8)
	local skillpoints = net.ReadInt(16)
	
	skillSelection(level, skillpoints)
end)

net.Receive("updateSkills", function(len, ply)
	local skills = net.ReadTable()
	
	for skill, points in pairs(skills) do
		LocalPlayer().playerData[skill] = points
	end
	
	close()
	
	// Allow submissions again
	canContinue = true
end)

net.Receive("validateSkills", function(len, ply)
	local errorId = net.ReadInt(8)
	
	if errorId == 1 then
		LocalPlayer():notify("You used more skill points than you have.", NOTIFY_ERROR)
	end
	
	canContinue = true
end)

function skillSelection(level, skillpoints)
	if frame then frame:Remove() frame = nil gui.EnableScreenClicker(false) return end
	
	local beginningTotal = 0
	local beginningValues = {}
	local values = {}
	local pointsRemaining = skillpoints
	
	gui.EnableScreenClicker(true)

	frame = vgui.Create("FalloutRP_Menu")
	frame:SetSize(frameW, frameH)
	frame:SetPos(ScrW()/2 - frame:GetWide()/2, ScrH()/2 - frame:GetTall()/2)
	frame:SetFontTitle("FalloutRP3", "WELCOME TO LEVEL " ..level)
	frame:AddCloseButton()

	local unlockables = vgui.Create("DLabel", frame)
	unlockables:SetFont("FalloutRP2")
	unlockables:SetText(LocalPlayer():getUnlockables(level))
	unlockables:SetTextColor(COLOR_SLEEK_GREEN)
	unlockables:SizeToContents()
	unlockables:SetPos(frame:GetWide()/2 + frame:GetWide()/4 - unlockables:GetWide()/2 - 40, frame:GetTall()/2 - 150)
	
	local points = vgui.Create("DLabel", frame)
	points:SetFont("FalloutRP3")
	points:SetText("ASSIGN " ..pointsRemaining .." SKILL POINTS")
	points:SetTextColor(COLOR_SLEEK_GREEN)
	points:SizeToContents()
	points:SetPos(frame:GetWide()/2 + frame:GetWide()/4 - points:GetWide()/2 - 40, 530)
	points.UpdatePoints = function()
		points:SetText("ASSIGN " ..pointsRemaining .." SKILL POINTS")
	end
	
	local skillsDescription = vgui.Create("DLabel", frame)
	skillsDescription:SetFont("FalloutRP2")
	skillsDescription:SetText("")			
	skillsDescription:SetTextColor(COLOR_SLEEK_GREEN)
	skillsDescription:SetPos(frame:GetWide()/2, 50)
			
	local offsetY = 0
	 
	for k,v in ipairs(SKILLS) do
		local skillsBox = vgui.Create("DPanel", frame)
		skillsBox:SetSize(frame:GetWide()/2 - 100, 30)
		skillsBox:SetPos(50, 50 + offsetY)
		skillsBox.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
				
			if self.hovered then
				surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
				surface.DrawRect(0, 0, w, h)
			 
				surface.SetDrawColor(COLOR_SLEEK_GREEN)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		
		local playerValue = LocalPlayer().playerData[string.lower(string.Replace(v.Name, " ", ""))]
		beginningTotal = beginningTotal + playerValue
		
		values[k] = playerValue
		beginningValues[k] = playerValue // Keep track of the starting values so that they can't decrease their skill level below that
			
		local skillsLabel = vgui.Create("DLabel", skillsBox)
		skillsLabel:SetPos(10, skillsBox:GetTall()/2 - skillsLabel:GetTall()/2)
		skillsLabel:SetFont("FalloutRP2")
		skillsLabel:SetText(v.Name)
		skillsLabel:SizeToContents()
		skillsLabel:SetTextColor(COLOR_SLEEK_GREEN)
		
		skillsBox.OnCursorEntered = function(self)
			self.hovered = true
			
			skillsLabel:SetTextColor(COLOR_BLUE)
			
			skillsDescription:SetText(SKILLS[k].Description)
			skillsDescription:SizeToContents()
		end
		skillsBox.OnCursorExited = function(self)
			self.hovered = false
			
			skillsLabel:SetTextColor(COLOR_SLEEK_GREEN)
			skillsDescription:SetText("")
		end
			
		local value = vgui.Create("DLabel", skillsBox)
		value:SetFont("FalloutRP1")
		value:SetText(values[k])
		value:SetPos(200, skillsBox:GetTall()/2 - value:GetTall()/2)
			
		local downButton = vgui.Create("DButton", skillsBox)
		downButton:SetText("-")
		downButton:SetSize(15, 15)
		downButton:SetPos(150, skillsBox:GetTall()/2 - downButton:GetTall()/2)
		downButton.OnCursorEntered = function(self)
			self:GetParent().hovered = true
			
			skillsLabel:SetTextColor(COLOR_BLUE)
			
			skillsDescription:SetText(SKILLS[k].Description)
			skillsDescription:SizeToContents()
		end
		downButton.OnCursorExited = function(self)
			self:GetParent().hovered = false
			
			skillsLabel:SetTextColor(COLOR_SLEEK_GREEN)
			skillsDescription:SetText("")
		end
		downButton.DoClick = function()
			if values[k] > 1 and (values[k] > beginningValues[k]) then
				values[k] = values[k] - 1
					
				value:SetText(values[k]) // Update the label
				
				pointsRemaining = pointsRemaining + 1 // Update points remaining
				points.UpdatePoints()
			end
				
			value:SetText(values[k])
		end
			
		local upButton = vgui.Create("DButton", skillsBox)
		upButton:SetText("+")
		upButton:SetSize(15, 15)
		upButton:SetPos(250, skillsBox:GetTall()/2 - upButton:GetTall()/2)
		upButton.OnCursorEntered = function(self)
			self:GetParent().hovered = true
			
			skillsLabel:SetTextColor(COLOR_BLUE)
			
			skillsDescription:SetText(SKILLS[k].Description)
			skillsDescription:SizeToContents()
		end
		upButton.OnCursorExited = function(self)
			self:GetParent().hovered = false
		
			skillsLabel:SetTextColor(COLOR_SLEEK_GREEN)
			skillsDescription:SetText("")
		end
		upButton.DoClick = function()
			local total = 0
			for k,v in pairs(values) do
				total = total + v
			end
				
			// Check that thte total amount used is less than or equal to the amount of skillpoints the player has
			if total < beginningTotal + skillpoints then
				values[k] = values[k] + 1
					
				value:SetText(values[k])
				
				pointsRemaining = pointsRemaining - 1 // Update points remaining
				points.UpdatePoints()
			end
		end
			
		offsetY = offsetY + 40
	end	
	
	local continueButton = vgui.Create("FalloutRP_Button", frame)
	continueButton:SetSize(buttonW, buttonH)
	continueButton:SetPos(frame:GetWide()/2 + frame:GetWide()/4 - continueButton:GetWide(), frame:GetTall() - 100 - continueButton:GetTall()*2 + 30)
	continueButton.DoClick = function(self)
		if canContinue then
			canContinue = false // Don't allow another submit until we hear back from server
			
			net.Start("validateSkills")
				net.WriteTable(values)
			net.SendToServer()
		end
	end
	continueButton.Paint = function(self, w, h)
		surface.SetDrawColor(COLOR_HIDDEN)
		surface.DrawRect(0, 0, w, h)
		
		surface.SetDrawColor(COLOR_SLEEK_GREEN)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	continueButton:SetText("Submit")
	continueButton:SetFont("FalloutRP1")	
end