
local menuW, menuH = 900, 600
local showMenu, acceptMenu

// Sounds
sound.Add({
	name = "quest1",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest1.mp3"
})
sound.Add({
	name = "quest2",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest2.mp3"
})
sound.Add({
	name = "quest3",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest3.mp3"
})
sound.Add({
	name = "quest4",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest4.mp3"
})
sound.Add({
	name = "quest5",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest5.mp3"
})
sound.Add({
	name = "quest6",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest6.mp3"
})
sound.Add({
	name = "quest7",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest7.mp3"
})
sound.Add({
	name = "quest8",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 85,
	sound = "falloutrp/quests/quest8.mp3"
})
sound.Add({
	name = "quest9",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 90,
	sound = "falloutrp/quests/quest9.mp3"
})
sound.Add({
	name = "quest10",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 90,
	sound = "falloutrp/quests/quest10.mp3"
})
sound.Add({
	name = "quest11",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 90,
	sound = "falloutrp/quests/quest11.mp3"
})
sound.Add({
	name = "quest12",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 90,
	sound = "falloutrp/quests/quest12.mp3"
})
sound.Add({
	name = "quest13",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 80,
	sound = "falloutrp/quests/quest13.mp3"
})
sound.Add({
	name = "quest14",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 80,
	sound = "falloutrp/quests/quest14.mp3"
})
sound.Add({
	name = "quest15",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 80,
	sound = "falloutrp/quests/quest15.mp3"
})
sound.Add({
	name = "quest16",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 150,
    pitch = 80,
	sound = "falloutrp/quests/quest16.mp3"
})
sound.Add({
	name = "quest17",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 500,
    pitch = 120,
	sound = "falloutrp/quests/quest17.mp3"
})

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
    if IsValid(showMenu) or IsValid(acceptMenu) then return end

    local questGiver = net.ReadString()

	local alternateMenu = QUESTS:alternateGiverMenu(questGiver)

	if alternateMenu then
		QUESTS:multipleChoiceMenu(QUESTS.menus[alternateMenu], questGiver)
	else
		LocalPlayer():openQuestMenu(questGiver)
	end
end)

local function openVehicleMenu()
	VEHICLES.openMenu()
end

QUESTS.menus = {
	[1] = {
		func = openVehicleMenu,
		desc = "I'd like to see my vehicles"
	}
}

function QUESTS:multipleChoiceMenu(alternate, questGiver)
	local frame = vgui.Create("FalloutRP_Multiple_Choice")
	local frameX, frameY = frame:GetPos()
	frame:SetPos(frameX, ScrH() - frame:GetTall() - 100)
	frame:SetFontTitle("FalloutRP3", "Token Shop")
	frame:AddCloseButton()
	frame:HideSideBars()
	frame:MakePopup()

	frame:AddIntro("Hey there, what can I do for ya?")
	frame:AddButton(alternate.desc, function()
		alternate.func()
		frame:Remove()
	end)
	frame:AddButton("I'm looking for some work", function()
		LocalPlayer():openQuestMenu(questGiver)
		frame:Remove()
	end)
end

function QUESTS:alternateGiverMenu(questGiver)
	return self.questGivers[questGiver].alternateMenu
end

local meta = FindMetaTable("Player")

function meta:acceptQuest(questId)
    net.Start("acceptQuest")
        net.WriteInt(questId, 16)
    net.SendToServer()
end

function meta:completeQuest(questId)
    net.Start("completeQuest")
        net.WriteInt(questId, 16)
    net.SendToServer()
end

function meta:returnQuestMaterials(questId)
    net.Start("returnQuestMaterials")
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
                surface.SetDrawColor(COLOR_FOREGROUND_FADE)
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(COLOR_FOREGROUND)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end
        questBox.DoClick = function()
            surface.PlaySound("pepboy/click1.wav")
            // Open complete quest menu
            util.cleanupFrame(showMenu)
            acceptQuestMenu(giver, v, true)
        end
        questBox:SetText("")

        local questLabel = vgui.Create("DLabel", questBox)
        questLabel:SetPos(textPadding, textPadding/2)
        questLabel:SetFont("FalloutRP2")
        questLabel:SetText(QUESTS:getName(v) .." (In Progress)")
        questLabel:SizeToContents()
        questLabel:SetTextColor(COLOR_FOREGROUND)

        questBox.OnCursorEntered = function(self)
            self.hovered = true
            surface.PlaySound("pepboy/click2.wav")

            questLabel:SetTextColor(COLOR_BLUE)
        end
        questBox.OnCursorExited = function(self)
            self.hovered = false

            questLabel:SetTextColor(COLOR_FOREGROUND)
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
                surface.SetDrawColor(COLOR_FOREGROUND_FADE)
                surface.DrawRect(0, 0, w, h)

                surface.SetDrawColor(COLOR_FOREGROUND)
                surface.DrawOutlinedRect(0, 0, w, h)
            end
        end
        questBox.DoClick = function()
            surface.PlaySound("pepboy/click1.wav")
            // Open accept quest menu
            util.cleanupFrame(showMenu)
            acceptQuestMenu(giver, v)
        end
        questBox:SetText("")

        local questLabel = vgui.Create("DLabel", questBox)
        questLabel:SetPos(textPadding, textPadding/2)
        questLabel:SetFont("FalloutRP2")
        questLabel:SetText(QUESTS:getName(v) .." (Available)")
        questLabel:SizeToContents()
        questLabel:SetTextColor(COLOR_FOREGROUND)

        questBox.OnCursorEntered = function(self)
            self.hovered = true
            surface.PlaySound("pepboy/click2.wav")

            questLabel:SetTextColor(COLOR_BLUE)
        end
        questBox.OnCursorExited = function(self)
            self.hovered = false

            questLabel:SetTextColor(COLOR_FOREGROUND)
        end

        layout:Add(questBox)
    end
end

function acceptQuestMenu(questGiver, questId, finish)
    local name = QUESTS:getName(questId)
    local description = QUESTS:getDescription(questId)
    local rewards = QUESTS:getRewards(questId)
    local removals = QUESTS:getRemovals(questId)
    local lastX, lastY, lastTall = 0, 0, 0
    local objectives = ""
    for k,v in ipairs(QUESTS:getTasks(questId)) do
        objectives = objectives ..v.taskDescription .."\n"
    end

    if !finish then
        LocalPlayer():EmitSound("quest" ..questId)
    end

    acceptMenu = vgui.Create("FalloutRP_Menu")
    acceptMenu:SetSize(menuW, menuH)
    acceptMenu:SetPos(ScrW()/2 - acceptMenu:GetWide()/2, ScrH()/2 - acceptMenu:GetTall()/2)
    acceptMenu:SetFontTitle("FalloutRP3", questGiver)
    acceptMenu:AddCloseButton()
    acceptMenu.onClose = function()
        LocalPlayer():StopSound("quest" ..questId)
    end
    acceptMenu:MakePopup()

    local nameTitle = vgui.Create("DLabel", acceptMenu)
    nameTitle:SetFont("FalloutRP3")
    nameTitle:SetPos(50, 50)
    nameTitle:SetTextColor(COLOR_FOREGROUND)
    nameTitle:SetText(name)
    nameTitle:SizeToContents()
    lastX, lastY = nameTitle:GetPos()

    local descLabel = vgui.Create("DLabel", acceptMenu)
    descLabel:SetFont("FalloutRP2")
    descLabel:SetPos(50, lastY + nameTitle:GetTall() + 10)
    descLabel:SetTextColor(COLOR_FOREGROUND)
    descLabel:SetText(util.textWrap(description, acceptMenu:GetWide() - 100, "FalloutRP2"))
    descLabel:SizeToContents()
    lastX, lastY = descLabel:GetPos()

    local objectivesTitle = vgui.Create("DLabel", acceptMenu)
    objectivesTitle:SetFont("FalloutRP3")
    objectivesTitle:SetPos(50, lastY + descLabel:GetTall() + 10)
    objectivesTitle:SetTextColor(COLOR_FOREGROUND)
    objectivesTitle:SetText("Objectives")
    objectivesTitle:SizeToContents()
    lastX, lastY = objectivesTitle:GetPos()

    local objectivesLabel = vgui.Create("DLabel", acceptMenu)
    objectivesLabel:SetFont("FalloutRP2")
    objectivesLabel:SetPos(50, lastY + objectivesTitle:GetTall() + 10)
    objectivesLabel:SetTextColor(COLOR_FOREGROUND)
    objectivesLabel:SetText(util.textWrap(objectives, acceptMenu:GetWide() - 100, "FalloutRP2"))
    objectivesLabel:SizeToContents()
    lastX, lastY = objectivesLabel:GetPos()

    local rewardsTitle = vgui.Create("DLabel", acceptMenu)
    rewardsTitle:SetFont("FalloutRP3")
    rewardsTitle:SetPos(50, lastY + objectivesLabel:GetTall())
    rewardsTitle:SetTextColor(COLOR_FOREGROUND)
    rewardsTitle:SetText("Rewards")
    rewardsTitle:SizeToContents()
    lastX, lastY = rewardsTitle:GetPos()
    lastTall = rewardsTitle:GetTall()

    if util.positive(rewards.caps) then
        local rewardsCaps = vgui.Create("DLabel", acceptMenu)
        rewardsCaps:SetFont("FalloutRP2")
        rewardsCaps:SetPos(50, lastY + lastTall + 5)
        rewardsCaps:SetTextColor(COLOR_FOREGROUND)
        rewardsCaps:SetText("Caps: " ..string.Comma(rewards.caps))
        rewardsCaps:SizeToContents()
        lastX, lastY = rewardsCaps:GetPos()
        lastTall = rewardsCaps:GetTall()
    end
    if util.positive(rewards.experience) then
        local rewardsExperience = vgui.Create("DLabel", acceptMenu)
        rewardsExperience:SetFont("FalloutRP2")
        rewardsExperience:SetPos(50, lastY + lastTall + 5)
        rewardsExperience:SetTextColor(COLOR_FOREGROUND)
        rewardsExperience:SetText("Experience: " ..string.Comma(rewards.experience))
        rewardsExperience:SizeToContents()
        lastX, lastY = rewardsExperience:GetPos()
        lastTall = rewardsExperience:GetTall()
    end
	if rewards.description then
		local rewardsDescription = vgui.Create("DLabel", acceptMenu)
		rewardsDescription:SetFont("FalloutRP2")
		rewardsDescription:SetPos(50, lastY + lastTall + 5)
		rewardsDescription:SetTextColor(COLOR_FOREGROUND)
		rewardsDescription:SetText(rewards.description)
		rewardsDescription:SizeToContents()
		lastX, lastY = rewardsDescription:GetPos()
		lastTall = rewardsDescription:GetTall()
	end
    if rewards.items then
        local itemOffset = 0

        for k,v in pairs(rewards.items) do
            local icon = vgui.Create("SpawnIcon", acceptMenu)
            icon:SetSize(90, 90)
            icon:SetPos(50 + itemOffset, lastY + lastTall + 5)
            // There is no model for apparels yet
            if !isApparel(k) then
				local itemMeta = findItem(k)
                icon:SetModel(itemMeta:getModel())
            end
            icon.OnCursorEntered = function(self)
                local frameX, frameY = acceptMenu:GetPos()
                acceptMenu.inspect = vgui.Create("FalloutRP_Item")
                acceptMenu.inspect:SetPos(frameX + acceptMenu:GetWide(), frameY)
                acceptMenu.inspect:SetItem({classid = k, quantity = v}, false, true)
            end
            icon.OnCursorExited = function(self)
				util.cleanupFrame(acceptMenu.inspect)
            end

            if util.positive(v) then
                local amount = vgui.Create("DLabel", icon)
                amount:SetFont("FalloutRP1")
                amount:SetText(string.Comma(v))
                amount:SetTextColor(COLOR_FOREGROUND)
                amount:SizeToContents()
                amount:SetPos(icon:GetWide() - amount:GetWide() - 5, icon:GetTall() - amount:GetTall() - 5)
            end

            itemOffset = itemOffset + icon:GetWide() + 5
        end
    end

    if !finish then
        local decline = vgui.Create("FalloutRP_Button", acceptMenu)
        decline:SetSize(100, 40)
        decline:SetPos(acceptMenu:GetWide()/2 - decline:GetWide() * 1.5, acceptMenu:GetTall() - 75)
        decline:SetFont("FalloutRP2")
        decline:SetText("Decline")
        decline.DoClick = function()
			acceptMenu:RemoveOverride()
            LocalPlayer():StopSound("quest" ..questId)
        end

        local accept = vgui.Create("FalloutRP_Button", acceptMenu)
        accept:SetSize(100, 40)
        accept:SetPos(acceptMenu:GetWide()/2 + accept:GetWide() *.5, acceptMenu:GetTall() - 75)
        accept:SetFont("FalloutRP2")
        accept:SetText("Accept")
        accept.DoClick = function()
            acceptMenu:RemoveOverride()
            LocalPlayer():acceptQuest(questId)
        end
    else
        if removals then
            local returnMaterials = vgui.Create("FalloutRP_Button", acceptMenu)
            returnMaterials:SetSize(175, 40)
            returnMaterials:SetPos(acceptMenu:GetWide()/2 - returnMaterials:GetWide() * 1.5, acceptMenu:GetTall() - 75)
            returnMaterials:SetFont("FalloutRP2")
            returnMaterials:SetText("Return Materials")
            returnMaterials.DoClick = function()
                acceptMenu:RemoveOverride()
                LocalPlayer():returnQuestMaterials(questId)
            end

            local complete = vgui.Create("FalloutRP_Button", acceptMenu)
            complete:SetSize(100, 40)
            complete:SetPos(acceptMenu:GetWide()/2 + complete:GetWide() *.5, acceptMenu:GetTall() - 75)
            complete:SetFont("FalloutRP2")
            complete:SetText("Complete")
            complete.DoClick = function()
                acceptMenu:RemoveOverride()
                LocalPlayer():completeQuest(questId)
            end
            if !LocalPlayer():finishedQuestTasks(questId) then
                complete:SetDisabled()
            end
        else
            local complete = vgui.Create("FalloutRP_Button", acceptMenu)
            complete:SetSize(100, 40)
            complete:SetPos(acceptMenu:GetWide()/2 - complete:GetWide()/2, acceptMenu:GetTall() - 75)
            complete:SetFont("FalloutRP2")
            complete:SetText("Complete")
            complete.DoClick = function()
                acceptMenu:RemoveOverride()
                LocalPlayer():completeQuest(questId)
            end
            if !LocalPlayer():finishedQuestTasks(questId) then
                complete:SetDisabled()
            end
        end
    end
end

hook.Add("HUDPaint", "questTracker", function()
    if LocalPlayer().quests then
        local offset = 0
        for k,v in pairs(LocalPlayer().quests) do
            if !v.completed and v.track then
                local color = util.getPepboyColor()
                offset = offset + 15

                // Quest Name
                for i = 1, 2 do
                    draw.SimpleText(QUESTS:getName(k), "FalloutRPHUD1Blur", ScrW() - 250, offset, Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 200), false, 0)
                end
                draw.SimpleText(QUESTS:getName(k), "FalloutRPHUD1", ScrW() - 250, offset, COLOR_BLACK, false, 0)

                // Quest Tasks
                for k,v in pairs(LocalPlayer():getQuestStats(k)) do
                    offset = offset + 25

                    draw.SimpleText(v.key .." " ..v.val, "FalloutRPQuest2", ScrW() - 230, offset, COLOR_WHITE, false, 0)
                end

                offset = offset + 10
            end
        end
   end
end)
