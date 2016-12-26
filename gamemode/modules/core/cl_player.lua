
net.Receive("loadPlayerData", function()
	local data = net.ReadTable()
	local ply = net.ReadEntity()
	
	if ply then
		ply.playerData = data
	end
end)