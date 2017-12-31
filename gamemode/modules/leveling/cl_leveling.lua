net.Receive("addExperience", function(len, ply)
	local exp = net.ReadInt(32)
	local ply = net.ReadEntity()

	if plyDataExists(ply) then
		ply.playerData["experience"] = exp
	end
end)

local function experienceDraw()
	if plyDataExists(LocalPlayer()) then
		local screenW, screenH, h = ScrW(), ScrH(), ScreenScale(12)
		local color = util.getPepboyColor()

		local curExp = LocalPlayer():getCurrentLevelExp()
		local nextExp = LocalPlayer():getNextLevelExp()

		surface.SetDrawColor(COLOR_BACKGROUND_FADE)
		surface.DrawRect(0, screenH - h, screenW, h + 1)

		surface.SetDrawColor(COLOR_GREEN)
		surface.DrawRect(0, screenH - h, (curExp / nextExp) * screenW, h + 1)

		surface.SetDrawColor(COLOR_BLACK)
		surface.DrawOutlinedRect(0, screenH - h, (curExp / nextExp) * screenW, h + 1)

		local text = "Level " ..LocalPlayer():getLevel()
		surface.SetTextColor(COLOR_WHITE)
		surface.SetFont("FalloutRP1")
		local x, y = surface.GetTextSize(text)
		surface.SetTextPos(screenW/2 - x/2, screenH - h/2 - y/2)
		surface.DrawText(text)
	end
end
hook.Add("HUDPaint", "experienceDraw", experienceDraw)
