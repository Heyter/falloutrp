
net.Receive("addCaps", function()
	local caps = net.ReadInt(32)
	
	LocalPlayer().playerData.bottlecaps = caps
end)