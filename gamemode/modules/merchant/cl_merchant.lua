
local frame
local frameW, frameH = 800, 600
local childW, childH = 325, 400
local buttonW, buttonH = 80, 40
local buttonPadding = (frameW - (buttonW * 5)) / 6
local canContinue = true // Don't allow players to keep trying to submit skills while validating on server still
local matLineDashed = Material("models/pepboy/line_y")
local textPadding = 10
local lastButton, lastNpc, lastType

function buyItem(npc, index, uniqueid, type, id, quantity)
	util.cleanupFrame(frame.inspect)
	surface.PlaySound("pepboy/click1.wav")
	LocalPlayer():setVguiDelay()

	local quantity = quantity or 0

	net.Start("buyItem")
		net.WriteString(npc)
		net.WriteString(type)
		net.WriteInt(id, 8)
		net.WriteInt(index, 16)
		net.WriteInt(uniqueid, 32)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

function sellItem(npc, uniqueid, type, id, quantity)
	util.cleanupFrame(frame.inspect)
	surface.PlaySound("pepboy/click1.wav")
	LocalPlayer():setVguiDelay()

	local quantity = quantity or 0

	net.Start("sellItem")
		net.WriteString(npc)
		net.WriteString(type)
		net.WriteInt(id, 8)
		net.WriteInt(uniqueid, 32)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

function openMerchant(name, items)
	gui.EnableScreenClicker(true)

	lastNpc = name

	local currentSelectedButton
	local buttons = {}
	local playerStock, npcStock
	local plyFrame, npcFrame

	frame = vgui.Create("FalloutRP_Menu")
	frame:SetSize(frameW, frameH)
	frame:SetPos(ScrW()/2 - frame:GetWide()/2, ScrH()/2 - frame:GetTall()/2)
	frame:SetFontTitle("FalloutRP3", name .."'s Shop")
	frame:AddCloseButton()
	frame.onClose = function()
		gui.EnableScreenClicker(false)
	end

	// Draw the buttons at the top for all the item types
	local offsetX = 0
	for k, info in ipairs(items) do
		local itemType = vgui.Create("DButton", frame)
		itemType:SetSize(buttonW, buttonH)
		itemType:SetPos(buttonPadding + offsetX, 50)
		itemType:SetFont("FalloutRP3")
		itemType:SetText(info["Type"])
		itemType:SetTextColor(COLOR_SLEEK_GREEN)
		itemType.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)

			// The button is highlighted
			if self.hovered then
				surface.SetDrawColor(COLOR_SLEEK_GREEN)
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			// The button is selected
			if self.selected and (currentSelectedButton == self) then
				surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(COLOR_SLEEK_GREEN)
				surface.DrawOutlinedRect(0, 0, w, h)
			end
		end
		itemType.OnCursorEntered = function(self)
			self.hovered = true
			surface.PlaySound("pepboy/click2.wav")
		end
		itemType.OnCursorExited = function(self)
			self.hovered = false
		end
		itemType.DoClick = function(self)
			self.hovered = false
			self.selected = true
			self:SetTextColor(COLOR_BLUE)
			surface.PlaySound("pepboy/click1.wav")

			// Remove the old stock panels from the previous item type page
			if plyFrame and npcFrame then
				plyFrame:Remove()
				plyFrame = nil
				npcFrame:Remove()
				npcFrame = nil
			end

			if currentSelectedButton then
				// Reset the old button to not be selected
				currentSelectedButton.selected = false
				currentSelectedButton:SetTextColor(COLOR_SLEEK_GREEN)
			end

			currentSelectedButton = self

			// Open your inventory for that item type
			playerStock(string.lower(info["Type"]), k)

			// Open npc's stock for that item type
			npcStock(string.lower(info["Type"]), k)

			lastButton = k // Keep track of the last page the player was on
			lastType = string.lower(info["Type"]) // Keep track of the last type the player was on
		end

		// So we can call the last button we were on when reopening the menu
		table.insert(buttons, itemType)

		offsetX = offsetX + buttonW + buttonPadding
	end

	playerStock = function(type, id)
		if recipeFrame then
			recipeFrame:Remove()
		end

		plyFrame = vgui.Create("DPanel", frame)
		plyFrame:SetPos(buttonPadding, 125)
		plyFrame:SetSize(childW, childH)
		plyFrame.Paint = function(self, w, h)
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local caps = vgui.Create("DLabel", frame)
		caps:SetFont("FalloutRP2")
		caps:SetTextColor(COLOR_SLEEK_GREEN)
		caps:SetText("Caps: " ..LocalPlayer():getCaps())
		caps:SizeToContents()
		caps:SetPos(buttonPadding + plyFrame:GetWide()/2 - caps:GetWide()/2, 100)

		local stockLabel = vgui.Create("DLabel", frame)
		stockLabel:SetFont("FalloutRP2")
		stockLabel:SetTextColor(COLOR_SLEEK_GREEN)
		stockLabel:SetText(LocalPlayer():getName() .."'s Stock")
		stockLabel:SizeToContents()
		stockLabel:SetPos(buttonPadding + plyFrame:GetWide()/2 - stockLabel:GetWide()/2, plyFrame:GetTall() + 140)

		local scroll = vgui.Create("DScrollPanel", plyFrame)
		scroll:SetPos(0, 0)
		scroll:SetSize(plyFrame:GetWide(), plyFrame:GetTall())
		scroll.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end

		local scroller = scroll:GetVBar()
		scroller.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnDown.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnUp.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnGrip.Paint = function(self, w, h)
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(0, 0, 3, h)
		end

		local scrollerW = scroller:GetWide()
		local layout = vgui.Create("DListLayout", scroll)
		layout:SetSize(scroll:GetWide() - 10, scroll:GetTall() - 10)
		layout:SetPos(5, 5)

		local currentItem

		for uniqueid, item in pairs(LocalPlayer().inventory[type]) do
			local itemName = getItemName(item.classid)
			if util.greaterThanOne(item.quantity) then
				itemName = itemName .." (" ..item.quantity ..")"
			end

			local itemValue = getItemValue(item.classid)

			local itemBox = vgui.Create("DButton")
			itemBox:SetSize(layout:GetWide() - scrollerW, 30)
			itemBox.Paint = function(self, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 0))
				surface.DrawRect(0, 0, w, h)


				if self.hovered then
					surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
					surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)

					surface.SetDrawColor(COLOR_SLEEK_GREEN)
					surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
				end
			end
			itemBox.DoRightClick = function(self)
				local flyout = vgui.Create("DMenu")

				if util.greaterThanOne(item.quantity) then
					flyout:AddOption("Sell all for " ..(itemValue * item.quantity), function()
						if !LocalPlayer():hasVguiDelay() then
							sellItem(name, item.uniqueid, type, id, item.quantity)
						end
					end)
					flyout:AddOption("Sell (x)", function()
						local slider = vgui.Create("FalloutRP_NumberWang", frame)
						slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
						slider:SetMinimum(1)
						slider:SetMaximum(item.quantity)
						slider:SetValue(1)
						slider:SetText("Sell")
						slider:GetButton().DoClick = function()
							if slider:ValidInput() and !LocalPlayer():hasVguiDelay() then
								sellItem(name, item.uniqueid, type, id, slider:GetAmount())
							end
						end
					end)
				else
					flyout:AddOption("Sell for " ..itemValue, function()
						if !LocalPlayer():hasVguiDelay() then
							sellItem(name, item.uniqueid, type, id, 1)
						end
					end)
				end

				flyout:Open()
			end
			itemBox:SetText("")

			local itemLabel = vgui.Create("DLabel", itemBox)
			itemLabel:SetPos(textPadding, textPadding/2)
			itemLabel:SetFont("FalloutRP2")
			itemLabel:SetText(itemName)
			itemLabel:SizeToContents()
			itemLabel:SetTextColor(COLOR_SLEEK_GREEN)

			local valueLabel = vgui.Create("DLabel", itemBox)
			valueLabel:SetFont("FalloutRP2")
			valueLabel:SetTextColor(COLOR_SLEEK_GREEN)
			valueLabel:SetText("Caps: " ..itemValue)
			valueLabel:SizeToContents()
			valueLabel:SetPos(itemBox:GetWide() - valueLabel:GetWide() - scrollerW - textPadding, textPadding/2)

			itemBox.OnCursorEntered = function(self)
				self.hovered = true
				surface.PlaySound("pepboy/click2.wav")
				itemLabel:SetTextColor(COLOR_BLUE)

				// Draw item details
				util.cleanupFrame(frame.inspect)

				local frameX, frameY = frame:GetPos()

				frame.inspect = vgui.Create("FalloutRP_Item")
				frame.inspect:SetPos(frameX - frame.inspect:GetWide(), frameY)
				frame.inspect:SetItem(item)
			end
			itemBox.OnCursorExited = function(self)
				self.hovered = false

				itemLabel:SetTextColor(COLOR_SLEEK_GREEN)

				// Remove item details
				util.cleanupFrame(frame.inspect)
			end

			layout:Add(itemBox)
		end
	end

	npcStock = function(type, id)
		util.cleanupFrame(recipeFrame)

		npcFrame = vgui.Create("DPanel", frame)
		npcFrame:SetPos(buttonPadding + childW + (frameW - (childW*2 + buttonPadding*2)), 125)
		npcFrame:SetSize(childW, childH)
		npcFrame.Paint = function(self, w, h)
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		local stockLabel = vgui.Create("DLabel", frame)
		stockLabel:SetFont("FalloutRP2")
		stockLabel:SetTextColor(COLOR_SLEEK_GREEN)
		stockLabel:SetText(name .."'s Stock")
		stockLabel:SizeToContents()
		stockLabel:SetPos(frame:GetWide() - buttonPadding - npcFrame:GetWide()/2 - stockLabel:GetWide()/2, npcFrame:GetTall() + 140)

		local scroll = vgui.Create("DScrollPanel", npcFrame)
		scroll:SetPos(0, 0)
		scroll:SetSize(npcFrame:GetWide(), npcFrame:GetTall())
		scroll.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end

		local scroller = scroll:GetVBar()
		scroller.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnDown.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnUp.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
		end
		scroller.btnGrip.Paint = function(self, w, h)
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(0, 0, 3, h)
		end

		local scrollerW = scroller:GetWide()
		local layout = vgui.Create("DListLayout", scroll)
		layout:SetSize(scroll:GetWide() - 10, scroll:GetTall() - 10)
		layout:SetPos(5, 5)

		local currentItem

		for index, item in pairs(items[id]["Items"]) do
			local itemName = getItemName(item.classid)
			if util.greaterThanOne(item.quantity) then
				itemName = itemName .." (" ..item.quantity ..")"
			end

			local itemValue = item.price or 50

			local itemBox = vgui.Create("DButton")
			itemBox:SetSize(layout:GetWide() - scrollerW, 30)
			itemBox.Paint = function(self, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 0))
				surface.DrawRect(0, 0, w, h)


				if self.hovered then
					surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
					surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)

					surface.SetDrawColor(COLOR_SLEEK_GREEN)
					surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
				end
			end
			itemBox.DoRightClick = function(self)
				local flyout = vgui.Create("DMenu")

				if util.greaterThanOne(item.quantity) then
					flyout:AddOption("Buy all for " ..(itemValue * item.quantity), function()
						if !LocalPlayer():hasVguiDelay() then
							buyItem(name, index, item.uniqueid, type, id, item.quantity)
						end
					end)
					flyout:AddOption("Buy (x)", function()
						local slider = vgui.Create("FalloutRP_NumberWang", frame)
						slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
						slider:SetMinimum(1)
						slider:SetMaximum(item.quantity)
						slider:SetValue(1)
						slider:SetText("Buy")
						slider:GetButton().DoClick = function()
							if slider:ValidInput() and !LocalPlayer():hasVguiDelay() then
								buyItem(name, index, item.uniqueid, type, id, slider:GetAmount())
							end
						end
					end)
				else
					flyout:AddOption("Buy for " ..itemValue, function()
						if !LocalPlayer():hasVguiDelay() then
							buyItem(name, index, item.uniqueid, type, id, 1)
						end
					end)
				end

				flyout:Open()
			end
			itemBox:SetText("")

			local itemLabel = vgui.Create("DLabel", itemBox)
			itemLabel:SetPos(textPadding, textPadding/2)
			itemLabel:SetFont("FalloutRP2")
			itemLabel:SetText(itemName)
			itemLabel:SizeToContents()
			itemLabel:SetTextColor(COLOR_SLEEK_GREEN)

			local valueLabel = vgui.Create("DLabel", itemBox)
			valueLabel:SetFont("FalloutRP2")
			valueLabel:SetTextColor(COLOR_SLEEK_GREEN)
			valueLabel:SetText("Caps: " ..itemValue)
			valueLabel:SizeToContents()
			valueLabel:SetPos(itemBox:GetWide() - valueLabel:GetWide() - scrollerW - textPadding, textPadding/2)

			itemBox.OnCursorEntered = function(self)
				self.hovered = true
				surface.PlaySound("pepboy/click2.wav")
				itemLabel:SetTextColor(COLOR_BLUE)

				// Draw item details
				util.cleanupFrame(frame.inspect)

				local frameX, frameY = frame:GetPos()
				frame.inspect = vgui.Create("FalloutRP_Item")
				frame.inspect:SetPos(frameX + frame:GetWide()/2 + frame.inspect:GetWide()*2, frameY)
				frame.inspect:SetItem(item)
			end
			itemBox.OnCursorExited = function(self)
				self.hovered = false

				itemLabel:SetTextColor(COLOR_SLEEK_GREEN)

				// Remove item details
				util.cleanupFrame(frame.inspect)
			end

			layout:Add(itemBox)
		end
	end

	if lastButton and lastNpc and lastType and (lastNpc == name) then
		buttons[lastButton].hovered = false
		buttons[lastButton].selected = true
		buttons[lastButton]:SetTextColor(COLOR_BLUE)
		currentSelectedButton = buttons[lastButton]

		playerStock(lastType, lastButton)
		npcStock(lastType, lastButton)
	end
end

net.Receive("openMerchant", function()
	local name = net.ReadString()
	local items = net.ReadTable()

	util.cleanupFrame(frame)

	LocalPlayer():removeVguiDelay()

	openMerchant(name, items)
end)
