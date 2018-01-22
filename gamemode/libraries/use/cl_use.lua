net.Receive("useUpdate", function()
    local curTime = net.ReadFloat()
    local totalTime = net.ReadFloat()

    LocalPlayer().currentUseTime = curTime
    LocalPlayer().totalUseTime = totalTime
    LocalPlayer().isUsing = true
end)

net.Receive("useEnd", function()
    LocalPlayer().isUsing = false
end)

hook.Add("HUDPaint", "drawUse", function()
    local w, h = ScreenScale(150), ScreenScale(10)

    local hudColor = getHUDColor
    local color = util.getPepboyColor()
    local curTime, totalTime = LocalPlayer().currentUseTime, LocalPlayer().totalUseTime

    if LocalPlayer().isUsing then
        surface.SetDrawColor(COLOR_BACKGROUND_FADE)
        surface.DrawRect(ScrW()/2 - w/2, ScrH()/2 - h/2, w, h + 1)

        surface.SetDrawColor(Color(color.r, color.g, color.b, 150))
        surface.DrawRect(ScrW()/2 - w/2, ScrH()/2 - h/2, (curTime / totalTime) * w, h + 1)

        surface.SetDrawColor(Color(hudColor.x + 40, hudColor.y + 40, hudColor.z + 40, 255))
        surface.DrawOutlinedRect(ScrW()/2 - w/2, ScrH()/2 - h/2, (curTime / totalTime) * w, h + 1)
    end
end)
