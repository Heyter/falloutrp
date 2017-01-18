
local menu, frame

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