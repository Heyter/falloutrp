
local menu, frame

local meta = FindMetaTable("Player")

net.Receive("withdrawItem", function()
	local type = net.ReadString()
	local inventory = net.ReadTable()
	local bank = net.ReadTable()
	
	LocalPlayer().inventory[type] = inventory
	LocalPlayer().bank[type] = bank
	
	LocalPlayer():removeVguiDelay()
	
	openBankLeft()
end)

function meta:withdrawItem(uniqueid, classid, quantity)
	self:setVguiDelay()
	
	net.Start("withdrawItem")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

net.Receive("depositItem", function()
	local type = net.ReadString()
	local inventory = net.ReadTable()
	local bank = net.ReadTable()
	
	LocalPlayer().inventory[type] = inventory
	LocalPlayer().bank[type] = bank
	
	LocalPlayer():removeVguiDelay()
	
	openBankLeft()
end)

function meta:depositItem(uniqueid, classid, quantity)
	self:setVguiDelay()
	
	net.Start("depositItem")
		net.WriteInt(uniqueid, 32)
		net.WriteInt(classid, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

net.Receive("loadBank", function()
	local bank = net.ReadTable()
	
	LocalPlayer().bank = bank
end)

local function closeBank()
	gui.EnableScreenClicker(false)

	if frame then
		frame:Remove()
		frame = nil
	end
	
	if menu then
		menu:Remove()
		menu = nil
	end
	
	// Unfreeze the player
	net.Start("openBank")
	
	net.SendToServer()
end

function openBank()
	closeBank()

	frame = vgui.Create("pepboy_frame")
	frame:SetPos(0, 0)
	frame:SetSize(ScrW(), ScrH())

	menu = vgui.Create("pepboy_bank")
	menu:SetSize(ScrW(), ScrH())
	menu:SetPos(0, 0)
	
	return menu
end

net.Receive("openBank", function()
	if frame and menu then 
		// Close the bank if it's already open
		closeBank()
	else
		openBank()
	end
end)