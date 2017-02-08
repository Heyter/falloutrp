
function openTitleCreation()
	
end

net.Receive("updateTitle", function()
	local ply = net.ReadEntity()
	local title = net.ReadTable()
	
	ply.title = title
end)

net.Receive("updateTitles", function()
	local titles = net.ReadTable()
	
	LocalPlayer().titles = titles
end)

net.Receive("updateTitleCreations", function()
	local creations = net.ReadInt(8)

	LocalPlayer().playerData.titlecreations = creations
end)