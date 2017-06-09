
local menuW, menuH = 900, 600
local showMenu, acceptMenu, completeMenu

net.Receive("loadQuests", function()
    local quests = net.ReadTable()

    LocalPlayer().quests = quests

    LocalPlayer():loadPlayerDataCount()
end)

net.Receive("updateQuest", function()
    local questId = net.ReadInt(16)
    local quest = net.ReadTable()

    local wasTracked = LocalPlayer():getQuestTrack(questId)

    LocalPlayer().quests[questId] = quest
    LocalPlayer().quests[questId].track = quest.track or wasTracked
end)

net.Receive("openQuestMenu", function()
    if IsValid(showMenu) or IsValid(acceptMenu) or IsValid(completeMenu) then return end

    local questGiver = net.ReadString()

    LocalPlayer():openQuestMenu(questGiver)
end)

local meta = FindMetaTable("Player")

function meta:acceptQuest(questId)
    net.Start("acceptQuest")
        net.WriteInt(questId, 16)
    net.SendToServer()
end

function meta:openQuestMenu(questGiver)
    local activeQuests = {}
    local availableQuests = {}

    for k,v in pairs(QUESTS:getGiverQuests(questGiver)) do
        if self:hasQuest(v) then
            if !self:isQuestComplete(v) then
                table.insert(activeQuests, v)
            end
        else
            if self:metQuestPreconditions(v) then
                table.insert(availableQuests, v)
            end
        end
    end

    if (#activeQuests < 1) and (#availableQuests < 1) then
        self:notify("Sorry I have no work for you right now, come back another time.", NOTIFY_GENERIC, 5)
    else
        showQuests(questGiver, activeQuests, availableQuests)
    end
end

function meta:getQuestTrack(questId)
    return tobool(self.quests and self.quests[questId] and self.quests[questId].track)
end

function meta:getQuestStats(questId)
    local stats = {}

    for k,v in pairs(QUESTS:getTasks(questId)) do
        local stat = {
            key = v.taskDescription,
            val = self:getTaskProgress(questId, k) .."/" ..v.task
        }

        table.insert(stats, stat)
    end

    return stats
end

local function close(menu)
    if menu then
        menu:Remove()
    end
end

// Quest Pick Menu
function showQuests(giver, active, available)
    local showMenu = vgui.Create("FalloutRP_Scroll_List")
    showMenu:SetSize(menuW, menuH)
    showMenu:SetPos(ScrW()/2 - showMenu:GetWide()/2, ScrH()/2 - showMenu:GetTall()/2)
    showMenu:CreateScroll()
    showMenu:SetFontTitle("FalloutRP3", giver)
    showMenu:AddCloseButton()
    showMenu:MakePopup()

    local layout = showMenu.layout
    local scrollerW = showMenu.scroller:GetWide()
    local textPadding = 10

    // Show active quests
    for k,v in ipairs(active) do
        local questBox = vgui.Create("DButton")
        questBox:SetSize(layout:GetWide() - scrollerW, 30)
        questBox.Paint = function(self, w, h)
            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            if self.hovered then
                surface.SetDrawColor(Color(255, 182, 66, 30))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(COLOR_AMBER)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end
        questBox.DoClick = function()
            surface.PlaySound("pepboy/click1.wav")
            // Open complete quest menu
        end
        questBox:SetText("")

        local questLabel = vgui.Create("DLabel", questBox)
        questLabel:SetPos(textPadding, textPadding/2)
        questLabel:SetFont("FalloutRP2")
        questLabel:SetText(QUESTS:getName(v) .." (In Progress)")
        questLabel:SizeToContents()
        questLabel:SetTextColor(COLOR_AMBER)

        questBox.OnCursorEntered = function(self)
            self.hovered = true
            surface.PlaySound("pepboy/click2.wav")

            questLabel:SetTextColor(COLOR_BLUE)
        end
        questBox.OnCursorExited = function(self)
            self.hovered = false

            questLabel:SetTextColor(COLOR_AMBER)
        end

        layout:Add(questBox)
    end

    // Show available quests
    for k,v in ipairs(available) do
        local questBox = vgui.Create("DButton")
        questBox:SetSize(layout:GetWide() - scrollerW, 30)
        questBox.Paint = function(self, w, h)
            surface.SetDrawColor(Color(0, 0, 0, 0))
            surface.DrawRect(0, 0, w, h)

            if self.hovered then
                surface.SetDrawColor(Color(255, 182, 66, 30))
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(COLOR_AMBER)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end
        questBox.DoClick = function()
            surface.PlaySound("pepboy/click1.wav")
            // Open accept quest menu
            close(showMenu)
            acceptQuestMenu(v)
        end
        questBox:SetText("")

        local questLabel = vgui.Create("DLabel", questBox)
        questLabel:SetPos(textPadding, textPadding/2)
        questLabel:SetFont("FalloutRP2")
        questLabel:SetText(QUESTS:getName(v) .." (Available)")
        questLabel:SizeToContents()
        questLabel:SetTextColor(COLOR_AMBER)

        questBox.OnCursorEntered = function(self)
            self.hovered = true
            surface.PlaySound("pepboy/click2.wav")

            questLabel:SetTextColor(COLOR_BLUE)
        end
        questBox.OnCursorExited = function(self)
            self.hovered = false

            questLabel:SetTextColor(COLOR_AMBER)
        end

        layout:Add(questBox)
    end
end

function acceptQuestMenu(questId)
    local name = QUESTS:getName(questId)
    local description = QUESTS:getDescription(questId)

    acceptMenu = vgui.Create("FalloutRP_Menu")
    acceptMenu:SetSize(menuW, menuH)
    acceptMenu:SetPos(ScrW()/2 - acceptMenu:GetWide()/2, ScrH()/2 - acceptMenu:GetTall()/2)
    acceptMenu:SetFontTitle("FalloutRP3", name)
    acceptMenu:AddCloseButton()
    acceptMenu.onClose = function()
        acceptMenu = nil
    end
    acceptMenu:MakePopup()

    local descLabel = vgui.Create("DLabel", acceptMenu)
    descLabel:SetFont("FalloutRP3")
    descLabel:SetPos(50, 60)
    descLabel:SetTextColor(COLOR_AMBER)
    descLabel:SetText(util.textWrap(description, acceptMenu:GetWide() - 100, "FalloutRP3"))
    descLabel:SizeToContents()

    local decline = vgui.Create("FalloutRP_Button", acceptMenu)
    decline:SetSize(100, 50)
    decline:SetPos(acceptMenu:GetWide()/2 - decline:GetWide() * 1.5, acceptMenu:GetTall() - 100)
    decline:SetFont("FalloutRP2")
    decline:SetText("Decline")
    decline.DoClick = function()
        close(acceptMenu)
    end

    local accept = vgui.Create("FalloutRP_Button", acceptMenu)
    accept:SetSize(100, 50)
    accept:SetPos(acceptMenu:GetWide()/2 + accept:GetWide() *.5, acceptMenu:GetTall() - 100)
    accept:SetFont("FalloutRP2")
    accept:SetText("Accept")
    accept.DoClick = function()
        close(acceptMenu)
        LocalPlayer():acceptQuest(questId)
    end
end

function completeQuestMenu(giver, questId)

end

hook.Add("HUDPaint", "questTracker", function()
    if LocalPlayer().quests then
        for k,v in pairs(LocalPlayer().quests) do
            if v.track then
                local color = util.getPepboyColor()
                local offset = 15

                // Quest Name
                draw.SimpleText(QUESTS:getName(k), "FalloutRPQuest1", ScrW() - 200, offset, color, false, 0)

                // Quest Tasks
                for k,v in pairs(LocalPlayer():getQuestStats(k)) do
                    offset = offset + 25

                    draw.SimpleText(v.key .." " ..v.val, "FalloutRPQuest2", ScrW() - 180, offset, COLOR_WHITE, false, 0)
                end

            end
        end
   end
end)
