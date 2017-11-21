// Many different hooks to add quest progress

hook.Add("CraftedItem", "CraftedQuestItem", function(ply, item, quantity)
    local quantity = quantity or 1
    local classid = item.classid

    // Quest 9
    if classid == 1056 then
        ply:addQuestProgress(9, 1, 1)
    elseif classid == 3001 then
        ply:addQuestProgress(9, 2, quantity)
    elseif classid == 1074 then
        ply:addQuestProgress(9, 3, 1)
    elseif classid == 1075 then
        ply:addQuestProgress(9, 4, 1)
    elseif classid == 4001 then
        ply:addQuestProgress(9, 5, quantity)

    // Quest 10
    elseif classid == 2018 then
        ply:addQuestProgress(10, 1, 1)
    elseif classid == 2030 then
        ply:addQuestProgress(10, 2, 1)
    elseif classid == 2073 then
        ply:addQuestProgress(10, 3, 1)
    elseif classid == 2086 then
        ply:addQuestProgress(10, 4, 1)

    // Quest 11
    elseif classid == 1052 then
        ply:addQuestProgress(11, 1, 1)
    elseif classid == 3009 then
        ply:addQuestProgress(11, 2, quantity)

    // Quest 12
    elseif classid == 2016 then
        ply:addQuestProgress(12, 1, 1)
    elseif classid == 2028 then
        ply:addQuestProgress(12, 2, 1)
    elseif classid == 2001 then
        ply:addQuestProgress(12, 3, 1)
    elseif classid == 2071 then
        ply:addQuestProgress(12, 4, 1)
    elseif classid == 2084 then
        ply:addQuestProgress(12, 5, 1)
    end
end)

hook.Add("FactoryOpened", "FactoryQuest", function(ply, factory)
    /*
        if factory == "Materials Factory" then
            ply:addQuestProgress(6, 1, 1)
        elseif factory == "Apparel Factory" then
            ply:addQuestProgress(6, 2, 1)
        elseif factory == "Bottlecap Factory" then
            ply:addQuestProgress(6, 3, 1)
        elseif "Ammo Factory" then
            ply:addQuestProgress(6, 4, 1)
        end
    */
end)

hook.Add("OnNPCKilled", "NPCQuest", function(npc, attacker, inflictor)
    if attacker:IsPlayer() then
        local class = npc:GetClass()

        if class == "npc_ghoulferal" or class == "npc_ghoulferal_swamp" or class == "npc_ghoulferal_reaver" or class == "npc_ghoulferal_roamer" then
            attacker:addQuestProgress(8, 1, 1)
        end
    end
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
