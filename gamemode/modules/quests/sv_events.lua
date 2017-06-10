
hook.Add("QuestCompleted", "DoQuestEvent", function(ply, questId)
    if questId == 1 then
        ply:pvpProtection()
    end
end)
