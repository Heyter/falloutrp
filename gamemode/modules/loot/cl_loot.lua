
//Client
net.Receive("loot", function()
	local ent = net.ReadEntity()
	local loot = net.ReadTable()

	openLoot(ent, loot)
end)

function lootItem(ent, itemId, quantity)
	net.Start("lootItem")
		net.WriteEntity(ent)
		net.WriteInt(itemId, 8)
		if quantity then
			net.WriteInt(quantity, 8)
		end
	net.SendToServer()
end

local offsetX, offsetY = 15, 15
local barHeight = 3
local lengthDivisor = 10
local textPadding = 5

local matLineDashed = Material("models/pepboy/line_y")
	
function openLoot(ent, loot)
	local frame = vgui.Create("FalloutRP_Menu")
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
	for k,v in ipairs(loot) do
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
			frame:Remove()
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
	
	timer.Simple(5, function()
		frame:Remove()
	end)
end