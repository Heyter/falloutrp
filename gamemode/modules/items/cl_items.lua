
//Client
local meta = FindMetaTable("Player")

function meta:dropItem(uniqueid, classid, quantity)
	local itemType = classidToStringType(classid)
	self:setVguiDelay()

	net.Start("dropItem")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
		if quantity then
			net.WriteInt(quantity, 16)
		end
	net.SendToServer()
end

net.Receive("dropItem", function()
	local itemType = net.ReadString()
	local uniqueid = net.ReadInt(32)
	local quantity = net.ReadInt(16)
	
	if util.positive(quantity) then
		LocalPlayer().inventory[itemType][uniqueid].quantity = quantity
	else
		LocalPlayer().inventory[itemType][uniqueid] = nil
	end

	//Item was dropped, reenable vgui
	LocalPlayer():removeVguiDelay()
	
	openPepboyMiddle()
end)