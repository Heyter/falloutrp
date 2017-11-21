local textPadding = 10

net.Receive("loadVehicles", function()
    local vehicles = net.ReadTable()

    LocalPlayer().vehicles = vehicles
end)

local function close(frame)
	if frame then
		frame:Remove()
		gui.EnableScreenClicker(false)
	end
end

function VEHICLES:spawnVehicle(name)
    net.Start("spawnVehicle")
        net.WriteString(name)
    net.SendToServer()
end

function VEHICLES:openMenu()
    if LocalPlayer().vehicles then
        local frame = vgui.Create("FalloutRP_Scroll_List")
        frame:SetPos(ScrW()/2 - frame:GetWide()/2, ScrH()/2 - frame:GetTall()/2)
        frame:SetFontTitle("FalloutRP3", "Garage")
    	frame:CreateScroll()
    	frame:AddCloseButton()
    	frame:MakePopup()

        local layout = frame.layout
        local scrollerW = frame.scroller:GetWide()

        for k,v in pairs(LocalPlayer().vehicles) do
            if v.owned then
                local itemBox = vgui.Create("DButton")
                itemBox:SetSize(layout:GetWide() - scrollerW, 30)
                itemBox.Paint = function(self, w, h)
                    surface.SetDrawColor(Color(0, 0, 0, 0))
                    surface.DrawRect(0, 0, w, h)

                    if self.hovered then
                        surface.SetDrawColor(Color(255, 182, 66, 30))
                        surface.DrawRect(0, 0, w, h)

                        surface.SetDrawColor(COLOR_AMBER)
                        surface.DrawOutlinedRect(0, 0, w, h)
                    end
                end
                itemBox.DoClick = function()
                    surface.PlaySound("pepboy/click1.wav")

                    VEHICLES:spawnVehicle(k)

                    close(frame)
                end
                itemBox:SetText("")

                local itemLabel = vgui.Create("DLabel", itemBox)
                itemLabel:SetPos(textPadding, textPadding/2)
                itemLabel:SetFont("FalloutRP2")
                itemLabel:SetText("Spawn " ..k)
                itemLabel:SizeToContents()
                itemLabel:SetTextColor(COLOR_AMBER)
                itemBox.OnCursorEntered = function(self)
                    self.hovered = true
                    surface.PlaySound("pepboy/click2.wav")

                    itemLabel:SetTextColor(COLOR_BLUE)
                end
                itemBox.OnCursorExited = function(self)
                    self.hovered = false

                    itemLabel:SetTextColor(COLOR_AMBER)
                end

                layout:Add(itemBox)
            end
        end
    end
end
