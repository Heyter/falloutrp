
local disableLevel = DISABLE_RUN
local staminaDrawColor = Color(255, 0, 0, 255)

local w, h = 200, 25

function tcb_StaminaDraw()
	if plyDataExists(LocalPlayer()) then
		local stamina = LocalPlayer():GetNWInt("tcb_Stamina")
		local maxStamina = LocalPlayer():getMaxSprintLength()
		
		if stamina < maxStamina then
			surface.SetDrawColor(COLOR_BLACKFADE)
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - 100, w, h)	
			
			surface.SetDrawColor(COLOR_GREEN)
			surface.DrawRect(ScrW()/2 - w/2, ScrH() - 100, (stamina / maxStamina) * w, h)
			
			surface.SetDrawColor(COLOR_AMBER)
			surface.DrawOutlinedRect(ScrW()/2 - w/2, ScrH() - 100, w, h)
			
			draw.DrawText("Stamina: " ..stamina, "TargetID", ScrW()/2 - w/2 + 55, ScrH() - 100 + 5, COLOR_AMBER)
		end
	end
end
hook.Add("HUDPaint", "tcb_StaminaDraw", tcb_StaminaDraw)
