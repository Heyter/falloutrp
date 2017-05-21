
local meta = FindMetaTable("Player")

net.Receive("updateParty", function()
    local hasParty = net.ReadBool()
    local party

    if hasParty then
        party = net.ReadTable()
        LocalPlayer().party = party
    else
        LocalPlayer().party = nil
    end
end)

local hbar = surface.GetTextureID("hud/fo/enemy_health")
local star = Material("icon16/star.png")
local user = Material("icon16/user.png")

hook.Add("HUDPaint", "partyPlayers", function()
    if LocalPlayer().party and !LocalPlayer().partyHidePlayers then
        local PEPBOY_COLOR = PEPBOY_COLOR or Color(255, 0, 0, 255)

        // Draw Leader
        local name = LocalPlayer().party.leader:getName()
        local health = math.floor(LocalPlayer().party.leader:Health()/LocalPlayer().party.leader:getMaxHealth() * 100) .."%"

        surface.SetTexture(hbar)
        surface.SetDrawColor(Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 255))
        surface.DrawTexturedRectRotated(225, 50, 390, 75, 0)

        surface.SetMaterial(star)
        surface.SetDrawColor(COLOR_WHITE)
        surface.DrawTexturedRect(45, 15, 16, 16)

        // Name
        for i = 1, 2 do
            draw.SimpleText(name, "FalloutRPHUD1Blur", 85, 15, Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 200), false, 0)
        end
        draw.SimpleText(name, "FalloutRPHUD1", 85, 15, Color(getHUDColor.x + 40, getHUDColor.y + 40, getHUDColor.z + 40, 255), false, 0)

        // Health
        for i = 1, 2 do
            draw.SimpleText(health, "FalloutRPHUD1Blur", 220, 15, Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 200), false, 0)
        end
        draw.SimpleText(health, "FalloutRPHUD1", 220, 15, Color(getHUDColor.x + 40, getHUDColor.y + 40, getHUDColor.z + 40, 255), false, 0)

        local offset = 50

        // Draw members
        for k,v in pairs(LocalPlayer().party.members) do
            local name = v:getName()
            local health = math.floor(v:Health()/v:getMaxHealth() * 100) .."%"

            surface.SetTexture(hbar)
            surface.SetDrawColor(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 255)
            surface.DrawTexturedRectRotated(225, 50 + offset, 390, 75, 0)

            surface.SetMaterial(user)
            surface.SetDrawColor(COLOR_WHITE)
            surface.DrawTexturedRect(45, 15 + offset, 16, 16)

            // Name
            for i = 1, 2 do
                draw.SimpleText(name, "FalloutRPHUD1Blur", 85, offset + 15, Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 200), false, 0)
            end
            draw.SimpleText(name, "FalloutRPHUD1", 85, offset + 15, Color(getHUDColor.x + 40, getHUDColor.y + 40, getHUDColor.z + 40, 255), false, 0)

            // Health
            for i = 1, 2 do
                draw.SimpleText(health, "FalloutRPHUD1Blur", 220, offset + 15, Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 200), false, 0)
            end
            draw.SimpleText(health, "FalloutRPHUD1", 220, offset + 15, Color(getHUDColor.x + 40, getHUDColor.y + 40, getHUDColor.z + 40, 255), false, 0)

            offset = offset + 50
        end
    end
end)
