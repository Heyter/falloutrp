
// The VGUI below is for reusing elements that are created the same way

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