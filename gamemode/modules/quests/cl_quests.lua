
net.Receive("loadQuests", function()
    local quests = net.ReadTable()

    LocalPlayer().quests = quests

    LocalPlayer():loadPlayerDataCount()
end)

net.Receive("updateQuest", function()
    local questId = net.ReadInt(16)
    local quest = net.ReadTable()

    local wasTracked = self:getQuestTrack(questId)

    LocalPlayer().quests[questId] = quest
    LocalPlayer().quests[questId].trach = wasTracked
end)

local meta = FindMetaTable("Player")

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

hook.Add("HUDPaint", "questTracker", function()
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
end)
