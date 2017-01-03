
local meta = FindMetaTable("Player")

function meta:getName()
	return self.playerData.name or LocalPlayer():Name()
end

net.Receive("loadPlayerData", function()
	local data = net.ReadTable()
	local ply = net.ReadEntity()

	if ply then
		ply.playerData = data
	end
end)