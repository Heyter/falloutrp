
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

net.Receive("loadClientside", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()
	local experience = net.ReadInt(32)
	local strength = net.ReadInt(8)
	local equipped = net.ReadTable()
	
	
	ply.playerData = ply.playerData or {}
	ply.playerData.name = name
	ply.playerData.experience = experience
	ply.playerData.strength = strength
	ply.equipped = equipped
end)