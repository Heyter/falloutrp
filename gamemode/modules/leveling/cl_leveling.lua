
print("Leveling")

net.Receive("addExperience", function(len, ply)
	local exp = net.ReadInt(8)
	local ply = net.ReadEntity()

	if plyDataExists(ply) then
		ply.playerData["experience"] = exp
	end
end)