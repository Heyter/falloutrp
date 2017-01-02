
net.Receive("addCaps", function()
	local caps = net.ReadInt(8)
	
	LocalPlayer().playerData.bottlecaps = caps
end)