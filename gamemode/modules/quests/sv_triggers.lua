// Many different hooks to add quest progress

hook.Add("CraftedItem", "CraftedQuestItem", function(ply, item, quantity)

end)

hook.Add("TalkedToNpc", "TalkedToQuestNpc", function(ply, npc)
    if npc == "John" then
        ply:addQuestProgress(2, 1, 1)
    elseif npc == "Sky" then
        ply:addQuestProgress(2, 2, 1)
    elseif npc == "Samantha" then
        ply:addQuestProgress(2, 3, 1)
    elseif npc == "Billy" then
        ply:addQuestProgress(2, 4, 1)
    end
end)
