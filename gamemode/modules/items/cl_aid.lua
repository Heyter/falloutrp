
net.Receive("useAid", function()
	local uniqueid = net.ReadInt(32)
	local quantity = net.ReadInt(16)

	if quantity == LocalPlayer().inventory.aid[uniqueid]["quantity"] then
		LocalPlayer().inventory.aid[uniqueid] = nil
	else
		LocalPlayer().inventory.aid[uniqueid]["quantity"] = LocalPlayer().inventory.aid[uniqueid]["quantity"] - quantity
	end

	openPepboyMiddle()
end)
