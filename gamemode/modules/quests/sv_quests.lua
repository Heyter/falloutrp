
util.AddNetworkString("loadQuests")
util.AddNetworkString("updateQuest")
util.AddNetworkString("openQuestMenu")
util.AddNetworkString("acceptQuest")
util.AddNetworkString("completeQuest")
util.AddNetworkString("returnQuestMaterials")

net.Receive("acceptQuest", function(len, ply)
    local questId = net.ReadInt(16)

    ply:acceptQuest(questId)
end)

net.Receive("completeQuest", function(len, ply)
    local questId = net.ReadInt(16)

    ply:completeQuest(questId)
end)

net.Receive("returnQuestMaterials", function(len, ply)
    local questId = net.ReadInt(16)

    ply:returnQuestMaterials(questId)
end)

function QUESTS:getItemQuest(id)
    return self.questItems[id].quest[1]
end

function QUESTS:getItemTask(id)
    return self.questItems[id].quest[2]
end

function QUESTS:spawnQuestItems()
    for k,v in pairs(self.questItems) do
        local ent = ents.Create("quest_item")
        ent:SetPos(v.position)
        ent:SetAngles(v.angle)
        ent:SetModel(v.model)
        ent:SetID(k)
        ent:Spawn()
        ent:DropToFloor()
    end
end

function QUESTS:spawnQuestGivers()
    for k,v in pairs(self.questGivers) do
        local giver = ents.Create("questgiver")
        giver:SetPos(v.position)
        giver:SetAngles(v.angles)
        giver:Spawn()
        giver:SetModel(v.model)
        giver:SetNickname(v.name)
        giver:DropToFloor()
    end
end

function QUESTS:getSQLName(questId)
    return "quest" ..questId
end

function QUESTS:getSQLTask(taskId)
    return "task" ..taskId
end

function QUESTS:getSQLTasksNameValues(questId)
    local names = ""
    local values = ""

    for i = 1, #self:getTasks(questId) do
        names = names .."task" ..i ..", "
        values = values .."0, "
    end

    return names, values
end

local meta = FindMetaTable("Player")

function meta:lootQuestItem(classid, quantity)
    quest, task = QUESTS:getItemQuest(classid), QUESTS:getItemTask(classid)

    if !self:hasQuest(quest) then return false end
    if self:isQuestTaskComplete(quest, task) then return false end

    local quantity = quantity or 1
    local needed = QUESTS:getTaskProgressNeeded(quest, task) - self:getTaskProgress(quest, task)

    // Check if player has too max of the item in bank or inventory
    local type = classidToStringType(classid)
    local invItem = self:hasInventoryItem(type, classid)
    invItem = self:getInventoryItem(invItem, classid)
    local bankItem = self:hasBankItem(type, classid)

    local totalQuantity = 0

    if invItem then
        if invItem.quantity then
            totalQuantity = totalQuantity + invItem.quantity
        else
            totalQuantity = totalQuantity + 1
        end
    end
    if bankItem then
        if bankItem.quantity then
            totalQuantity = totalQuantity + bankItem.quantity
        else
            totalQuantity = totalQuantity + 1
        end
    end

    totalQuantity = totalQuantity + quantity

    if totalQuantity > needed then
        self:notify("You can not take any more of this item", NOTIFY_ERROR, 5)
        return
    end

    self:pickUpItem(createItem(classid, 1), 1)
    self:notify("Quest item found.", NOTIFY_GENERIC, 5)

    return quantity
end

function meta:addQuestProgress(questId, taskId, progress)
    if !self:hasQuest(questId) then return end
    if self:isQuestTaskComplete(questId, taskId)  then return end

    self.quests[questId].tasks[taskId] = self.quests[questId].tasks[taskId] + progress

    MySQLite.query("UPDATE " ..QUESTS:getSQLName(questId) .." SET " ..QUESTS:getSQLTask(taskId) .." = " ..self.quests[questId].tasks[taskId] .." WHERE steamid = '" ..self:SteamID() .."'")

    self:updateQuest(questId)

    self:notify("Task progress updated.", NOTIFY_GENERIC)
end

function meta:returnQuestMaterials(questId)
    local removals = QUESTS:getRemovals(questId)
    local returnedSome = false

    for k,v in pairs(removals) do
        local taskId = v[1]

        if self:isQuestTaskComplete(questId, taskId) then
            continue
        end

        local uniqueid = self:hasInventoryItem(classidToStringType(k), k)
        local invItem = self:getInventoryItem(uniqueid, k)

        local progressGained = 0

        if invItem then
            invItem.quantity = invItem.quantity or 1

            local has = self:getTaskProgress(questId, taskId)
            local need = QUESTS:getTaskProgressNeeded(questId, taskId)
            local togo = need - has

            if invItem.quantity >= togo then
                self:depleteInventoryItem(classidToStringType(k), uniqueid, togo)
                progressGained = togo
            else
                self:depleteInventoryItem(classidToStringType(k), uniqueid, invItem.quantity)
                progressGained = invItem.quantity
            end

            self:addQuestProgress(questId, taskId, progressGained)

            returnedSome = true
        end
    end

    if returnedSome then
        self:notify("You have returned some items.", NOTIFY_GENERIC)
    else
        self:notify("You have no items to return.", NOTIFY_ERROR)
    end
end

function meta:acceptQuest(questId)
    if self:hasQuest(questId) then return end

    self.quests[questId] = {
        completed = false,
        tasks = {}
    }

    for i = 1, #QUESTS:getTasks(questId) do
        self.quests[questId].tasks[i] = 0
    end
    // Not needed on the server side, but easier track accepted quests by default and send to client in update
    self.quests[questId].track = true

    local taskNames, taskValues = QUESTS:getSQLTasksNameValues(questId)

    MySQLite.query("INSERT INTO " ..QUESTS:getSQLName(questId) .."(steamid, " ..taskNames .."completed) VALUES ('" ..self:SteamID() .."', " ..taskValues .." 0)")

    self:updateQuest(questId)

    self:notify("You have accepted " ..QUESTS:getName(questId), NOTIFY_GENERIC, 10)
end

function meta:completeQuest(questId)
    // Check finished all tasks
    if !self:finishedQuestTasks(questId) then return end

    // Check has space for reward items
    local rewards = QUESTS:getRewards(questId)
    if rewards.items then
        local weight = 0

        for k,v in pairs(rewards.items) do
            local itemWeight = getItemWeight(k) * v

            weight = weight + itemWeight

            if weight + self:getInventoryWeight() > self:getMaxInventory() then
                self:notify("You don't have enough space for your rewards.", NOTIFY_ERROR, 5)
                return
            end
        end
    end

    if rewards.items then
        for k,v in pairs(rewards.items) do
            self:pickUpItem(createItem(k, v, false, true), v)
        end
    end
    if rewards.experience then
        self:addExp(rewards.experience)
    end
    if rewards.caps then
        self:addCaps(rewards.caps)
    end

    self.quests[questId].completed = true

    self:updateQuest(questId)

    MySQLite.query("UPDATE " ..QUESTS:getSQLName(questId) .." SET completed = 1 WHERE steamid = '" ..self:SteamID() .."'")

    self:notify("You have completed " ..QUESTS:getName(questId) .."!", NOTIFY_GENERIC)

    hook.Call("QuestCompleted", GAMEMODE, self, questId)
end

function meta:loadQuestCount()
    self.questsLoaded = self.questsLoaded or 0
    self.questsLoaded = self.questsLoaded + 1

    if self.questsLoaded == #QUESTS.quests then
        net.Start("loadQuests")
            net.WriteTable(self.quests)
        net.Send(self)

        // Reset the count incase the player reloads
        self.questsLoaded = 0
    end
end

function meta:loadQuest(questId)
    local quest = "quest" ..questId

    MySQLite.query("SELECT * FROM " ..quest .." WHERE steamid = '" ..self:SteamID() .."'", function(results)
        if results then
            self.quests[questId] = {}
            self.quests[questId].tasks = {}

            for k,v in pairs(results) do
                for column, value in pairs(v) do
                    if column == "completed" then
                        self.quests[questId].completed = tobool(value)
                    elseif string.sub(column, 1, 4) == "task" then
                        local id = tonumber(string.sub(column, 5, 8)) // Able to string.sub past the length, so we account for single, double, and triple digits
                        self.quests[questId].tasks[id] = tonumber(value)
                    end
                end
            end
        end

        self:loadQuestCount()
    end)
end

function meta:loadQuests()
    self.quests = {}

    for i = 1, #QUESTS.quests do
        self:loadQuest(i)
    end
end

function meta:updateQuest(questId)
    net.Start("updateQuest")
        net.WriteInt(questId, 16)
        net.WriteTable(self.quests[questId])
    net.Send(self)
end

hook.Add("InitPostEntity", "questSetup", function()
    QUESTS:spawnQuestGivers()
    QUESTS:spawnQuestItems()
end)
