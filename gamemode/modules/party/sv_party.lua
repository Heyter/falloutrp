PARTY.partyIndex = 1 // Increment this every time a new party is created

util.AddNetworkString("createParty")

net.Receive("createParty", function(len, ply)
    print(ply)
end)
