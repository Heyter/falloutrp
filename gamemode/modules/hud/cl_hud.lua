
// Client

local colors = {}
colors.black = Color(0, 0, 0, 255)
colors.blue = Color(0, 0, 255, 255)
colors.brightred = Color(200, 30, 30, 255)
colors.darkred = Color(0, 0, 70, 100)
colors.darkblack = Color(0, 0, 0, 200)
colors.gray1 = Color(0, 0, 0, 155)
colors.gray2 = Color(51, 58, 51,100)
colors.red = Color(255, 0, 0, 255)
colors.white = Color(255, 255, 255, 255)
colors.white1 = Color(255, 255, 255, 200)

local function drawPlayerInfo()
    local shootPos = LocalPlayer():GetShootPos()
    local aimVec = LocalPlayer():GetAimVector()

	for k, ply in pairs(player.GetAll()) do
		if ply == LocalPlayer() or !ply:Alive() or !plyDataExists(ply) then continue end
		
        local hitPos = ply:GetShootPos()

        if hitPos:DistToSqr(shootPos) < 160000 then
			local pos = hitPos - shootPos
			local unitPos = pos:GetNormalized()
            if unitPos:Dot(aimVec) > 0.95 then
                local trace = util.QuickTrace(shootPos, pos, LocalPlayer())
                if trace.Hit and trace.Entity ~= ply then break end

				local pos = ply:EyePos()
				pos.z = pos.z + 10  // The position we want is a bit above the position of the eyes
				pos = pos:ToScreen()
			
				draw.DrawText(ply:getName(), "FalloutRP4", pos.x + 1, pos.y - 49, colors.black, 1)
				draw.DrawText(ply:getName(), "FalloutRP4", pos.x, pos.y - 50, Color(255, 255, 100, 255), 1)				
				
				draw.DrawText("Level: " ..ply:getLevel(), "FalloutRP3", pos.x + 1, pos.y - 19, colors.black, 1)
				draw.DrawText("Level: " ..ply:getLevel(), "FalloutRP3", pos.x, pos.y - 20, Color(255, 255, 100, 255), 1)
			end
		end
	end
end
hook.Add("HUDPaint", "drawPlayerInfo", drawPlayerInfo)