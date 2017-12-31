local function staminaDraw()
	if plyDataExists(LocalPlayer()) then
		local expHeight = ScreenScale(12) + 1
		local screenW, screenH, h = ScrW(), ScrH(), ScreenScale(5)

		local color = util.getPepboyColor()
		local stamina = LocalPlayer():GetNWInt("tcb_Stamina")
		local maxStamina = LocalPlayer():getMaxSprintLength()

		if stamina < maxStamina then
			surface.SetDrawColor(COLOR_BACKGROUND_FADE)
			surface.DrawRect(0, screenH - h - expHeight, screenW, h + 1)

			surface.SetDrawColor(Color(color.r, color.g, color.b, 150))
			surface.DrawRect(0, screenH - h - expHeight, (stamina / maxStamina) * screenW, h + 1)

			surface.SetDrawColor(COLOR_BLACK)
			surface.DrawOutlinedRect(0, screenH - h - expHeight, (stamina / maxStamina) * screenW, h + 1)
		end
	end
end
hook.Add("HUDPaint", "staminaDraw", staminaDraw)
