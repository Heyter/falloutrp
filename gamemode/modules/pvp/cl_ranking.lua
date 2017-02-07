
net.Receive("updateKills", function()
	local ply = net.ReadEntity()
	local kills = net.ReadInt(16)
	
	ply.playerData.kills = kills
end)

net.Receive("updateRank", function()
	local ply = net.ReadEntity()
	local rank = net.ReadString()
	
	ply.playerData.rank = rank
end)