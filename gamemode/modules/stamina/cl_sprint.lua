
local disableLevel = DISABLE_RUN
local staminaDrawColor = Color(255, 0, 0, 255)

local w, h = 200, 25

function staminaDraw()
	if plyDataExists(LocalPlayer()) then
		local color = util.getPepboyColor()
		local stamina = LocalPlayer():GetNWInt("tcb_Stamina")
		local maxStamina = LocalPlayer():getMaxSprintLength()

		if stamina < maxStamina then
			surface.SetDrawColor(COLOR_BLACKFADE)
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - 25, w, h)

			surface.SetDrawColor(color)
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - 25, (stamina / maxStamina) * w, h)

			//surface.SetDrawColor(COLOR_AMBER)
			//surface.DrawOutlinedRect(ScrW()/2 - w/2, ScrH() - 100, w, h)
		end
	end
end
hook.Add("HUDPaint", "staminaDraw", staminaDraw)
