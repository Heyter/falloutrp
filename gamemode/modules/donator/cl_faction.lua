
net.Receive("updateFactionChanges", function()
	local changes = net.ReadInt(8)

	LocalPlayer().playerData.factionchanges = changes
end)