
local frameW, frameH = 800, 600
local paddingW, paddingH = 40, 40
local teamW, teamH = frameW - (paddingW * 2), (frameH - (paddingH * 4)) / 3
local picSize = 150
local picPaddingW, picPaddingH = 10, (teamH - picSize) / 2
local buttonW, buttonH = 80, 40

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
		Description = "Increased damage with melee weapons\nand explosives.\nIncreased critical\nchance and critical damage."
	}
}

function openFactionChange()
	local frame = vgui.Create("FalloutRP_Menu")
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "Faction Registration")
	frame:AddCloseButton()
	frame:MakePopup()

	local nextY = paddingH
	for id, v in pairs(teams) do
		if LocalPlayer():Team() != id then
			local teamFrame = vgui.Create("DPanel", frame)
			teamFrame:SetPos(paddingW, nextY)
			teamFrame:SetSize(teamW, teamH)
			teamFrame.Paint = function(self, w, h)
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

				// Change team
				net.Start("factionChange")
					net.WriteInt(id, 8)
				net.SendToServer()

				frame:Remove()
			end
			button:SetText("Select")
			button:SetFont("FalloutRP1")

			nextY = nextY + teamH + paddingH
		end
	end
end
