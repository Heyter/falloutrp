
net.Receive("updateVip", function()
	local vip = net.ReadInt(8)

	LocalPlayer().playerData.vip = vip
end)