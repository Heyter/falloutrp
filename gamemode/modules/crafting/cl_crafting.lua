
local frame
local frameW, frameH = 800, 600
local childW, childH = 325, 400
local buttonW, buttonH = 80, 40
local buttonPadding = (frameW - (buttonW * 5)) / 6
local matLineDashed = Material("models/pepboy/line_y")
local textPadding = 10
local lastButton = 1
local inspect // Draws the items information on a side panel

// Make it easier to relate the id to the name
local idTypes = {"WEAPONS", "APPAREL", "AMMO", "AID", "MISC"}

net.Receive("openCrafting", function()
	openCrafting()
end)

net.Receive("craftItem", function()
	if frame then
		frame:Remove()
		frame = nil
		gui.EnableScreenClicker(false)
	end
	if inspect then
		inspect:Remove()
		inspect = nil
	end

	openCrafting()
end)

local function craftItem(type, index, quantity)
	local quantity = quantity or 1

	net.Start("craftItem")
		net.WriteInt(type, 8)
		net.WriteInt(index, 16)
		net.WriteInt(quantity, 16)
	net.SendToServer()
end

function openCrafting()
	if frame then
		frame:Remove()
		frame = nil
		gui.EnableScreenClicker(false)
		return
	end

	local currentSelectedButton
	local buttons = {}
	local openRecipe, openInfo
	local recipeFrame, infoFrame

	gui.EnableScreenClicker(true)

	frame = vgui.Create("FalloutRP_Menu")
	frame:SetSize(frameW, frameH)
	frame:SetPos(ScrW()/2 - frame:GetWide()/2, ScrH()/2 - frame:GetTall()/2)
	frame:SetFontTitle("FalloutRP3", "CRAFTING")
	frame:AddCloseButton()
	frame:MakePopup()

	// Draw the buttons at the top for all the item types
	local offsetX = 0
	for i = 1, 5 do
		local itemType = vgui.Create("DButton", frame)
		itemType:SetSize(buttonW, buttonH)
		itemType:SetPos(buttonPadding + offsetX, 50)
		itemType:SetFont("FalloutRP3")
		itemType:SetText(idTypes[i])
		itemType:SetTextColor(COLOR_AMBER)
		itemType.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)

			// The button is highlighted
			if self.hovered then
				surface.SetDrawColor(COLOR_AMBER)
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			// The button is selected
			if self.selected and (currentSelectedButton == self) then
				surface.SetDrawColor(COLOR_AMBERFADE)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(COLOR_AMBER)
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

			if currentSelectedButton then
				// Reset the old button to not be selected
				currentSelectedButton.selected = false
				currentSelectedButton:SetTextColor(COLOR_AMBER)
			end

			currentSelectedButton = self

			openRecipe(i)

			lastButton = i
		end

		// So we can call the last button we were on when reopening the menu
		table.insert(buttons, itemType)

		offsetX = offsetX + buttonW + buttonPadding
	end

	openRecipe = function(type)
		if recipeFrame then
			recipeFrame:Remove()
			recipeFrame = nil
		end
		if infoFrame then
			infoFrame:Remove()
			infoFrame = nil
		end

		recipeFrame = vgui.Create("DPanel", frame)
		recipeFrame:SetPos(buttonPadding, 125)
		recipeFrame:SetSize(childW, childH)
		recipeFrame.Paint = function(self, w, h)
		end

		local scroll = vgui.Create("DScrollPanel", recipeFrame)
		scroll:SetPos(0, 0)
		scroll:SetSize(recipeFrame:GetWide(), recipeFrame:GetTall())
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
			surface.SetDrawColor(COLOR_AMBER)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(0, 0, 3, h)
		end

		local scrollerW = scroller:GetWide()
		local layout = vgui.Create("DListLayout", scroll)
		layout:SetSize(scroll:GetWide() - 10, scroll:GetTall() - 10)
		layout:SetPos(5, 5)

		local currentItem
		for k,v in ipairs(RECIPES[type]) do
			if LocalPlayer():hasCraftingLevel(v.level) then

				local itemBox = vgui.Create("DButton")
				itemBox:SetSize(layout:GetWide() - scrollerW, 30)
				itemBox.Paint = function(self, w, h)
					surface.SetDrawColor(Color(0, 0, 0, 0))
					surface.DrawRect(0, 0, w, h)


					if self.selected and (currentItem == self) then
						surface.SetDrawColor(COLOR_AMBERFADE)
						surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)

						surface.SetDrawColor(COLOR_AMBER)
						surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
					elseif self.hovered then
						surface.SetDrawColor(Color(255, 182, 66, 30))
						surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)

						surface.SetDrawColor(COLOR_AMBER)
						surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
					end
				end
				itemBox.DoClick = function(self)
					self.selected = true
					self:SetTextColor(COLOR_BLUE)
					surface.PlaySound("pepboy/click1.wav")

					if currentItem then
						// Reset the old button to not be selected
						currentItem.selected = false
					end

					currentItem = self

					openInfo(v, type, k)
				end
				itemBox:SetText("")

				local itemLabel = vgui.Create("DLabel", itemBox)
				itemLabel:SetPos(textPadding, textPadding/2)
				itemLabel:SetFont("FalloutRP2")
				itemLabel:SetText(getItemName(v.classid))
				if util.greaterThanOne(v.quantity) then
					itemLabel:SetText(getItemName(v.classid) .."\t (" ..v.quantity ..")")
				end
				itemLabel:SizeToContents()
				if itemBox.selected then
					itemLabel:SetTextColor(COLOR_BLUE)
				else
					itemLabel:SetTextColor(COLOR_AMBER)
				end

				itemBox.OnCursorEntered = function(self)
					self.hovered = true
					surface.PlaySound("pepboy/click2.wav")
					itemLabel:SetTextColor(COLOR_BLUE)
				end
				itemBox.OnCursorExited = function(self)
					self.hovered = false

					itemLabel:SetTextColor(COLOR_AMBER)
				end

				layout:Add(itemBox)
			end
		end
	end

	// Open the last tab when reopening
	if lastButton and buttons[lastButton] then
		buttons[lastButton]:DoClick()

		openRecipe(lastButton)
	end

	openInfo = function(itemInfo, type, index)
		if infoFrame then
			infoFrame:Remove()
			infoFrame = nil
		end

		local id = itemInfo.classid
		local level = itemInfo.level
		local materials = itemInfo.materials

		infoFrame = vgui.Create("DPanel", frame)
		infoFrame:SetPos(buttonPadding + childW + (frameW - (childW*2 + buttonPadding*2)), 125)
		infoFrame:SetSize(childW, childH)
		infoFrame.Paint = function(self, w, h)
		end

		local icon = vgui.Create("SpawnIcon", infoFrame)
		icon:SetSize(128, 128)
		icon:SetPos(infoFrame:GetWide()/2 - icon:GetWide()/2, 25)
		// There is no model for apparels yet
		if !isApparel(id) then
			icon:SetModel(getItemModel(id))
		end
		icon.OnCursorEntered = function(self)
			local frameX, frameY = frame:GetPos()
			inspect = vgui.Create("FalloutRP_Item")
			inspect:SetPos(frameX + frame:GetWide(), frameY)
			inspect:SetItem(itemInfo, true)
			frame.inspect = inspect
		end
		icon.OnCursorExited = function(self)
			if inspect then
				inspect:Remove()
				inspect = nil
			end
		end

		local required = vgui.Create("DLabel", infoFrame)
		required:SetFont("FalloutRP2")
		required:SetTextColor(COLOR_AMBER)
		required:SetText("Requires:")
		required:SetPos(10, 155)
		required:SizeToContents()

		local offsetY = 0

		local craft = vgui.Create("FalloutRP_Button", infoFrame)
		craft:SetPos(infoFrame:GetWide()/2 - craft:GetWide()/2, infoFrame:GetTall() - craft:GetTall() * 1.5)
		craft:SetFont("FalloutRP1.5")
		craft:SetText("Craft")
		craft.DoClick = function(self)
			if !self:GetDisabled() then
				craftItem(type, index)
			end
		end

		local craftX
		if isStackable(itemInfo.classid) then
			craft:SetPos(infoFrame:GetWide()/2 - craft:GetWide()*1.5, infoFrame:GetTall() - craft:GetTall() * 1.5)

			craftX = vgui.Create("FalloutRP_Button", infoFrame)
			craftX:SetPos(infoFrame:GetWide()/2 + craftX:GetWide()/2, infoFrame:GetTall() - craft:GetTall() * 1.5)
			craftX:SetFont("FalloutRP1.5")
			craftX:SetText("Craft (x)")
			craftX.DoClick = function(self)
				if !self:GetDisabled() then
					local slider = vgui.Create("FalloutRP_NumberWang", frame)
					slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
					slider:SetMinimum(1)
					slider:SetMaximum(1000)
					slider:SetValue(1)
					slider:SetText("Craft")
					slider:GetButton().DoClick = function()
						if slider:ValidInput() then
							craftItem(type, index, slider:GetAmount())
						end
					end
				end
			end
		end

		for id, amount in pairs(materials) do
			local materialName = vgui.Create("DLabel", infoFrame)
			materialName:SetFont("FalloutRP1.5")
			materialName:SetTextColor(COLOR_AMBER)
			materialName:SetText(getItemName(id))
			materialName:SetPos(10, 185 + offsetY)
			materialName:SizeToContents()

			local owned, uniqueid = LocalPlayer():getInventoryCount(id)

			local materialOwned = vgui.Create("DLabel", infoFrame)
			materialOwned:SetFont("FalloutRP1.5")
			materialOwned:SetTextColor(COLOR_RED)
			materialOwned:SetText(owned .. " / " ..amount)
			materialOwned:SetPos(materialName.x + materialName:GetWide() + 10, 185 + offsetY)
			materialOwned:SizeToContents()

			// The player has enough of the required item
			if owned >= amount then
				materialOwned:SetTextColor(COLOR_LIGHTGREEN)
			else
				// The player does not have enough of the required item
				craft:SetDisabled()
				if craftX then
					craftX:SetDisabled()
				end
			end

			offsetY = offsetY + 25
		end
	end
end
