
net.Receive("addSkillPoints", function(len, ply)
	local skillPoints = net.ReadInt(8)
	local ply = net.ReadEntity()

	if plyDataExists(ply) then
		ply.playerData.skillpoints = skillPoints
	end
end)