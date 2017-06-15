// Many different hooks to add quest progress

hook.Add("CraftedItem", "CraftedQuestItem", function(ply, item, quantity)
    local quantity = quantity or 1
    local classid = item.classid

    if classid == 1056 then
        ply:addQuestProgress(3, 1, 1)
    elseif classid == 2003 then
        ply:addQuestProgress(5, 1, 1)
    elseif classid == 3017 then
        ply:addQuestProgress(9, 1, quantity)
    elseif classid == 3001 then
        ply:addQuestProgress(9, 2, quantity)
    elseif classid == 4001 then
        ply:addQuestProgress(10, 1, 1)
    end
end)

hook.Add("FactoryOpened", "FactoryQuest", function(ply, factory)
    print(factory)
    if factory == "Materials Factory" then
        ply:addQuestProgress(6, 1, 1)
    elseif factory == "Apparel Factory" then
        ply:addQuestProgress(6, 2, 1)
    elseif factory == "Caps Factory" then
        ply:addQuestProgress(6, 3, 1)
    elseif "Ammo Factory" then
        ply:addQuestProgress(6, 4, 1)
    end
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
