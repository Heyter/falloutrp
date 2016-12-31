
// The VGUI below is for reusing elements that are created the same way

// Menu
local offsetX, offsetY = 15, 15
local barHeight = 3
local lengthDivisor = 10
local textPadding = 5

local matLineDashed = Material("models/pepboy/line_y")
	
local VGUI = {}
function VGUI:Init()
	self.font = "FalloutRP3"
	self.title = "Loot"

	surface.SetFont(self.font)
	self.textX, self.textY = surface.GetTextSize(self.title)
	
	self:SetPos(ScrW()/2, ScrH()/2)
	self:SetSize(400, 350)
end
	
function VGUI:Paint(w, h)
	// Doubling two translucent frames creates a cooler effect
	surface.SetDrawColor(Color(0, 0, 0, 185))
	surface.DrawRect(0, 0, w, h)		
	surface.SetDrawColor(Color(0, 0, 0, 150))
	surface.DrawRect(0, 0, w, h)		
			
	/*
	surface.SetDrawColor(Color(0, 0, 0, 185))
	surface.DrawRect(offsetX, offsetY, w - offsetX*2, h - offsetY*2)
	*/
			
	surface.SetFont(self.font)
	surface.SetTextPos(offsetX + w/6 + textPadding, offsetY - (self.textY/2) + barHeight/2)
	surface.DrawText("Loot")
			
	// Top left middle bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.DrawRect(offsetX, offsetY, w/6, barHeight)		
		
	// Top right middle bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.DrawRect(offsetX + w/6 + textPadding*2 + self.textX, offsetY, w - offsetX*2 - w/6 - textPadding*2 - self.textX, barHeight)
			
	// Top left bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.SetMaterial(matLineDashed)
	surface.DrawTexturedRect(offsetX, offsetY + barHeight, barHeight, h/lengthDivisor)		
			
	// Top right bar
	surface.SetDrawColor(COLOR_AMBER)	
	surface.SetMaterial(matLineDashed)
	surface.DrawTexturedRect(w - offsetX - barHeight, offsetY + barHeight, barHeight, h/lengthDivisor)		
			
	// Bottom middle bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.DrawRect(offsetX, h - offsetY - barHeight, w - offsetX*2, barHeight)
			
	// Bottom left bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.SetMaterial(matLineDashed)
	surface.DrawTexturedRectRotated(offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)		
		
	// Bottom right bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.SetMaterial(matLineDashed)
	surface.DrawTexturedRectRotated(w - offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)
end
	
function VGUI:SetFontTitle(font, title)
	self.font = font
	self.title = title
	
	surface.SetFont(font)
	self.textX, self.textY = surface.GetTextSize(title)
end
vgui.Register("FalloutRP_Menu", VGUI, "Panel")

// DButton
local button = {}

function button:Init()
	self:SetTextColor(COLOR_AMBER)
end

function button:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, COLOR_BLACK)
end

function button:OnCursorEntered()
	self:SetTextColor(COLOR_BLUE)
	surface.PlaySound("garrysmod/ui_return.wav")
end

function button:OnCursorExited()
	self:SetTextColor(COLOR_AMBER)
end

vgui.Register("FalloutRP_Button", button, "Button")
