
function openTitleCreation()
	
end

net.Receive("updateTitleCreations", function()
	local creations = net.ReadInt(8)

	LocalPlayer().playerData.titlecreations = creations
end)