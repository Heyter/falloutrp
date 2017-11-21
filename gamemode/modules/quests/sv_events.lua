
hook.Add("QuestCompleted", "DoQuestCompletedEvent", function(ply, questId)
    if questId == 1 then
        ply:pvpProtection()
    elseif questId == 22 then
        ply:unlockVehicle("airboat")
        ply:notify("Congratulations! You obtained a permanent airboat!", NOTIFY_GENERIC, 10)
    elseif questId == 23 then
        ply:unlockVehicle("jeep")
        ply:notify("Congratulations! You obtained a permanent jeep!", NOTIFY_GENERIC, 10)
    end
end)

hook.Add("QuestAccepted", "DoQuestAcceptedEvent", function(ply, questId)

end)
