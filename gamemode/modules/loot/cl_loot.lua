local offsetX, offsetY = 25, 20
local barHeight = 3
local lengthDivisor = 10
local textPadding = 10

local matLineDashed = Material("models/pepboy/line_y")

net.Receive("loot", function()
	local ent = net.ReadEntity()
	local loot = net.ReadTable()

	openLoot(ent, loot)

	LocalPlayer():removeVguiDelay()
end)

function lootItem(ent, itemId, quantity)
	surface.PlaySound("pepboy/click1.wav")
	LocalPlayer():setVguiDelay()

	local quantity = quantity or 0

	net.Start("lootItem")
		net.WriteEntity(ent)
		net.WriteInt(itemId, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

function openLoot(ent, loot)
	local frame = vgui.Create("FalloutRP_Scroll_List")
	frame:CreateScroll()
	util.restoreMousePos() // So they can *spam click* loot and not always have to move their mouse back to that loot
	frame:AddCloseButton()
	frame:MakePopup()
	frame.onClose = function()
		gui.EnableScreenClicker(false)
		util.saveMousePos()
	end

	local layout = frame.layout
	local scrollerW = frame.scroller:GetWide()

	for k,v in pairs(loot) do
		local itemBox = vgui.Create("DButton")
		itemBox:SetSize(layout:GetWide() - scrollerW, 30)
		itemBox.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)

			if self.hovered then
				surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(COLOR_SLEEK_GREEN)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		itemBox.DoClick = function()
			surface.PlaySound("pepboy/click1.wav")
			if util.positive(v.quantity) then
				lootItem(ent, k, 1)
			else
				lootItem(ent, k)
			end
			frame:RemoveOverride()
		end
		itemBox.DoRightClick = function()
			if util.greaterThanOne(v.quantity) then // The itme has quantity
				surface.PlaySound("pepboy/click1.wav")

				local flyout = vgui.Create("DMenu", frame)
				flyout:AddOption("Loot all", function()
					if !LocalPlayer():hasVguiDelay() then
						lootItem(ent, k, v.quantity)
						frame:RemoveOverride()
					end
				end)
				flyout:AddOption("Loot (x)", function()
					local slider = vgui.Create("FalloutRP_NumberWang", frame)
					slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
					slider:SetMinimum(1)
					slider:SetMaximum(v.quantity)
					slider:SetValue(1)
					slider:SetText("Loot")
					slider:GetButton().DoClick = function()
						if slider:ValidInput() and !LocalPlayer():hasVguiDelay() then
							lootItem(ent, k, slider:GetAmount())
							frame:RemoveOverride()
						end
					end
				end)

				flyout:Open()
			end
		end
		itemBox:SetText("")

		local itemLabel = vgui.Create("DLabel", itemBox)
		itemLabel:SetPos(textPadding, textPadding/2)
		itemLabel:SetFont("FalloutRP2")
		itemLabel:SetText(getItemNameQuantity(v.classid, v.quantity))
		itemLabel:SizeToContents()
		itemLabel:SetTextColor(COLOR_SLEEK_GREEN)

		itemBox.OnCursorEntered = function(self)
			util.cleanupFrame(frame.inspect)

			self.hovered = true
			surface.PlaySound("pepboy/click2.wav")

			itemLabel:SetTextColor(COLOR_BLUE)

			if !isCap(v.classid) then
				local frameX, frameY = frame:GetPos()
				frame.inspect = vgui.Create("FalloutRP_Item")
				frame.inspect:SetPos(frameX + frame:GetWide(), frameY)
				frame.inspect:SetItem(v)
			end
		end
		itemBox.OnCursorExited = function(self)
			util.cleanupFrame(frame.inspect)

			self.hovered = false

			itemLabel:SetTextColor(COLOR_SLEEK_GREEN)
		end

		layout:Add(itemBox)
	end
end
