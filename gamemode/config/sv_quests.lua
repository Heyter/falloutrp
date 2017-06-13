
QUESTS = QUESTS or {}

QUESTS.questItems = {
    [5047] = {
        position = Vector(-13485, 3086, 63),
        angle = Angle(0, 0, 0),
        model = "models/tsbb/animals/linsang.mdl",
        quest = {4, 1}, // QuestID, TaskID
    },
    [5048] = {
        position = Vector(11793, -1259, 15),
        angle = Angle(0, 135, 0),
        model = "models/props_c17/BriefCase001a.mdl",
        quest = {7, 1},
    },
}

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

hook.Add("InitPostEntity", "SpawnQuestItems", QUESTS:spawnQuestItems())
