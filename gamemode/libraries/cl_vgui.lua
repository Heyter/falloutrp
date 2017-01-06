
// The VGUI below is for reusing elements that are created the same way

// Menu
local offsetX, offsetY = 15, 15
local barHeight = 3
local lengthDivisor = 10
local textPadding = 5

local matLineDashed = Material("models/pepboy/line_y")
	
local VGUI = {}
function VGUI:Init()
	self:SetTitle("")
	self:ShowCloseButton(false)

	self.font = "FalloutRP3"
	self.title = "Loot"

	surface.SetFont(self.font)
	self.textX, self.textY = surface.GetTextSize(self.title)
	
	self:SetSize(400, 350)
	self:SetPos(ScrW()/2 - self:GetWide()/2, ScrH()/2 - self:GetTall()/2)
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
	surface.SetTextColor(COLOR_AMBER)
	surface.SetTextPos(offsetX + w/6 + textPadding, offsetY - (self.textY/2) + barHeight/2)
	surface.DrawText(self.title)
			
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
vgui.Register("FalloutRP_Menu", VGUI, "DFrame")

// Button
local VGUI = {}

function VGUI:Init()
	self:SetTextColor(COLOR_AMBER)
end

function VGUI:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, COLOR_BLACK)
end

function VGUI:OnCursorEntered()
	self:SetTextColor(COLOR_BLUE)
	surface.PlaySound("garrysmod/ui_return.wav")
end

function VGUI:OnCursorExited()
	self:SetTextColor(COLOR_AMBER)
end
vgui.Register("FalloutRP_Button", VGUI, "Button")

// Slider
local VGUI = {}
function VGUI:Init()
	self:SetSize(200, 150)
	
	self:SetFontTitle("FalloutRP1", "Select Amount")
	
	self.slider = vgui.Create("DNumberWang", self)
	self.slider:SetSize(45, 25)
	self.slider:SetPos(self:GetWide()/2 - self.slider:GetWide()/2, self:GetTall()/2 - self.slider:GetTall()/2 - 30)
	self.slider:SetMin(0)
	self.slider:SetDecimals(0) // Whole numbers only
	
	self.button = vgui.Create("FalloutRP_Button", self)
	self.button:SetText("Ok")
	self.button:SetSize(50, 30)
	self.button:SetPos(self:GetWide()/2 - self.button:GetWide()/2, self:GetTall()/2 - self.button:GetTall()/2 + 40 - 30)
end

function VGUI:GetButton()
	return self.button
end

function VGUI:GetAmount()
	return tonumber(self.slider:GetValue())
end

function VGUI:ValidInput()
	local value = self:GetAmount()
	
	return util.isInt(value) and (value >= self.slider:GetMin()) and (value <= self.slider:GetMax())
end

function VGUI:SetValue(amount)
	self.slider:SetValue(amount)
end

function VGUI:SetMinimum(amount)
	self.slider:SetMin(amount)
end

function VGUI:SetMaximum(amount)
	self.slider:SetMax(amount)
end

function VGUI:SetText(text)
	self.button:SetText(text)
end

vgui.Register("FalloutRP_NumberWang", VGUI, "FalloutRP_Menu")