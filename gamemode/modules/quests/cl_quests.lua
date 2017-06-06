
net.Receive("loadQuests", function()
    local quests = net.ReadTable()

    LocalPlayer().quests = quests

    LocalPlayer():loadPlayerDataCount()
end)
