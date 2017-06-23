local showInventory, showYou, showThem // Trade window functions
local tradeWindow
local inspect
local inventoryButtons
local frameW, frameH = 900, 700

local coinsAdd = Material("icon16/coins_add.png")
local coinsDelete = Material("icon16/coins_delete.png")

local removeInspect

net.Receive("beginTrade", function()
    local tradeInfo = net.ReadTable()
    LocalPlayer().trade = tradeInfo

    openTrade()
end)

net.Receive("updateTrade", function()
    local tradeInfo = net.ReadTable()
    local updater = net.ReadEntity()

    LocalPlayer().trade = tradeInfo

    updateTrade(updater)
end)

net.Receive("closeTrade", function()
    LocalPlayer().trade = nil

    if tradeWindow then
        removeInspect()

        tradeWindow:Remove()
        tradeWindow = nil
    end
end)

local function getOtherTrader()
    for k,v in pairs(LocalPlayer().trade) do
        if k != LocalPlayer() then
            return k
        end
    end
end

local inventoryTypes = {"WEAPONS", "APPAREL", "AMMO", "AID", "MISC"}

removeInspect = function()
	if inspect then
		inspect:Remove()
		inspect = nil
	end
end

local function getYouStatus()
    // 1 = Player can lock in
    // 2 = Player can accept
    // 3 = Player can't accept, accept shows as disabled
    // 4 = Cancel

    return (!LocalPlayer().trade[LocalPlayer()].lockedIn and !LocalPlayer().trade[LocalPlayer()].accepted and 1)
        or (LocalPlayer().trade[LocalPlayer()].lockedIn and LocalPlayer().trade[getOtherTrader()].lockedIn and 2)
        or (LocalPlayer().trade[LocalPlayer()].lockedIn and LocalPlayer().trade[getOtherTrader()].accepted and 2)
        or (LocalPlayer().trade[LocalPlayer()].lockedIn and !LocalPlayer().trade[getOtherTrader()].lockedIn and 3)
        or (LocalPlayer().trade[LocalPlayer()].accepted and 4)
end

local function getYouStatusText()
    local status = {"Lock In", "Accept", "Accept", "Cancel"}

    return status[getYouStatus()] or "Something went wrong"
end

local function getThemStatus()
    local otherTrader = getOtherTrader()

    return (LocalPlayer().trade[otherTrader].lockedIn and "Locked In")
        or (LocalPlayer().trade[otherTrader].accepted and "Accepted")
        or "Waiting..."
end

local function offerItem(classid, uniqueid, quantity)
    removeInspect()

    local quantity = quantity or 0

    net.Start("offerItem")
        net.WriteInt(classid, 16)
        net.WriteInt(uniqueid, 32)
        net.WriteInt(quantity, 16)
    net.SendToServer()
end

local function unofferItem(uniqueid, quantity)
    removeInspect()

    local quantity = quantity or 0

    net.Start("unofferItem")
        net.WriteInt(uniqueid, 32)
        net.WriteInt(quantity, 16)
    net.SendToServer()
end

local function offerCaps(caps)
    net.Start("offerCaps")
        net.WriteInt(caps, 32)
    net.SendToServer()
end

local function unofferCaps(caps)
    net.Start("unofferCaps")
        net.WriteInt(caps, 32)
    net.SendToServer()
end

function updateTrade(updater)
    if IsValid(updater) and updater:IsPlayer() and updater == LocalPlayer() then
        // If you did the update, then only update inventory, your offer, and statuses
        if tradeWindow.lastOpenInventory then
            showInventory(tradeWindow.lastOpenInventory)
        else
            showInventory(1)
        end

        showYou()
        showThemStatus()
    elseif IsValid(updater) and updater:IsPlayer() and updater == getOtherTrader() then
        showThem()
        showYouStatus()
    else
        showYouStatus()
        showThemStatus()
    end
end

function openTrade()
    inventoryButtons = {}

    tradeWindow = vgui.Create("FalloutRP_Menu")
    tradeWindow:SetSize(frameW, frameH)
    tradeWindow:SetPos(ScrW()/2 - tradeWindow:GetWide()/2, ScrH()/2 - tradeWindow:GetTall()/2)
    tradeWindow:SetFontTitle("FalloutRP3", "Trade")
    tradeWindow:AddCloseButton()
    tradeWindow:MakePopup()
    tradeWindow.onClose = function()
        LocalPlayer().trade = nil

        net.Start("closeTrade")
        net.SendToServer()
    end

    local currentSelectedButton

    local inventory = vgui.Create("DPanel", tradeWindow)
    inventory:SetSize(tradeWindow:GetWide()*.4, tradeWindow:GetTall()*.9)
    inventory:SetPos(tradeWindow:GetWide()*.75 - (inventory:GetWide()/2), tradeWindow:GetTall()*.05)
    inventory.Paint = function(self, w, h)
        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(COLOR_AMBER)
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    local buttonW, buttonH, buttonPadding, offsetX = inventory:GetWide()/6, 50, (inventory:GetWide()/6)/6, 0
    for i = 1, 5 do
        local inventoryType = vgui.Create("DButton", inventory)
        inventoryType:SetSize(buttonW, buttonH)
        inventoryType:SetPos(buttonPadding + offsetX, 10)
        inventoryType:SetFont("FalloutRP2")
        inventoryType:SetText(inventoryTypes[i])
        inventoryType:SetTextColor(COLOR_AMBER)
        inventoryType.Paint = function(self, w, h)
            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            // The button is highlighted
            if self.hovered then
                surface.SetDrawColor(COLOR_AMBER)
                surface.DrawOutlinedRect(0, 0, w, h)
            end

            // The button is selected
            if self.selected and (currentSelectedButton == self) then
                surface.SetDrawColor(COLOR_AMBERFADE)
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(COLOR_AMBER)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end
        inventoryType.OnCursorEntered = function(self)
            self.hovered = true
            surface.PlaySound("pepboy/click2.wav")
        end
        inventoryType.OnCursorExited = function(self)
            self.hovered = false
        end
        inventoryType.DoClick = function(self)
            self.hovered = false
            self.selected = true
            self:SetTextColor(COLOR_BLUE)
            surface.PlaySound("pepboy/click1.wav")

            if currentSelectedButton then
                // Reset the old button to not be selected
                currentSelectedButton.selected = false
                currentSelectedButton:SetTextColor(COLOR_AMBER)
            end

            currentSelectedButton = self

            showInventory(i)
        end

        offsetX = offsetX + buttonW + buttonPadding

        table.insert(inventoryButtons, inventoryType)
    end

    local you = vgui.Create("DPanel", tradeWindow)
    you:SetSize(tradeWindow:GetWide()*.4, tradeWindow:GetTall()*.425)
    you:SetPos(tradeWindow:GetWide()*.25 - (you:GetWide()/2), tradeWindow:GetTall()*.05)
    you.Paint = function(self, w, h)
        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(COLOR_AMBER)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local them = vgui.Create("DPanel", tradeWindow)
    them:SetSize(tradeWindow:GetWide()*.4, tradeWindow:GetTall()*.425)
    them:SetPos(tradeWindow:GetWide()*.25 - (them:GetWide()/2), tradeWindow:GetTall() - tradeWindow:GetTall()*.05 - them:GetTall())
    them.Paint = function(self, w, h)
        surface.SetDrawColor(Color(0, 0, 0, 0))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(COLOR_AMBER)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    showInventory = function(type)
        if tradeWindow.inventory then
            for k,v in pairs(tradeWindow.inventory) do
                v:Remove()
            end
            tradeWindow.inventory = nil
        end

        tradeWindow.inventory = {}
        tradeWindow.lastOpenInventory = type

        // Items
        local items = table.Copy(LocalPlayer().inventory[string.lower(inventoryTypes[type])])

        local menu = vgui.Create("FalloutRP_Scroll_List", inventory)
        menu:SetPos(inventory:GetWide()*0.05, 10 + buttonH)
        menu:SetSize(inventory:GetWide()*0.9, inventory:GetTall() * .7)
        menu:CreateScroll()
        menu:HideSideBars()
        menu:SetFontTitle("FalloutRP2", "Inventory")
        menu.DrawBackground = function(self)
            surface.SetDrawColor(COLOR_HIDDEN)
            surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        end


        local layout = menu.layout
        local scrollerW = menu.scroller:GetWide()
        local textPadding = 10

        for k,v in pairs(items) do
            local existingItem = LocalPlayer().trade[LocalPlayer()].offer.items[v.uniqueid]

            if existingItem then
                if !util.positive(existingItem.quantity) then
                    // User only has one of this item
                    continue
                else
                    // Reduce quantity of inventory item by item up for offer
                    v.quantity = v.quantity - existingItem.quantity
                    if !util.positive(v.quantity) then
                        continue
                    end
                end
            end

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
                if util.positive(v.quantity) then
                    offerItem(v.classid, k, 1)
                else
                    offerItem(v.classid, k)
                end
            end
            itemBox.DoRightClick = function()
                if util.greaterThanOne(v.quantity) then
                    surface.PlaySound("pepboy/click1.wav")

                    local flyout = vgui.Create("DMenu", menu)
                    flyout:AddOption("Offer all", function()
                        offerItem(v.classid, k, v.quantity)
                    end)
                    flyout:AddOption("Offer (x)", function()
                        local slider = vgui.Create("FalloutRP_NumberWang", menu)
                        slider:SetPos(menu:GetWide()/2 - slider:GetWide()/2, menu:GetTall()/2 - slider:GetTall()/2)
                        slider:SetMinimum(1)
                        slider:SetMaximum(v.quantity)
                        slider:SetValue(1)
                        slider:SetText("Offer")
                        slider:GetButton().DoClick = function()
                            if slider:ValidInput() then
                                offerItem(v.classid, k, slider:GetAmount())
                                slider:Remove()
                            end
                        end
                    end)

                    flyout:Open()

                    removeInspect()
                end
            end
            itemBox:SetText("")

            local itemLabel = vgui.Create("DLabel", itemBox)
            itemLabel:SetPos(textPadding, textPadding/2)
            itemLabel:SetFont("FalloutRP1")
            itemLabel:SetText(getItemNameQuantity(v.classid, v.quantity))
            itemLabel:SizeToContents()
            itemLabel:SetTextColor(COLOR_AMBER)

            itemBox.OnCursorEntered = function(self)
                removeInspect()

                self.hovered = true
                surface.PlaySound("pepboy/click2.wav")

                itemLabel:SetTextColor(COLOR_BLUE)

                if !isCap(v.classid) then
                    local frameX, frameY = tradeWindow:GetPos()
                    inspect = vgui.Create("FalloutRP_Item")
                    inspect:SetPos(frameX + tradeWindow:GetWide(), frameY)
                    inspect:SetItem(v)

                    // Allow inspect to be closed via X button
                    tradeWindow.inspect = inspect
                end
            end
            itemBox.OnCursorExited = function(self)
                removeInspect()

                self.hovered = false

                itemLabel:SetTextColor(COLOR_AMBER)
            end

            layout:Add(itemBox)
        end
        table.insert(tradeWindow.inventory, menu)

        // Caps
        local currentCaps = LocalPlayer():getCaps() - LocalPlayer().trade[LocalPlayer()].offer.caps

        local caps = vgui.Create("DLabel", inventory)
        local itemsX, itemsY = menu:GetPos()
        caps:SetPos(itemsX, itemsY + menu:GetTall() + textPadding*2)
        caps:SetTextColor(COLOR_AMBER)
        caps:SetFont("FalloutRP2")
        caps:SetText("Caps: " ..string.Comma(currentCaps))
        caps:SizeToContents()
        table.insert(tradeWindow.inventory, caps)

        local addCaps = vgui.Create("DButton", inventory)
        local capsX, capsY = caps:GetPos()
        addCaps:SetSize(20, 20)
        addCaps:SetPos(capsX + caps:GetWide() + textPadding + addCaps:GetWide()/2, capsY)
        addCaps:SetText("")
        addCaps.Paint = function(self, w, h)
            surface.SetDrawColor(COLOR_WHITE)
            surface.SetMaterial(coinsAdd)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        addCaps.DoClick = function(self)
            local slider = vgui.Create("FalloutRP_NumberWang", inventory)
            slider:SetPos(inventory:GetWide()/2 - slider:GetWide()/2, inventory:GetTall()/2 - slider:GetTall()/2)
            slider:SetMinimum(1)
            slider:SetMaximum(currentCaps)
            slider:SetValue(1)
            slider:SetText("Offer")
            slider:GetButton().DoClick = function()
                if slider:ValidInput() then
                    offerCaps(slider:GetAmount())
                    slider:Remove()
                end
            end
        end

        table.insert(tradeWindow.inventory, addCaps)
    end

    showYou = function()
        if tradeWindow.you then
            for k,v in pairs(tradeWindow.you) do
                v:Remove()
            end

            tradeWindow.you = nil
        end
        tradeWindow.you = {}

        // Items
        local menu = vgui.Create("FalloutRP_Scroll_List", you)
        menu:SetPos(0, 0)
        menu:SetSize(you:GetWide(), you:GetTall())
        menu:CreateScroll()
        menu:HideAllBars()
        menu:SetFontTitle("FalloutRP2", "Your Offer")
        menu.DrawBackground = function(self)
            surface.SetDrawColor(COLOR_HIDDEN)
            surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        end

        local layout = menu.layout
        local container = menu.container
        local scrollerW = menu.scroller:GetWide()
        local textPadding = 10

        for k,v in pairs(LocalPlayer().trade[LocalPlayer()].offer.items) do
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
                if util.positive(v.quantity) then
                    unofferItem(k, 1)
                else
                    unofferItem(k)
                end
            end
            itemBox.DoRightClick = function()
                if util.greaterThanOne(v.quantity) then
                    surface.PlaySound("pepboy/click1.wav")

                    local flyout = vgui.Create("DMenu", frame)
                    flyout:AddOption("Remove all", function()
                        unofferItem(k, v.quantity)
                    end)
                    flyout:AddOption("Remove (x)", function()
                        local slider = vgui.Create("FalloutRP_NumberWang", menu)
                        slider:SetPos(menu:GetWide()/2 - slider:GetWide()/2, menu:GetTall()/2 - slider:GetTall()/2)
                        slider:SetMinimum(1)
                        slider:SetMaximum(v.quantity)
                        slider:SetValue(1)
                        slider:SetText("Remove")
                        slider:GetButton().DoClick = function()
                            if slider:ValidInput() then
                                unofferItem(k, slider:GetAmount())
                            end
                        end
                    end)

                    flyout:Open()
                end
            end
            itemBox:SetText("")

            local itemLabel = vgui.Create("DLabel", itemBox)
            itemLabel:SetPos(textPadding, textPadding/2)
            itemLabel:SetFont("FalloutRP1")
            itemLabel:SetText(getItemNameQuantity(v.classid, v.quantity))
            itemLabel:SizeToContents()
            itemLabel:SetTextColor(COLOR_AMBER)

            itemBox.OnCursorEntered = function(self)
                removeInspect()

                self.hovered = true
                surface.PlaySound("pepboy/click2.wav")

                itemLabel:SetTextColor(COLOR_BLUE)

                if !isCap(v.classid) then
                    local frameX, frameY = tradeWindow:GetPos()
                    inspect = vgui.Create("FalloutRP_Item")
                    inspect:SetPos(frameX - inspect:GetWide(), frameY)
                    inspect:SetItem(v)

                    // Allow inspect to be closed via X button
                    tradeWindow.inspect = inspect
                end
            end
            itemBox.OnCursorExited = function(self)
                removeInspect()

                self.hovered = false

                itemLabel:SetTextColor(COLOR_AMBER)
            end

            layout:Add(itemBox)
        end

        // Caps
        local caps = vgui.Create("DLabel", menu)
        local itemsX, itemsY = container:GetPos()
        caps:SetPos(itemsX, itemsY + container:GetTall() + textPadding)
        caps:SetTextColor(COLOR_AMBER)
        caps:SetFont("FalloutRP1")
        caps:SetText("Caps: " ..LocalPlayer().trade[LocalPlayer()].offer.caps)
        caps:SizeToContents()

        local removeCaps = vgui.Create("DButton", menu)
        local capsX, capsY = caps:GetPos()
        removeCaps:SetSize(16, 16)
        removeCaps:SetPos(capsX + caps:GetWide() + textPadding + removeCaps:GetWide()/2, capsY)
        removeCaps:SetText("")
        removeCaps.Paint = function(self, w, h)
            surface.SetDrawColor(COLOR_WHITE)
            surface.SetMaterial(coinsDelete)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        removeCaps.DoClick = function(self)
            local slider = vgui.Create("FalloutRP_NumberWang", menu)
            slider:SetPos(menu:GetWide()/2 - slider:GetWide()/2, menu:GetTall()/2 - slider:GetTall()/2)
            slider:SetMinimum(1)
            slider:SetMaximum(LocalPlayer().trade[LocalPlayer()].offer.caps)
            slider:SetValue(1)
            slider:SetText("Remove")
            slider:GetButton().DoClick = function()
                if slider:ValidInput() then
                    unofferCaps(slider:GetAmount())
                    slider:Remove()
                end
            end
        end

        showYouStatus = function()
            if tradeWindow.you and tradeWindow.you.statusButton then
                tradeWindow.you.statusButton:Remove()
                tradeWindow.you.statusButton = nil
            end

            local status = getYouStatus()
            local statusButton = vgui.Create("FalloutRP_Button", menu)
            local removeCapsX, removeCapsY = removeCaps:GetPos()
            statusButton:SetSize(container:GetWide()*.4, 20)
            statusButton:SetPos(itemsX + container:GetWide() - statusButton:GetWide(), removeCapsY)
            statusButton:SetText(getYouStatusText())
            if status == 3 then
                statusButton:SetDisabled()
            end
            statusButton.DoClick = function(self)
                if !self:GetDisabled() then
                    net.Start("updateStatusTrade")
                        net.WriteInt(status, 8)
                    net.SendToServer()
                end
            end

            tradeWindow.you.statusButton = statusButton
        end

        showYouStatus()

        table.insert(tradeWindow.you, menu)
        table.insert(tradeWindow.you, caps)
        table.insert(tradeWindow.you, removeCaps)
    end

    showThem = function()
        if tradeWindow.them then
            for k,v in pairs(tradeWindow.them) do
                v:Remove()
            end

            tradeWindow.them = nil
        end
        tradeWindow.them = {}

        local otherTrader = getOtherTrader()

        local menu = vgui.Create("FalloutRP_Scroll_List", them)
        menu:SetPos(0, 0)
        menu:SetSize(them:GetWide(), them:GetTall())
        menu:CreateScroll()
        menu:HideAllBars()
        menu:SetFontTitle("FalloutRP2", otherTrader:getName() .."'s Offer")
        menu.DrawBackground = function(self)
            surface.SetDrawColor(COLOR_HIDDEN)
            surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
        end

        local layout = menu.layout
        local container = menu.container
        local scrollerW = menu.scroller:GetWide()
        local textPadding = 10

        for k,v in pairs(LocalPlayer().trade[otherTrader].offer.items) do
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
            itemBox:SetText("")

            local itemLabel = vgui.Create("DLabel", itemBox)
            itemLabel:SetPos(textPadding, textPadding/2)
            itemLabel:SetFont("FalloutRP1")
            itemLabel:SetText(getItemNameQuantity(v.classid, v.quantity))
            itemLabel:SizeToContents()
            itemLabel:SetTextColor(COLOR_AMBER)

            itemBox.OnCursorEntered = function(self)
                removeInspect()

                self.hovered = true
                surface.PlaySound("pepboy/click2.wav")

                itemLabel:SetTextColor(COLOR_BLUE)

                if !isCap(v.classid) then
                    local frameX, frameY = tradeWindow:GetPos()
                    inspect = vgui.Create("FalloutRP_Item")
                    inspect:SetPos(frameX - inspect:GetWide(), frameY)
                    inspect:SetItem(v)

                    // Allow inspect to be closed via X button
                    tradeWindow.inspect = inspect
                end
            end
            itemBox.OnCursorExited = function(self)
                removeInspect()

                self.hovered = false

                itemLabel:SetTextColor(COLOR_AMBER)
            end

            layout:Add(itemBox)
        end

        // Caps
        local caps = vgui.Create("DLabel", menu)
        local itemsX, itemsY = container:GetPos()
        caps:SetPos(itemsX, itemsY + container:GetTall() + textPadding)
        caps:SetTextColor(COLOR_AMBER)
        caps:SetFont("FalloutRP1")
        caps:SetText("Caps: " ..string.Comma(LocalPlayer().trade[otherTrader].offer.caps))
        caps:SizeToContents()

        showThemStatus = function()
            if tradeWindow.you and tradeWindow.you.statusText then
                tradeWindow.you.statusText:Remove()
                tradeWindow.you.statusText = nil
            end

            local statusText = vgui.Create("DLabel", menu)
            local capsX, capsY = caps:GetPos()
            statusText:SetFont("FalloutRP1")
            statusText:SetTextColor(COLOR_AMBER)
            statusText:SetText("Status: " ..getThemStatus())
            statusText:SizeToContents()
            statusText:SetPos(itemsX + container:GetWide() - statusText:GetWide(), capsY)

            tradeWindow.you.statusText = statusText
        end

        showThemStatus()

        table.insert(tradeWindow.them, menu)
        table.insert(tradeWindow.them, caps)
    end

    inventoryButtons[1]:DoClick()
    showYou()
    showThem()
end
