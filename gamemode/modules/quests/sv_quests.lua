
util.AddNetworkString("loadQuests")
util.AddNetworkString("updateQuest")

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

function meta:isQuestTaskComplete(questId, taskId)
    local needed = QUESTS:getTaskProgressNeeded(questId, taskId)

    return self.quests and self.quests[questId] and (self.quests[questId].tasks[taskId] >= needed)
end

function meta:addQuestProgress(questId, taskId, progress)
    if !self:hasQuest(questId) then return end
    if self:isQuestTaskComplete(questId, taskId)  then return end

    self.quests[questId].tasks[taskId] = self.quests[questId].tasks[taskId] + progress

    MySQLite.query("UPDATE " ..QUESTS:getSQLName(questId) .." SET " ..QUESTS:getSQLTask(taskId) .." = " ..self.quests[questId].tasks[taskId] .." WHERE steamid = '" ..self:SteamID() .."'")
end

function meta:acceptQuest(questId, taskId)
    if self:hasQuest(questId) then return end

    self.quests[questId] = {
        completed = false,
        tasks = {}
    }

    for i = 1, #QUESTS:getTasks(questId) do
        self.quests[questId].tasks[i] = 0
    end

    local taskNames, taskValues = QUESTS:getSQLTasksNameValues(questId)

    MySQLite.query("INSERT INTO " ..QUESTS:getSQLName(questId) .."(steamid, " ..taskNames .."completed) VALUES ('" ..self:SteamID() .."', " ..taskValues .." 0)")
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
