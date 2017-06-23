
local disableLevel = DISABLE_RUN
local staminaDrawColor = Color(255, 0, 0, 255)

function staminaDraw()
	if plyDataExists(LocalPlayer()) then
		local w, h = ScrW(), ScreenScale(10)

		local hudColor = getHUDColor
		local color = util.getPepboyColor()
		local stamina = LocalPlayer():GetNWInt("tcb_Stamina")
		local maxStamina = LocalPlayer():getMaxSprintLength()

		if stamina < maxStamina then
			surface.SetDrawColor(COLOR_BLACKFADE)
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - h, w, h + 1)

			surface.SetDrawColor(Color(color.r, color.g, color.b, 150))
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - h, (stamina / maxStamina) * w, h + 1)

			surface.SetDrawColor(Color(hudColor.x + 40, hudColor.y + 40, hudColor.z + 40, 255))
			surface.DrawOutlinedRect(ScrW()/2 - w/2, ScrH() - h, (stamina / maxStamina) * w, h + 1)
		end
	end
end
hook.Add("HUDPaint", "staminaDraw", staminaDraw)
