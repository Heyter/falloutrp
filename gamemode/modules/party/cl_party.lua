
local meta = FindMetaTable("Player")

net.Receive("updateParty", function()
    local hasParty = net.ReadBool()
    local party

    if hasParty then
        party = net.ReadTable()
        LocalPlayer().party = party
    else
        LocalPlayer().party = nil
    end
end)

function meta:kickParty(member)
    net.Start("kickParty")
        net.WriteEntity(member)
    net.SendToServer()
end
