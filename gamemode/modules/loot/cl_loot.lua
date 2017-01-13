
//Client
net.Receive("loot", function()
	local ent = net.ReadEntity()
	local loot = net.ReadTable()

	openLoot(ent, loot)
end)

local function close(frame)
	if frame then
		frame:Remove()
		util.saveMousePos()
		gui.EnableScreenClicker(false)
	end
end

function lootItem(ent, itemId, quantity)
	net.Start("lootItem")
		net.WriteEntity(ent)
		net.WriteInt(itemId, 8)
		if quantity then
			net.WriteInt(quantity, 16)
		end
	net.SendToServer()
end

local offsetX, offsetY = 25, 20
local barHeight = 3
local lengthDivisor = 10
local textPadding = 5

local matLineDashed = Material("models/pepboy/line_y")
	
function openLoot(ent, loot)
	PrintTable(loot)
	local frame = vgui.Create("FalloutRP_Menu")
	//gui.EnableScreenClicker(true)
	util.restoreMousePos()
	frame:MakePopup()
	
	local container = vgui.Create("DPanel", frame)
	local parent = container:GetParent()
	local contentStartX = offsetX + barHeight + textPadding*2
	local contentStartY = offsetY + barHeight + parent.textY/2 + textPadding
	container:SetPos(contentStartX, contentStartY)
	container:SetSize(parent:GetWide() - contentStartX*2, parent:GetTall() - contentStartY*2)
	container.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)		
	end
	
	local scroll = vgui.Create("DScrollPanel", container)
	scroll:SetPos(0, 0)
	scroll:SetSize(container:GetWide(), container:GetTall())
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
	layout:SetSize(scroll:GetWide(), scroll:GetTall())
	layout:SetPos(0, 0)
	for k,v in pairs(loot) do
		print(k)
		print(v)
		local itemBox = vgui.Create("DButton")
		itemBox:SetSize(layout:GetWide() - scrollerW, 20)
		itemBox.Paint = function(self, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 0))
			surface.DrawRect(0, 0, w, h)
			
			if self.hovered then
				surface.SetDrawColor(Color(255, 182, 66, 30))
				surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)
			
				surface.SetDrawColor(COLOR_AMBER)
				surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
			end
		end
		itemBox.DoClick = function()
			if util.positive(v.quantity) then
				lootItem(ent, k, 1)
			else
				lootItem(ent, k)
			end
			close(frame)
		end
		itemBox.DoRightClick = function()
			if util.greaterThanOne(v.quantity) then // The itme has quantity
				local flyout = vgui.Create("DMenu", frame)
				flyout:AddOption("Loot all", function()
					lootItem(ent, k, v.quantity)
					close(frame)
				end)
				flyout:AddOption("Loot (x)", function()	
					local curX, curY = itemBox:GetPos()
					
					local slider = vgui.Create("FalloutRP_NumberWang", frame)
					slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
					slider:SetMinimum(1)
					slider:SetMaximum(v.quantity)
					slider:SetValue(1)
					slider:SetText("Loot")
					slider:GetButton().DoClick = function()
						if slider:ValidInput() then
							lootItem(ent, k, slider:GetAmount())
							close(frame)
						end
					end
				end)
				
				flyout:Open()
			end
		end
		itemBox:SetText("")
		
		local itemLabel = vgui.Create("DLabel", itemBox)
		itemLabel:SetPos(textPadding, textPadding/2)
		itemLabel:SetFont("FalloutRP1")
		itemLabel:SetText(getItemNameQuantity(v.classid, v.quantity))
		itemLabel:SizeToContents()
		itemLabel:SetTextColor(COLOR_AMBER)
		
		itemBox.OnCursorEntered = function(self)
			self.hovered = true
			
			itemLabel:SetTextColor(COLOR_BLUE)
		end
		itemBox.OnCursorExited = function(self)
			self.hovered = false
			
			itemLabel:SetTextColor(COLOR_AMBER)
		end
		
		layout:Add(itemBox)
	end
end