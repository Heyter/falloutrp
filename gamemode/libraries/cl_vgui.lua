
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
		
		if !self.hideSideBars then
			// Top left bar
			surface.SetDrawColor(COLOR_AMBER)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(offsetX, offsetY + barHeight, barHeight, h/lengthDivisor)		
					
			// Top right bar
			surface.SetDrawColor(COLOR_AMBER)	
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRect(w - offsetX - barHeight, offsetY + barHeight, barHeight, h/lengthDivisor)		
		end
				
	// Bottom middle bar
	surface.SetDrawColor(COLOR_AMBER)
	surface.DrawRect(offsetX, h - offsetY - barHeight, w - offsetX*2, barHeight)
			
		if !self.hideSideBars then
			// Bottom left bar
			surface.SetDrawColor(COLOR_AMBER)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRectRotated(offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)		
			
			// Bottom right bar
			surface.SetDrawColor(COLOR_AMBER)
			surface.SetMaterial(matLineDashed)
			surface.DrawTexturedRectRotated(w - offsetX, h - h/lengthDivisor - barHeight, barHeight, h/lengthDivisor, 180)
		end
end
	
function VGUI:HideSideBars()
	self.hideSideBars = true
end	
	
function VGUI:SetFontTitle(font, title)
	self.font = font
	self.title = title
	
	surface.SetFont(font)
	self.textX, self.textY = surface.GetTextSize(title)
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
		gui.EnableScreenClicker(false)
		self:Remove()
	end
	close.OnCursorEntered = function(self)
		self:SetTextColor(COLOR_BLUE)
	end
	close.OnCursorExited = function(self)
		self:SetTextColor(COLOR_WHITE)
	end
end

vgui.Register("FalloutRP_Menu", VGUI, "DFrame")

// Item draw
local VGUI = {}

function VGUI:Init()
	local width, height = 200, 400
	self:SetSize(width, height)
	
	self.name = vgui.Create("DLabel", self)
	self.name:SetPos(10, 10)
	self.name:SetFont("FalloutRP2")
	self.name:SetText("")
	self.name:SetTextColor(COLOR_AMBER)
	
	self.model = vgui.Create("SpawnIcon", self)
	self.model:SetSize(80, 80)
	self.model:SetPos(width/2 - self.model:GetWide()/2, 50)
end

function VGUI:Paint(w, h)
	surface.SetDrawColor(COLOR_BLACKFADE)
	surface.DrawRect(0, 0, w, h)
	
	surface.SetDrawColor(COLOR_GRAY)
	surface.DrawOutlinedRect(0, 0, w, h)
end

function VGUI:SetItem(item)
	local classid = item.classid

	local name = getItemName(classid)
	local model = getItemModel(classid)
	
	// Name
	self.name:SetText(name)
	self.name:SizeToContents()
	self.name:SetPos(self:GetWide()/2 - self.name:GetWide()/2, 10)
	
	// Model
	self.model:SetModel(model)
	
	// Item Specs
	
	local startY = 125
	
	// Damage
	if item.damage then
		local damage = vgui.Create("DLabel", self)
		damage:SetPos(10, startY)
		damage:SetFont("FalloutRP2")
		damage:SetTextColor(COLOR_AMBER)
		damage:SetText("Damage: " ..item.damage)
		damage:SizeToContents()
		startY = startY + 20
	end
	
	// Crit Chance
	if isWeapon(classid) then
		local crit = vgui.Create("DLabel", self)
		crit:SetPos(10, startY)
		crit:SetFont("FalloutRP2")
		crit:SetTextColor(COLOR_AMBER)
		crit:SetText("Crit Chance: " ..getWeaponCriticalChance(classid) .."%")
		crit:SizeToContents()
		startY = startY + 20
	end
	
	if isApparel(classid) then
		// Damage Threshold
		local damageThresh = vgui.Create("DLabel", self)
		damageThresh:SetPos(10, startY)
		damageThresh:SetFont("FalloutRP2")
		damageThresh:SetTextColor(COLOR_AMBER)
		damageThresh:SetText("Dmg Threshold: " ..item.damageThreshold .."%")
		damageThresh:SizeToContents()
		startY = startY + 20
		
		// Damage Reflection
		local damageReflect = vgui.Create("DLabel", self)
		damageReflect:SetPos(10, startY)
		damageReflect:SetFont("FalloutRP2")
		damageReflect:SetTextColor(COLOR_AMBER)
		damageReflect:SetText("Dmg Reflect: " ..item.damageReflection .."%")
		damageReflect:SizeToContents()
		startY = startY + 20
		
		// Bonus HP
		local bonushp = vgui.Create("DLabel", self)
		bonushp:SetPos(10, startY)
		bonushp:SetFont("FalloutRP2")
		bonushp:SetTextColor(COLOR_AMBER)
		bonushp:SetText("Bonus HP: " ..item.bonusHp)
		bonushp:SizeToContents()
		startY = startY + 20
	end
	
	if isAid(classid) then
		// Health Percent
		if getAidHealthPercent(classid) then
			local healthPercent = vgui.Create("DLabel", self)
			healthPercent:SetPos(10, startY)
			healthPercent:SetFont("FalloutRP2")
			healthPercent:SetTextColor(COLOR_AMBER)
			healthPercent:SetText("Restores " ..getAidHealthPercent(classid) .."% HP")
			healthPercent:SizeToContents()
			startY = startY + 20
		end
		
		// Health
		if getAidHealth(classid) then
			local health = vgui.Create("DLabel", self)
			health:SetPos(10, startY)
			health:SetFont("FalloutRP2")
			health:SetTextColor(COLOR_AMBER)
			health:SetText("Restores " ..getAidHealth(classid) .." HP")
			health:SizeToContents()
			startY = startY + 20
		end
		
		// Health Over Time
		if getAidHealthOverTime(classid) then
			local hot = vgui.Create("DLabel", self)
			hot:SetPos(10, startY)
			hot:SetFont("FalloutRP2")
			hot:SetTextColor(COLOR_AMBER)
			hot:SetText("Restores " ..getAidHealthOverTime(classid))
			hot:SizeToContents()
			startY = startY + 20
		end
		
		// Hunger
		if getAidHunger(classid) then
			local hunger = vgui.Create("DLabel", self)
			hunger:SetPos(10, startY)
			hunger:SetFont("FalloutRP2")
			hunger:SetTextColor(COLOR_AMBER)
			hunger:SetText("Restores " ..getAidHunger(classid) .." Hunger")
			hunger:SizeToContents()
			startY = startY + 20
		end
		
		// Thirst
		if getAidThirst(classid) then
			local thirst = vgui.Create("DLabel", self)
			thirst:SetPos(10, startY)
			thirst:SetFont("FalloutRP2")
			thirst:SetTextColor(COLOR_AMBER)
			thirst:SetText("Restores " ..getAidThirst(classid) .." Thirst")
			thirst:SizeToContents()
			startY = startY + 20
		end
	end
	
	// Level
	if getItemLevel(classid) then
		local level = vgui.Create("DLabel", self)
		level:SetPos(10, startY)
		level:SetFont("FalloutRP2")
		level:SetTextColor(COLOR_AMBER)
		level:SetText("Level: " ..getItemLevel(classid))
		level:SizeToContents()
		startY = startY + 20
	end
	
	// Durability
	if item.durability then
		local durability = vgui.Create("DLabel", self)
		durability:SetPos(10, startY)
		durability:SetFont("FalloutRP2")
		durability:SetTextColor(COLOR_AMBER)
		durability:SetText("Durability: " ..item.durability)
		durability:SizeToContents()
		startY = startY + 20
	end
	
	// Weight
	local weight = vgui.Create("DLabel", self)
	weight:SetPos(10, startY)
	weight:SetFont("FalloutRP2")
	weight:SetTextColor(COLOR_AMBER)
	weight:SetText("Weight: " ..getItemWeight(classid))
	weight:SizeToContents()
	startY = startY + 20
	
	// Value
	local value = vgui.Create("DLabel", self)
	value:SetPos(10, startY)
	value:SetFont("FalloutRP2")
	value:SetTextColor(COLOR_AMBER)
	value:SetText("Value: " ..getItemValue(classid))
	value:SizeToContents()
	startY = startY + 20
end

vgui.Register("FalloutRP_Item", VGUI, "DPanel")

// Button
local VGUI = {}

function VGUI:Init()
	self:SetTextColor(COLOR_AMBER)
end

function VGUI:Paint(w, h)
	draw.RoundedBox(0, 0, 0, w, h, COLOR_BLACK)
	
	if self:GetDisabled() then
		self:SetTextColor(COLOR_GRAY)
	end
end

function VGUI:OnCursorEntered()
	if !self:GetDisabled() then
		self:SetTextColor(COLOR_BLUE)
	end
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