
local menu, frame

local meta = FindMetaTable("Player")

function meta:depositItem(uniqueid, classid, quantity)
	self:setVguiDelay()
	
	net.Start("depositItem")
		net.WriteInt("uniqueid", 32)
		net.WriteInt(classid, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

net.Receive("loadBank", function()
	local bank = net.ReadTable()
	
	LocalPlayer().bank = bank
end)

function openBank()
	frame = vgui.Create("pepboy_frame")
	frame:SetPos(0, 0)
	frame:SetSize(ScrW(), ScrH())

	menu = vgui.Create("pepboy_bank")
	menu:SetSize(ScrW(), ScrH())
	menu:SetPos(0, 0)

	timer.Simple(5, function()
		if menu then
			gui.EnableScreenClicker(false)
			frame:Remove()
			menu:Remove()
		end
	end)
end