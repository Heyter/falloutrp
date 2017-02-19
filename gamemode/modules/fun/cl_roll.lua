
net.Receive("roll", function()
	local name = net.ReadString()
	local roll = net.ReadInt(8)
	
	chat.AddText(COLOR_AMBER, name .." rolled a " ..roll)
end)