
net.Receive("updateNameChanges", function()
	local changes = net.ReadInt(8)

	LocalPlayer().playerData.namechanges = changes
end)