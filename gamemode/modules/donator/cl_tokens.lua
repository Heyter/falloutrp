
net.Receive("updateFactionChanges", function()
	local tokens = net.ReadInt(8)

	LocalPlayer().playerData.tokens = tokens
end)
