
// The VGUI below is for reusing elements that are created the same way

local meta = FindMetaTable("Player")

// Delay
function meta:setVguiDelay()
	self.onVguiDelay = true
end

function meta:removeVguiDelay()
	self.onVguiDelay = false
end

function meta:hasVguiDelay()
	return self.onVguiDelay
end

// Menu
local offsetX, offsetY = 25, 20
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

	self:SetSize(500, 400)
	self:SetPos(ScrW()/2 - self:GetWide()/2, ScrH()/2 - self:GetTall()/2)
end

function VGUI:DrawBackground()
	local w, h = self:GetWide(), self:GetTall()
	// Doubling two translucent frames creates a cooler effect
	surface.SetDrawColor(COLOR_SLEEK_BLACK_FADE)
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 170))
	surface.DrawRect(0, 0, w, h)
end

function VGUI:Paint(w, h)
	self:DrawBackground()

	surface.SetFont(self.font)
	surface.SetTextColor(COLOR_SLEEK_GREEN)
	surface.SetTextPos(offsetX + w/6 + textPadding, offsetY - (self.textY/2) + barHeight/2)
	surface.DrawText(self.title)

	if !self.hideAllBars then
	// Top left middle bar
	surface.SetDrawColor(COLOR_SLEEK_GREEN)
	surface.DrawRect(offsetX, offsetY, w/6, barHeight)

	// Top right middle bar
	local titlePadding = (self.textX and self.textX > 0 and textPadding*2) or 0 // Keep a full width bar if there is no title
	surface.SetDrawColor(COLOR_SLEEK_GREEN)
	surface.DrawRect(offsetX + w/6 + titlePadding + self.textX, offsetY, w - offsetX*2 - w/6 - textPadding*2 - self.textX, barHeight)

		if !self.hideSideBars then
			// Top left bar
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(offsetX, offsetY + barHeight, barHeight, h/lengthDivisor)

			// Top right bar
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(w - offsetX - barHeight, offsetY + barHeight, barHeight, h/lengthDivisor)
		end

	// Bottom middle bar
	surface.SetDrawColor(COLOR_SLEEK_GREEN)
	surface.DrawRect(offsetX, h - offsetY - barHeight, w - offsetX*2, barHeight)

		if !self.hideSideBars then
			// Bottom left bar
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRectRotated(offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)

			// Bottom right bar
			surface.SetDrawColor(COLOR_SLEEK_GREEN)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRectRotated(w - offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)
		end
	end
end

function VGUI:HideSideBars()
	self.hideSideBars = true
end

function VGUI:HideAllBars()
	self.hideAllBars = true
end

function VGUI:SetFontTitle(font, title)
	self.font = font
	self.title = title

	surface.SetFont(font)
	self.textX, self.textY = surface.GetTextSize(title)
end

function VGUI:onClose()

end

// Add additional functionality to the default remove
function VGUI:RemoveOverride()
	if self.onClose then
		self:onClose()
	end

	if self.inspect then
		self.inspect:Remove()
		self.inspect = nil
	end

	self:Remove()
	self = nil
end

function VGUI:AddCloseButton()
	local close = vgui.Create("DButton", self)
	close:SetSize(30, 30)
	close:SetPos(self:GetWide() - close:GetWide(), 0)
	close:SetFont("FalloutRP3")
	close:SetText("X")
	close:SetTextColor(Color(255, 255, 255, 255))
	close.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 0))
		surface.DrawRect(0, 0, w, h)
	end
	close.DoClick = function()
		self:RemoveOverride(true)
	end
	close.OnCursorEntered = function(self)
		self:SetTextColor(COLOR_BLUE)
	end
	close.OnCursorExited = function(self)
		self:SetTextColor(COLOR_WHITE)
	end
end

vgui.Register("FalloutRP_Menu", VGUI, "DFrame")

// Multiple choice menu
local VGUI = {}

function VGUI:Init()
	self:SetSize(500, 300)
	self.nextY = 50
end

function VGUI:AddIntro(text)
	local intro = vgui.Create("DLabel", self)
	intro:SetFont("FalloutRP2.5")
	intro:SetText(util.textWrap(text, 450, "FalloutRP2.5"))
	intro:SetTextColor(COLOR_WHITE)
	intro:SetPos(25, self.nextY)
	intro:SizeToContents()

	self.nextY = self.nextY + intro:GetTall() + 10
end

function VGUI:AddButton(text, func)
	local button = vgui.Create("FalloutRP_Button", self)
	button:SetText(text)
	button:SetFont("FalloutRP2")
	button:SetSize(self:GetWide() - 50, 40)
	button:SetPos(25, self.nextY)
	button.DoClick = func

	self.nextY = self.nextY + button:GetTall() + 10
end

vgui.Register("FalloutRP_Multiple_Choice", VGUI, "FalloutRP_Menu")

// Scroll List Menu
local VGUI = {}

function VGUI:Init()

end

function VGUI:CreateScroll()
	local container = vgui.Create("DPanel", self)
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
		surface.SetDrawColor(COLOR_SLEEK_GREEN)
		surface.SetMaterial(matLineDashed)
		surface.DrawTexturedRect(0, 0, 3, h)
	end

	local scrollerW = scroller:GetWide()
	local layout = vgui.Create("DListLayout", scroll)
	layout:SetSize(scroll:GetWide(), scroll:GetTall())
	layout:SetPos(0, 0)

	self.container = container
	self.scroll = scroll
	self.scroller = scroller
	self.layout = layout
end

vgui.Register("FalloutRP_Scroll_List", VGUI, "FalloutRP_Menu")

// Item draw
local VGUI = {}

function VGUI:Init()
	local width, height = 200, 400
	self:SetSize(width, height)

	self.name = vgui.Create("DLabel", self)
	self.name:SetPos(10, 10)
	self.name:SetFont("FalloutRP2")
	self.name:SetText("")
	self.name:SetTextColor(COLOR_SLEEK_GREEN)

	self.model = vgui.Create("SpawnIcon", self)
	self.model:SetSize(80, 80)
	self.model:SetPos(width/2 - self.model:GetWide()/2, 50)
end

function VGUI:Paint(w, h)
	surface.SetDrawColor(COLOR_SLEEK_BLACK_FADE)
	surface.DrawRect(0, 0, w, h)
end

function VGUI:SetItem(item, craftingCreated, questCreated)
	local classid = item.classid
	local itemMeta = findItem(classid)

	local name = itemMeta:getName()
	local model = itemMeta:getModel()

	// Name
	self.name:SetText(name)
	self.name:SetTextColor(getRarityColor(itemMeta:getRarity()))
	self.name:SizeToContents()
	self.name:SetPos(self:GetWide()/2 - self.name:GetWide()/2, 10)

	// Model
	// Don't draw apparel model because there are none yet
	if !isApparel(classid) then
		self.model:SetModel(model)
	end

	// Item Specs
	local startY = 140

	if isWeapon(classid) then
		// Draw different values depending if the item is created already or not
		local dmg
		if craftingCreated then
			dmg = "Damage: (" ..itemMeta:getMinDamage() .."-" ..itemMeta:getMedianDamage() ..")"
		elseif questCreated then
			dmg = "Damage: (" ..itemMeta:getMedianDamage() .."-" ..itemMeta:getMaxDamage() ..")"
		else
			dmg = "Damage: " ..item.damage
		end

		// Damage
		local damage = vgui.Create("DLabel", self)
		damage:SetPos(10, startY)
		damage:SetFont("FalloutRP2")
		damage:SetTextColor(COLOR_SLEEK_GREEN)
		damage:SetText(dmg)
		damage:SizeToContents()
		startY = startY + 20

		// Crit Chance
		local crit = vgui.Create("DLabel", self)
		crit:SetPos(10, startY)
		crit:SetFont("FalloutRP2")
		crit:SetTextColor(COLOR_SLEEK_GREEN)
		crit:SetText("Crit Chance: " ..itemMeta:getCriticalChance() .."%")
		crit:SizeToContents()
		startY = startY + 20
	end

	if isApparel(classid) then
		// Draw different values depending if the item is created already or not
		local dt, dr, hp
		if craftingCreated then
			dt = "Dmg Threshold: (" ..itemMeta:getMinDamageThreshold() .."-" ..itemMeta:getMedianDamageThreshold() .."%)"
			dr = "Dmg Reflect: (" ..itemMeta:getMinDamageReflection() .."-" ..itemMeta:getMedianDamageReflection() .."%)"
			hp = "Bonus HP: (" ..itemMeta:getMinBonusHp() .."-" ..itemMeta:getMedianBonusHp() .."%)"
		elseif questCreated then
			dt = "Dmg Threshold: (" ..itemMeta:getMedianDamageThreshold() .."-" ..itemMeta:getMaxDamageThreshold() .."%)"
			dr = "Dmg Reflect: (" ..itemMeta:getMedianDamageReflection() .."-" ..itemMeta:getMaxDamageReflection() .."%)"
			hp = "Bonus HP: (" ..itemMeta:getMedianBonusHp() .."-" ..itemMeta:getMaxBonusHp() .."%)"
		else
			dt = "Dmg Threshold: " ..item.damageThreshold .."%"
			dr = "Dmg Reflect: " ..item.damageReflection .."%"
			hp = "Bonus HP: " ..item.bonusHp
		end

		// Damage Threshold
		local damageThresh = vgui.Create("DLabel", self)
		damageThresh:SetPos(10, startY)
		damageThresh:SetFont("FalloutRP2")
		damageThresh:SetTextColor(COLOR_SLEEK_GREEN)
		damageThresh:SetText(dt)
		damageThresh:SizeToContents()
		startY = startY + 20

		// Damage Reflection
		local damageReflect = vgui.Create("DLabel", self)
		damageReflect:SetPos(10, startY)
		damageReflect:SetFont("FalloutRP2")
		damageReflect:SetTextColor(COLOR_SLEEK_GREEN)
		damageReflect:SetText(dr)
		damageReflect:SizeToContents()
		startY = startY + 20

		// Bonus HP
		local bonushp = vgui.Create("DLabel", self)
		bonushp:SetPos(10, startY)
		bonushp:SetFont("FalloutRP2")
		bonushp:SetTextColor(COLOR_SLEEK_GREEN)
		bonushp:SetText(hp)
		bonushp:SizeToContents()
		startY = startY + 20
	end

	if isAid(classid) then
		// Health Percent
		if itemMeta:getHealthPercent() then
			local healthPercent = vgui.Create("DLabel", self)
			healthPercent:SetPos(10, startY)
			healthPercent:SetFont("FalloutRP2")
			healthPercent:SetTextColor(COLOR_SLEEK_GREEN)
			healthPercent:SetText("Restores " ..itemMeta:getHealthPercent() .."% HP")
			healthPercent:SizeToContents()
			startY = startY + 20
		end

		// Health
		if itemMeta:getHealth() then
			local health = vgui.Create("DLabel", self)
			health:SetPos(10, startY)
			health:SetFont("FalloutRP2")
			health:SetTextColor(COLOR_SLEEK_GREEN)
			health:SetText("Restores " ..itemMeta:getHealth() .." HP")
			health:SizeToContents()
			startY = startY + 20
		end

		// Health Over Time
		if itemMeta:getHealthOverTime() then
			local hot = vgui.Create("DLabel", self)
			hot:SetPos(10, startY)
			hot:SetFont("FalloutRP2")
			hot:SetTextColor(COLOR_SLEEK_GREEN)
			hot:SetText("Restores " ..itemMeta:getHealthOverTime())
			hot:SizeToContents()
			startY = startY + 20
		end

		// Hunger
		if itemMeta:getHunger() then
			local hunger = vgui.Create("DLabel", self)
			hunger:SetPos(10, startY)
			hunger:SetFont("FalloutRP2")
			hunger:SetTextColor(COLOR_SLEEK_GREEN)
			hunger:SetText("Restores " ..itemMeta:getHunger() .." Hunger")
			hunger:SizeToContents()
			startY = startY + 20
		end

		// Thirst
		if itemMeta:getThirst() then
			local thirst = vgui.Create("DLabel", self)
			thirst:SetPos(10, startY)
			thirst:SetFont("FalloutRP2")
			thirst:SetTextColor(COLOR_SLEEK_GREEN)
			thirst:SetText("Restores " ..itemMeta:getThirst() .." Thirst")
			thirst:SizeToContents()
			startY = startY + 20
		end
	end

	// Level
	if itemMeta:getLevel() then
		local level = vgui.Create("DLabel", self)
		level:SetPos(10, startY)
		level:SetFont("FalloutRP2")
		level:SetTextColor(COLOR_SLEEK_GREEN)
		level:SetText("Level: " ..itemMeta:getLevel())
		level:SizeToContents()
		startY = startY + 20
	end

	// Durability
	if item.durability then
		local durability = vgui.Create("DLabel", self)
		durability:SetPos(10, startY)
		durability:SetFont("FalloutRP2")
		durability:SetTextColor(COLOR_SLEEK_GREEN)
		durability:SetText("Durability: " ..item.durability)
		durability:SizeToContents()
		startY = startY + 20
	end

	// Weight
	local weight = vgui.Create("DLabel", self)
	weight:SetPos(10, startY)
	weight:SetFont("FalloutRP2")
	weight:SetTextColor(COLOR_SLEEK_GREEN)
	weight:SetText("Weight: " ..itemMeta:getWeight())
	weight:SizeToContents()
	startY = startY + 20

	// Value
	local value = vgui.Create("DLabel", self)
	value:SetPos(10, startY)
	value:SetFont("FalloutRP2")
	value:SetTextColor(COLOR_SLEEK_GREEN)
	value:SetText("Value: " ..itemMeta:getValue())
	value:SizeToContents()
	startY = startY + 20
end

vgui.Register("FalloutRP_Item", VGUI, "DPanel")

// Button
local VGUI = {}

function VGUI:Init()
	self:SetTextColor(COLOR_SLEEK_GREEN)
end

function VGUI:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, COLOR_SLEEK_BLACK)

	if self:GetDisabled() then
		self:SetTextColor(COLOR_GRAY)
	end
end

function VGUI:SetDisabled()
	self.disabled = true
	self:SetTextColor(COLOR_GRAY)
end

function VGUI:SetEnabled()
	self.disabled = false
	self:SetTextColor(COLOR_SLEEK_GREEN)
end

function VGUI:GetDisabled()
	return self.disabled
end

function VGUI:OnCursorEntered()
	if !self:GetDisabled() then
		self:SetTextColor(COLOR_BLUE)
	end
	surface.PlaySound("garrysmod/ui_return.wav")
end

function VGUI:OnCursorExited()
	self:SetTextColor(COLOR_SLEEK_GREEN)
end
vgui.Register("FalloutRP_Button", VGUI, "Button")

// Slider
local VGUI = {}
function VGUI:Init()
	self:SetSize(200, 150)

	self:HideSideBars()
	self:AddCloseButton()

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
