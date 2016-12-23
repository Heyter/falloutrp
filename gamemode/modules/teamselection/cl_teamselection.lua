

local teams = {
	[1] = {
		Name = "Brotherhood of Steel", 
		Emblem = "falloutrp/factions/BrotherhoodOfSteelEmblem.png",
		Reputation = "falloutrp/factions/BrotherhoodOfSteelReputation.png",
		Description = "We are awesome.\nYou need to join."
	},
	[2] = {
		Name = "New California Republic", 
		Emblem = "falloutrp/factions/NewCaliforniaRepublicEmblem.png",
		Reputation = "falloutrp/factions/NewCaliforniaRepublicReputation.png",
		Description = "We are awesome.\nYou need to join."
	},	
	[3] = {
		Name = "Legion", 
		Emblem = "falloutrp/factions/LegionEmblem.png",
		Reputation = "falloutrp/factions/LegionReputation.png",
		Description = "We are awesome.\nYou need to join."
	}
}

local frameW, frameH = 800, 600
local paddingW, paddingH = 20, 20
local teamW, teamH = frameW - (paddingW * 2), (frameH - (paddingH * 4)) / 3
local picSize = 150
local picPaddingW, picPaddingH = 10, (teamH - picSize) / 2
local buttonW, buttonH = 80, 40
local nameSelection

/*
local function translate(panel)
	if panel then
		local panelX, panelY = panel:GetPos()
		
		if panelX < ScrW() then
			panel:SetPos(panelX + ScrW()/50, panelY)
			
			timer.Simple(0.000125, function()
				translate(panel)
			end)
		else
			panel:Remove()
		end
	end
end
*/

local function teamSelection()
	print("Hi")
	//Enable mouse
	gui.EnableScreenClicker(true)

	local main = vgui.Create("DPanel")
	main.startTime = SysTime()
	main:SetPos(0, 0)
	main:SetSize(ScrW(), ScrH())
	main.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(255, 255, 100, 0))
		Derma_DrawBackgroundBlur(self, self.startTime)
	end
	
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
		
		local button = vgui.Create("DButton", teamFrame)
		button:SetSize(buttonW, buttonH)
		button:SetPos(teamW - paddingW - buttonW, teamH/2 - buttonH/2)
		button.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, COLOR_BLACK)
		end
		button.DoClick = function(self)
			print(self)
			surface.PlaySound("garrysmod/ui_click.wav")
			
			nameSelection(id)
			
			frame:Remove()
		end
		button:SetText("Select")
		button:SetFont("FalloutRP1")
		button:SetTextColor(COLOR_AMBER)
		function button:OnCursorEntered()
			button:SetTextColor(COLOR_BLUE)
			surface.PlaySound("garrysmod/ui_return.wav")
		end
		function button:OnCursorExited()
			button:SetTextColor(COLOR_AMBER)
		end
		
		nextY = nextY + teamH + paddingH
	end
	
	nameSelection = function(id)
		print(id)
	end
	
	timer.Simple(5, function()
		main:Remove()
		gui.EnableScreenClicker(false)
	end)
end

net.Receive("teamSelection", function(len, ply)
	teamSelection()
end)