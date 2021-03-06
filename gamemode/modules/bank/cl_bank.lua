
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

function closeBank(unfreeze)
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
	if unfreeze then
		net.Start("closeBank")

		net.SendToServer()
	end
end

function openBank()
	frame = vgui.Create("pepboy_frame")
	frame:SetPos(0, 0)
	frame:SetSize(ScrW(), ScrH())

	menu = vgui.Create("pepboy_bank")
	menu:SetSize(ScrW(), ScrH())
	menu:SetPos(0, 0)

	LocalPlayer().bankFrame = frame
	LocalPlayer().bankMenu = menu

	return menu
end

function openBankLeft()
	closeBank()

	local pepboy = openBank()
	pepboy.buttonL.DoClick()
	pepboy.catL:makeLayout()
end

net.Receive("openBank", function()
	if (frame and frame:IsValid()) or (menu and menu:IsValid()) then
		closeBank(true)
	else
		openBank()
	end
end)
