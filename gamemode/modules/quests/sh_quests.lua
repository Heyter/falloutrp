
local meta = FindMetaTable("Player")

function meta:hasQuest(id)
    return self.quests and self.quests[id] != nil
end

function meta:isQuestComplete(id)
    return self.quests and self.quests[id] and self.quests[id].completed
end

function meta:getTaskProgress(questId, taskId)
	return self.quests[questId].tasks[taskId]
end

function meta:metQuestPreconditions(id)
    local conditions = QUESTS:getPreconditions(id)

    if self:getLevel() < conditions.level then
        return false
    end

    if conditions.quests then
        for k,v in pairs(conditions.quests) do
            if !self:isQuestComplete(v) then
                return false
            end
        end
    end

    return true
end

function meta:isQuestTaskComplete(questId, taskId)
    local needed = QUESTS:getTaskProgressNeeded(questId, taskId)

    return self.quests and self.quests[questId] and (self.quests[questId].tasks[taskId] >= needed)
end

function meta:finishedQuestTasks(questId)
    for k,v in pairs(QUESTS:getTasks(questId)) do
        if !self:isQuestTaskComplete(questId, k) then
            return false
        end
    end

    return true
end

function QUESTS:getName(id)
	return self.quests[id].name
end

function QUESTS:getPreconditions(id)
    return self.quests[id].preconditions
end

function QUESTS:getRewards(id)
    return self.quests[id].rewards
end

function QUESTS:getRemovals(id)
    return self.quests[id].removals
end

function QUESTS:getDescription(id)
	return self.quests[id].description
end

function QUESTS:getTasks(questId)
	return self.quests[questId].tasks
end

function QUESTS:getTaskProgressNeeded(questId, taskId)
	return self:getTasks(questId)[taskId].task
end

function QUESTS:getGiverQuests(name)
    return self.questGivers[name].quests
end
