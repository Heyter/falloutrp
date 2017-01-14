
net.Receive("addSkillPoints", function(len, ply)
	local skillPoints = net.ReadInt(8)
	local ply = net.ReadEntity()

	if plyDataExists(ply) then
		ply.playerData.skillpoints = skillPoints
	end
end)

local frameW, frameH = 800, 600
local buttonW, buttonH = 80, 40
local canContinue = true // Don't allow players to keep trying to submit skills while validating on server still

function skillSelection()
	local beginningTotal = 0
	local beginningValues = {}
	local values = {}
	
	gui.EnableScreenClicker(true)

	frame = vgui.Create("FalloutRP_Menu")
	frame:SetSize(frameW, frameH)
	frame:SetPos(ScrW()/2 - frame:GetWide()/2, ScrH()/2 - frame:GetTall()/2)
	frame:SetFontTitle("FalloutRP3", "WELCOME TO LEVEL")

	local skillsDescription = vgui.Create("DLabel", frame)
	skillsDescription:SetFont("FalloutRP1")
	skillsDescription:SetText("")			
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
				surface.SetDrawColor(Color(255, 182, 66, 30))
				surface.DrawRect(0, 0, w, h)
			
				surface.SetDrawColor(COLOR_AMBER)
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
		skillsLabel:SetTextColor(COLOR_AMBER)
		
		skillsBox.OnCursorEntered = function(self)
			self.hovered = true
			
			skillsLabel:SetTextColor(COLOR_BLUE)
			
			skillsDescription:SetText(SKILLS[k].Description)
			skillsDescription:SizeToContents()
		end
		skillsBox.OnCursorExited = function(self)
			self.hovered = false
			
			skillsLabel:SetTextColor(COLOR_AMBER)
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
			
			skillsLabel:SetTextColor(COLOR_AMBER)
			skillsDescription:SetText("")
		end
		downButton.DoClick = function()
			if values[k] > 1 and (values[k] > beginningValues[k]) then
				values[k] = values[k] - 1
					
				value:SetText(values[k]) // Update the label
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
		
			skillsLabel:SetTextColor(COLOR_AMBER)
			skillsDescription:SetText("")
		end
		upButton.DoClick = function()
			local total = 0
			for k,v in pairs(values) do
				total = total + v
			end
				
			if total < beginningTotal + SKILLPOINTS_LEVEL then
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
			
			net.Start("validateSkills")
				net.WriteTable(values)
			net.SendToServer()
		end
	end
	continueButton:SetText("Submit")
	continueButton:SetFont("FalloutRP1")	
	
	timer.Simple(5, function()
		frame:Close()
	end)
end