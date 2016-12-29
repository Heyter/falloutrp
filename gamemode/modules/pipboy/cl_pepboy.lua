
local meta = FindMetaTable("Player")

function meta:setVguiDelay()
	self.onVguiDelay = true
end

function meta:removeVguiDelay()
	self.onVguiDelay = false
end

function meta:hasVguiDelay()
	return self.onVguiDelay
end

local scrW = ScrW 
local scrH = ScrH

-- MINIMUM RESOLUTION = 1024 x 660
local localplayer = LocalPlayer

local PEPBOY_COLOR = Color( 34, 254, 140, 150 )
local PEPBOY_COLOR_DISABLED = Color( 34, 254, 140, 30 )

local PEPBOY_SIZE_X = 768
local PEPBOY_SIZE_Y = 626

local PEPBOY_WRAPPER_SIZE_TOP = 66

local PEPBOY_CONTENT_SIZE_X = PEPBOY_SIZE_X
local PEPBOY_CONTENT_SIZE_Y = PEPBOY_SIZE_Y - 2 * PEPBOY_WRAPPER_SIZE_TOP - 14

local PEPBOY_CLOSE_KEY = KEY_TAB

local PEPBOY_PADDING = 10

local matFrame = Material( "models/pepboy/pepboy_frame.png" )
local matLine = Material( "models/pepboy/line_x" )
local matLineDashed = Material( "models/pepboy/line_y" )
local matGlow = Material( "models/pepboy/glow" )
local matBlur = Material( "pp/blurscreen" )
local matShipment = Material( "models/pepboy/item_icon_shipment" )
local matMachine = Material( "models/pepboy/item_icon_machine" )

local WEAPON_ICONS = {

	["Pistols"] = Material( "models/pepboy/item_icon_pistol" ),
	["Rifles"] = Material( "models/pepboy/item_icon_rifle" ),
	["Shotguns"] = Material( "models/pepboy/item_icon_shotgun" ),
	["Snipers"] = Material( "models/pepboy/item_icon_sniper" ),
	["Other"] = Material( "models/pepboy/item_icon_other_weapon" )

}

local AMMO_ICONS = {

	["pistol"] = Material( "models/pepboy/item_icon_pistol_ammo" ),
	["smg1"] = Material( "models/pepboy/item_icon_rifle_ammo" ),
	["buckshot"] = Material( "models/pepboy/item_icon_shotgun_ammo" )

}

if file.Exists( "pepboy/settings.txt", "DATA" ) then
	
	local colStr = file.Read( "pepboy/settings.txt" )
	local colT = string.Explode( ";", colStr )

	PEPBOY_COLOR = Color( math.Clamp( tonumber( colT[1] ), 0, 255 ), math.Clamp( tonumber( colT[2] ), 0, 255 ), math.Clamp( tonumber( colT[3] ), 0, 255 ), math.Clamp( tonumber( colT[4] ), 30, 255 ) )
	PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4 )
	
else
	
	file.CreateDir( "pepboy" )
	file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )

end

local function close()
	
	gui.EnableScreenClicker( false )

	net.Start( "pepboy_close" )
	net.SendToServer()
	
	localplayer().pepboy_vgui:Remove()
	localplayer().pepboy_vgui = nil

	localplayer().pepboy_frame:Remove()
	localplayer().pepboy_frame = nil

end

net.Receive("pepboy_died", function()
	
	if localplayer().pepboy_vgui then
		close()
	end
	
end)

local function round( n )

	return math.floor( n + 0.5 )

end

surface.CreateFont( "pepboy_20", {
	font = "Monofonto",
	size = 22,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "pepboy_22", {
	font = "Monofonto",
	size = 22,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "pepboy_27", {
	font = "Monofonto",
	size = 27,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "pepboy_32", {
	font = "Monofonto",
	size = 32,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "pepboy_40", {
	font = "Monofonto",
	size = 40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "pepboy_50", {
	font = "Monofonto",
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

net.Receive( "pepboy_open", function()
	
	local bit = net.ReadBit()
	
	if localplayer().pepboy_vgui or localplayer().pepboy_frame then
		
		close()
		return
		
	end	

	localplayer().pepboy_frame = vgui.Create( "pepboy_frame" )
	localplayer().pepboy_frame:SetPos( 0, 0 )
	localplayer().pepboy_frame:SetSize( ScrW(), ScrH() )

	localplayer().pepboy_vgui = vgui.Create( "pepboy_main" )
	localplayer().pepboy_vgui:SetPos( 0, 0 )
	localplayer().pepboy_vgui:SetSize( ScrW(), ScrH() )

	if bit == 1 then

		localplayer().pepboy_vgui.buttonM.DoClick()

	else

		localplayer().pepboy_vgui.buttonL.DoClick()

	end
	
end)

local VGUI = {}
function VGUI:Init()
	
	self.screen = vgui.Create( "pepboy_screen", self )
	self.screen:SetPos( scrW()/2 - PEPBOY_SIZE_X/2, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 )
	self.screen:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	
	if scrH() > 800 then
		self.buttonL = vgui.Create( "pepboy_catbutton", self )
		self.buttonL:SetPos( scrW()/2 - 1920 * 0.09 + 2, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 + 696 )
		self.buttonL:SetSize( 90, 90 )
		self.buttonL.active = true
		self.buttonL.DoClick = function()
		
			self.buttonL.active = true
			self.buttonM.active = false
			self.buttonR.active = false
			
			if self.catL then self.catL:Show() end
			if self.catM then self.catM:Hide() end
			if self.catR then self.catR:Hide() end
			
			surface.PlaySound( "pepboy/click3.wav" )
		
		end
		self.buttonL:SetText("")
		
		self.buttonM = vgui.Create( "pepboy_catbutton", self )
		self.buttonM:SetPos( scrW()/2 - 90/2 + 4, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 + 696 )
		self.buttonM:SetSize( 90, 90 )
		self.buttonM.DoClick = function()
			
			self.buttonL.active = false
			self.buttonM.active = true
			self.buttonR.active = false
			
			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Show() end
			if self.catR then self.catR:Hide() end

			surface.PlaySound( "pepboy/click3.wav" )
			
		end
		self.buttonM:SetText("")
		
		self.buttonR = vgui.Create( "pepboy_catbutton", self )
		self.buttonR:SetPos( scrW()/2 + 1920 * 0.09 - 90 + 8, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 + 696 )
		self.buttonR:SetSize( 90, 90 )
		self.buttonR.DoClick = function()
		
			self.buttonL.active = false
			self.buttonM.active = false
			self.buttonR.active = true
			
			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Hide() end
			if self.catR then self.catR:Show() end
			
			surface.PlaySound( "pepboy/click3.wav" )
			
		end
		self.buttonR:SetText("")

	else

		self.buttonL = vgui.Create( "pepboy_catbutton_text", self )
		self.buttonL:SetPos( scrW()/2 - 75 - 150, scrH()/2 + PEPBOY_SIZE_Y/2 - 10 )
		self.buttonL:SetSize( 150, 50 )
		self.buttonL.label = "DATA"
		self.buttonL.DoClick = function()
		
			self.buttonL.active = true
			self.buttonM.active = false
			self.buttonR.active = false
			
			if self.catL then self.catL:Show() end
			if self.catM then self.catM:Hide() end
			if self.catR then self.catR:Hide() end
			
			surface.PlaySound( "pepboy/click3.wav" )
		
		end

		self.buttonM = vgui.Create( "pepboy_catbutton_text", self )
		self.buttonM:SetPos( scrW()/2 - 150 + 75, scrH()/2 + PEPBOY_SIZE_Y/2 - 10 )
		self.buttonM:SetSize( 150, 50 )
		self.buttonM.label = "ITEMS"
		self.buttonM.DoClick = function()
		
			self.buttonL.active = false
			self.buttonM.active = true
			self.buttonR.active = false
			
			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Show() end
			if self.catR then self.catR:Hide() end
			
			surface.PlaySound( "pepboy/click3.wav" )
		
		end

		self.buttonR = vgui.Create( "pepboy_catbutton_text", self )
		self.buttonR:SetPos( scrW()/2 + 75, scrH()/2 + PEPBOY_SIZE_Y/2 - 10 )
		self.buttonR:SetSize( 150, 50 )
		self.buttonR.label = "SETTINGS"
		self.buttonR.DoClick = function()
		
			self.buttonL.active = false
			self.buttonM.active = false
			self.buttonR.active = true
			
			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Hide() end
			if self.catR then self.catR:Show() end
			
			surface.PlaySound( "pepboy/click3.wav" )
		
		end

	end
	
	self.catL = vgui.Create( "pepboy_wrapper", self.screen )
	self.catL:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catL:addTop( "HP", function() return localplayer():Health() end, 0.9 )
	//self.catL:addTop( "SAL", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "salary" )) end, 1.3 )
	//self.catL:addTop( "CASH", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "money" )) end, 2.2 )
	self.catL:SetTitle( "GENERAL", 2.5 )
	

	local status_panel = function()
		
		local panel = vgui.Create( "pepboy_status_page", self.catL )
		panel:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		panel:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		return panel
		
	end
	
	local rules_panel = function()
	
		local element = vgui.Create( "pepboy_textlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		element:addListEntry( "1. Respect the admins" )
		element:addListEntry( "2. No probclimbing" )
		element:addListEntry( "3. No spamming" )
		
		return element
		
	end
	
	local commands_panel = function()
	
		local element = vgui.Create( "pepboy_textlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		/*
		for k, v in pairs( DarkRP.getSortedChatCommands() ) do
		
			element:addListEntry( GAMEMODE.Config.chatCommandPrefix .. v.command .. " - " .. v.description, v.condition )
		
		end
		*/
		return element
		
	end
	
	local jobs_panel = function()
	
		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		/*
		local cats = DarkRP.getCategories().jobs
		
		for k, _ in pairs( cats ) do
			
			for _, v in pairs( cats[k].members ) do
						
				element:addItemListEntry( {	

						label = v.name,
						desc = string.gsub( v.description, "\n", "" ),
						stats = { { key = "Salary", val = v.salary } },
						clickFunc = function()
							
							local jobSel = vgui.Create( "pepboy_job_selection" )
							jobSel:SetSize( scrW(), scrH() )
							jobSel:SetPos( 0, 0 )
							jobSel:setContent( v )
						
						end,
						rightClickFunc = function() end,
						
					} )		
				
			end
		
		end
		*/
		
		return element
		
	end
	
	self.catL:addBottom( "Status", status_panel, true )
	self.catL:addBottom( "Rules", rules_panel )
	self.catL:addBottom( "Commands", commands_panel )
	self.catL:addBottom( "Jobs", jobs_panel )
	
	self.catL:makeLayout()
	
	self.catM = vgui.Create( "pepboy_wrapper", self.screen )
	self.catM:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catM:addTop( "HP", function() return localplayer():Health() ..":" ..100 end, 1.4 )
	self.catM:addTop( "DT", function() return "DT" end, 0.8 )
	self.catM:addTop( "Caps", function() return "Caps" end, 2.2 )
	self.catM:SetTitle( "ITEMS", 2.5 )
	self.catM:SetSubTitle( "Wg " ..localplayer():getInventoryWeight() .."/" ..100 )
	
	local weapons_panel = function()
		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		if localplayer().inventory and localplayer().inventory.weapons then
			for k, v in pairs(localplayer().inventory.weapons) do
				element:addItemListEntry({
					label = getWeaponName(v.classid),
					stats = {
						{key = "Weight", val = getWeaponWeight(v.classid)},
						{key = "Value", val = getWeaponValue(v.classid)},
						{key = "Strength", val = getWeaponStrength(v.classid)},
						{key = "Damage", val = getWeaponDamage(v.classid)},
					},
					itemIcon = Material("models/pepboy/item_icon_sniper"),
					inUse = v.equipped,
					
					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						menu:SetType("weapons")
						if v.equipped then
							menu:AddOptions({"Un-Equip", "Drop"})
						else
							menu:AddOptions({"Equip", "Drop"})
						end
						menu:Open()
					end
				})
			end
		end
		
		/*
		local cats = DarkRP.getCategories().weapons
	
		for k, _ in pairs( cats ) do
			
			for _, v in pairs( cats[k].members ) do
						
				element:addItemListEntry( {	
						
						label = v.name,
						enabledFunc = function() if istable( v.allowed ) and !table.HasValue( v.allowed, localplayer():Team() ) then return false else return true end end,
						stats = { { key = "Price", val = v.pricesep }, { key = "Cat", val = v.category } },
						clickFunc = function()
							
							RunConsoleCommand( "DarkRP", "buy", v.name )
						
						end,
						rightClickFunc = function() end,
						itemIcon = WEAPON_ICONS[ v.category ]
						
					} )		
				
			end
		
		end
		*/
		
		return element
	
	end
	
	local shipment_panel = function()
	
		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		/*
		local cats = DarkRP.getCategories().shipments
	
		for k, _ in pairs( cats ) do
			
			for _, v in pairs( cats[k].members ) do
						
				element:addItemListEntry( {	
						
						label = v.name,
						enabledFunc = function() if istable( v.allowed ) and !table.HasValue( v.allowed, localplayer():Team() ) then return false else return true end end,
						stats = { { key = "Price", val = v.price }, { key = "Cat", val = v.category } },
						clickFunc = function()
							
							RunConsoleCommand( "DarkRP", "buyshipment", v.name )
						
						end,
						rightClickFunc = function() end,
						itemIcon = matShipment
						
					} )		
				
			end
		
		end
		*/
		return element
		
	end
	
	local ammo_panel = function()
	
		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		/*
		local cats = DarkRP.getCategories().ammo
	
		for k, _ in pairs( cats ) do
			
			for _, v in pairs( cats[k].members ) do
						
				element:addItemListEntry( {	
						
						label = v.name,
						enabledFunc = function() if istable( v.allowed ) and !table.HasValue( v.allowed, localplayer():Team() ) then return false else return true end end,
						stats = { { key = "Price", val = v.price }, { key = "Cat", val = v.category } },
						clickFunc = function()
							
							RunConsoleCommand( "DarkRP", "buyammo", v.id )
						
						end,
						rightClickFunc = function() end,
						itemIcon = AMMO_ICONS[ v.ammoType ]
						
					} )		
				
			end
		
		end
		
		return element
		*/
	end
	
	local misc_panel = function()
	
		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		/*
		local cats = DarkRP.getCategories().entities
	
		for k, _ in pairs( cats ) do
			
			for _, v in pairs( cats[k].members ) do
						
				element:addItemListEntry( {	
						
						label = v.name,
						enabledFunc = function() if istable( v.allowed ) and !table.HasValue( v.allowed, localplayer():Team() ) then return false else return true end end,
						stats = { { key = "Price", val = v.price }, { key = "Cat", val = v.category } },
						clickFunc = function()
							
							RunConsoleCommand( "DarkRP", v.cmd )
						
						end,
						rightClickFunc = function() end,
						itemIcon = matMachine
						
					} )		
				
			end
		
		end
		*/
		
		return element
		
	end
	
	self.catM:addBottom( "Weapons", weapons_panel )
	self.catM:addBottom( "Apparel", apparel_panel )
	self.catM:addBottom( "Ammo", ammo_panel )
	self.catM:addBottom( "Misc", misc_panel )
	
	self.catM:makeLayout()
	self.catM:Hide()
	
	
	self.catR = vgui.Create( "pepboy_wrapper", self.screen )
	self.catR:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catR:addTop( "HP", function() return localplayer():Health() end, 0.9 )
	//self.catR:addTop( "SAL", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "salary" )) end, 1.3 )
	//self.catR:addTop( "CASH", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "money" )) end, 2.2 )
	self.catR:SetTitle( "MAINT", 2.5 )

	
	local settings_panel = function()
		
		local panel = vgui.Create( "pepboy_settings_page", self.catR )
		panel:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		panel:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )
		
		return panel
		
	end
	self.catR:addBottom( "Settings", settings_panel )
	
	self.catR:makeLayout()
	self.catR:Hide()
	
	gui.EnableScreenClicker( true )

end

function VGUI:Think()
	
	if input.IsKeyDown( PEPBOY_CLOSE_KEY ) then
	
		close()
	
	end
	
end
vgui.Register( "pepboy_main", VGUI, "Panel" )


local VGUI = {}
function VGUI:Paint()

end
vgui.Register( "pepboy_screen", VGUI, "Panel" )

local VGUI = {}
function VGUI:Paint( w, h )

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( matFrame )
	surface.DrawTexturedRect( (w - 1920) / 2, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 - 215, 1920, 1080 )

end
vgui.Register( "pepboy_frame", VGUI, "Panel" )


local VGUI = {}
function VGUI:Paint( w, h )
	
	if self.active then
	
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( matGlow )
		surface.DrawTexturedRect( 0, 0, w, h )
		
	end
	
end

function VGUI:OnMousePressed( m )
	
	if m == MOUSE_LEFT then
	
		self.DoClick()
	
	end
	
end
vgui.Register( "pepboy_catbutton", VGUI, "Panel" )

local VGUI = {}
function VGUI:Paint( w, h )
	
	draw.SimpleText( self.label, "pepboy_32", w/2, h/2 - 8, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	surface.SetFont( "pepboy_32" )
	local tw, th = surface.GetTextSize( self.label )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 0, 16, w/2 - tw/2 - PEPBOY_PADDING, 4 )
	surface.DrawTexturedRect( w/2 + tw/2 + PEPBOY_PADDING, 16, w, 4 )
	
	if self.active or self.hovered then
		
		surface.DrawTexturedRect( w/2 - tw/2 - PEPBOY_PADDING, 0, tw + PEPBOY_PADDING * 2, 2 )
		surface.DrawTexturedRect( w/2 - tw/2 - PEPBOY_PADDING, h - 13, tw + PEPBOY_PADDING * 2, 2 )
		surface.DrawTexturedRectRotated( w/2 - tw/2 - PEPBOY_PADDING, 14, h, 2, 90 )
		surface.DrawTexturedRectRotated( w/2 + tw/2 + PEPBOY_PADDING, 14, h, 2, 90 )
		
		if self.active then
		
			surface.SetDrawColor( math.Clamp( PEPBOY_COLOR.r + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.g + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.b + 30, 0, 255 ), 15 )
			surface.DrawRect( w/2 - tw/2 - PEPBOY_PADDING, 2, tw + PEPBOY_PADDING * 2, h - 14 )
			
		end
		
	end

end

function VGUI:OnCursorEntered()

	self.hovered = true
	
	surface.PlaySound( "pepboy/click2.wav" )
	
end

function VGUI:OnCursorExited()

	self.hovered = false

end

function VGUI:OnMousePressed( m )
	
	if m == MOUSE_LEFT then
	
		self.DoClick()
		
	end
	
end
vgui.Register( "pepboy_catbutton_text", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.title = "DEFAULT"
	self.titleSize = 2
	
	self.top = {}
	self.bot = {}
	
	self.layoutTitle = {}
	self.layoutTop = {}
	self.layoutBot = {}
	
end

function VGUI:Paint( w, h )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLineDashed )
	surface.DrawTexturedRectUV( 0, h - 50 - 32, 4, 50, 0, 0, 1, -1 )
	surface.DrawTexturedRectUV( w - 4, h - 50 - 32, 4, 50, 0, 0, 1, -1 )
	
	if self.subTitle then
		draw.SimpleText( self.subTitle, "pepboy_32", 195, 40, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function VGUI:SetSubTitle(title)
	self.subTitle = title
end

function VGUI:SetTitle( title, size )
	
	self.title = string.upper( title )
	self.titleSize = size
	
end

function VGUI:addBottom( label, panel, active )
	
	table.insert( self.bot, { label = label, panel = panel, active = active } )
	
end

function VGUI:getPanel( k )

	return self.bot[k].panel

end

function VGUI:addTop( k, v, size )
	
	table.insert( self.top, { key = k, val = v, size = size } )
	
end

function VGUI:makeLayout()
	
	local totalTop = self.titleSize
	for _, v in pairs( self.top ) do
	
		totalTop = totalTop + v.size
	
	end
	
	local leftTop = 0
	local w, h = self:GetSize()
	
	local entry = vgui.Create( "pepboy_wrapper_topTitle", self )
	entry:SetPos( w/totalTop * leftTop, 0 )
	entry:SetSize( w/totalTop * self.titleSize, PEPBOY_WRAPPER_SIZE_TOP )
	entry.label = self.title
	
	leftTop = leftTop + self.titleSize
	
	table.insert( self.layoutTop, entry )
	
	for _, v in pairs( self.top ) do
		
		local entry = vgui.Create( "pepboy_wrapper_topEntry", self )
		entry:SetPos( w/totalTop * leftTop, 0 )
		entry:SetSize( math.ceil( w/totalTop * v.size ), PEPBOY_WRAPPER_SIZE_TOP )
		entry.label = v.key
		entry.val = v.val
		
		leftTop = leftTop + v.size
		
		table.insert( self.layoutTop, entry )
		
	end
	
	local w, h = self:GetSize()
	
	local leftBot = 0
	for _, v in pairs( self.bot ) do
		
		local x = round( w/#self.bot )
		
		local entry = vgui.Create( "pepboy_wrapper_botEntry", self )
		entry:SetPos( x * leftBot, h - 50 )
		entry:SetSize( x, 50 )
		entry.label = v.label
		entry.panelFunc = v.panel
		entry.DoClick = function()
		
			for _, v in pairs( entry:GetParent().layoutBot ) do
			
				v.active = false
				
				if v.panel then v.panel:Remove() end
			
			end
			
			entry.panel = entry.panelFunc()
			entry.active = true
		
		end
		
		if v.active then entry.DoClick() end
		
		leftBot = leftBot + 1
		
		table.insert( self.layoutBot, entry )
		
	end
	
end
vgui.Register( "pepboy_wrapper", VGUI, "Panel" )


local VGUI = {}
function VGUI:Paint( w, h )
	
	draw.SimpleText( self.label, "pepboy_32", PEPBOY_PADDING + 4, ( h - 16 )/2 + 16, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	
	draw.SimpleText( self.val(), "pepboy_32", w - 4 - 6, ( h - 16 )/2 + 16, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( PEPBOY_PADDING, 12, w, 4 )
	surface.SetMaterial( matLineDashed )
	surface.DrawTexturedRect( w - 4, 2 + 12, 4, h - 12 )
	
end
vgui.Register( "pepboy_wrapper_topEntry", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.label = "D E F A U L T" 
	
end

function VGUI:Paint( w, h )
	
	draw.SimpleText( self.label, "pepboy_40", w/2.5, 16, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	surface.SetFont( "pepboy_40" )
	local tw, th = surface.GetTextSize( self.label )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 0, 12, w/2.5 - PEPBOY_PADDING - tw/2, 4 )
	surface.DrawTexturedRect( w/2.5 - tw/2 + PEPBOY_PADDING + tw, 12, w - tw/2.5 + 2 * PEPBOY_PADDING + tw, 4 )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLineDashed )
	surface.DrawTexturedRect( w - 4, 2 + 12, 4, h - 12 )
	surface.DrawTexturedRectUV( 0, 2 + 12, 4, h - 12, -1, 0, 0, 1 )
	
end
vgui.Register( "pepboy_wrapper_topTitle", VGUI, "Panel" )


local VGUI = {}
function VGUI:Paint( w, h )
	
	draw.SimpleText( self.label, "pepboy_32", w/2, h/2 - 8, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	surface.SetFont( "pepboy_32" )
	local tw, th = surface.GetTextSize( self.label )
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 0, 16, w/2 - tw/2 - PEPBOY_PADDING, 4 )
	surface.DrawTexturedRect( w/2 + tw/2 + PEPBOY_PADDING, 16, w, 4 )
	
	if self.active or self.hovered then
		
		surface.DrawTexturedRect( w/2 - tw/2 - PEPBOY_PADDING, 0, tw + PEPBOY_PADDING * 2, 2 )
		surface.DrawTexturedRect( w/2 - tw/2 - PEPBOY_PADDING, h - 13, tw + PEPBOY_PADDING * 2, 2 )
		surface.DrawTexturedRectRotated( w/2 - tw/2 - PEPBOY_PADDING, 14, h, 2, 90 )
		surface.DrawTexturedRectRotated( w/2 + tw/2 + PEPBOY_PADDING, 14, h, 2, 90 )
		
		if self.active then
		
			surface.SetDrawColor( math.Clamp( PEPBOY_COLOR.r + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.g + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.b + 30, 0, 255 ), 15 )
			surface.DrawRect( w/2 - tw/2 - PEPBOY_PADDING, 2, tw + PEPBOY_PADDING * 2, h - 14 )
			
		end
		
	end

end

function VGUI:OnCursorEntered()

	self.hovered = true
	
	surface.PlaySound( "pepboy/click2.wav" )
	
end

function VGUI:OnCursorExited()

	self.hovered = false

end

function VGUI:OnMousePressed( m )
	
	surface.PlaySound( "pepboy/click1.wav" )
	
	if m == MOUSE_LEFT then
	
		self.DoClick()
		
	end
	
end
vgui.Register( "pepboy_wrapper_botEntry", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.entry = {}
	self.offset = 0
	
end

function VGUI:Paint( w, h )
	
	
	
	local line = -0.5
	for k, v in pairs( self.entry ) do
	
	local enabled = v.enabled( localplayer() )
		
		line = line + 1.5
		
		if enabled then
			
			for lk, lv in pairs( v.txt ) do
				
				draw.SimpleText( lv, "pepboy_27", 14, 0 + 27 * line - self.offset, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				line = line + 1
				
			end
			
			line = line - 1
			
		else
			
			for lk, lv in pairs( v.txt ) do
				
				draw.SimpleText( lv, "pepboy_27", 14, 0 + 27 * line - self.offset, PEPBOY_COLOR_DISABLED, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
				line = line + 1
				
			end
			
			line = line - 1
			
		end
			
	end
	
	self.lines = line
	
	if line * 27 > h then
		
		local frac = self.offset / ( self.lines * 27 - PEPBOY_CONTENT_SIZE_Y + 40 )

		surface.SetDrawColor( PEPBOY_COLOR )
		surface.SetMaterial( matLineDashed )
		surface.DrawTexturedRect( 0, 49 + ( PEPBOY_CONTENT_SIZE_Y - 120 )* frac, 4, 50 )
		surface.DrawTexturedRectRotated( 2, 25 + ( PEPBOY_CONTENT_SIZE_Y - 120 ) * frac, 4, 50, 180 )
	
	end
	
end

function VGUI:OnMouseWheeled( dt )
	
	if self.lines * 27 > PEPBOY_CONTENT_SIZE_Y then
	
		self.offset = math.Clamp( self.offset - dt * 20, 0, self.lines * 27 - PEPBOY_CONTENT_SIZE_Y + 40 )
		
	end

end

function VGUI:addListEntry( entry, enabled )
	
	if !enabled then enabled = function() return true end end
	
	local text_draw_t = {}

	local text_t = string.Explode( " ", entry )
	local line = 0
	
	surface.SetFont( "pepboy_27" )
	for k, word in pairs( text_t ) do

		local buff = (text_draw_t[line] or "") .. word .. " "
		local tw, _ = surface.GetTextSize( buff )
		
		line = line + math.floor( tw / ( PEPBOY_CONTENT_SIZE_X - 14 ) )
		text_draw_t[line] = (text_draw_t[line] or "") .. word .. " "
	
	end
	
	table.insert( self.entry, { txt = text_draw_t, enabled = enabled } )
	
end

function VGUI:setList( t )
	
	self.entry = {}
	
	for _, v in pairs( t ) do
	
		self:addListEntry( v.txt, v.enabled )
	
	end
	
end
vgui.Register( "pepboy_textlist", VGUI, "Panel" )

local VGUI = {}
function VGUI:Init()
	self.item = nil
	self.offset = 0
	self.menuTypes = {
	["Equip"] = function()
		local catM = self:GetParent():GetParent()
		localplayer():equipItem(self.item.uniqueid, self.type)
		self:GetParent():Remove()
		catM:makeLayout()
		catM.layoutBot[1].panelFunc()
	end,	
	["Un-Equip"] = function()
		local catM = self:GetParent():GetParent()
		localplayer():unequipItem(self.item.uniqueid, self.type)
		self:GetParent():Remove()
		catM:makeLayout()
		catM.layoutBot[1].panelFunc()
	end,
	["Drop"] = function()
		local catM = self:GetParent():GetParent()
		localplayer():dropItem(self.item.uniqueid, self.type)
		self:GetParent():Remove()
		catM:makeLayout()
		catM.layoutBot[1].panelFunc()
	end
}
end

function VGUI:Paint(w, h)
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.DrawRect(0, 0, w, h)
end

function VGUI:SetType(type)
	self.type = type
end

function VGUI:StoreItem(item)
	self.item = item
end

function VGUI:AddOptions(options)
	for k,v in ipairs(options) do
		self:AddOption(v, self.menuTypes[v])
	end
end

vgui.Register( "pepboy_rightclickbox", VGUI, "DMenu" )



local VGUI = {}
function VGUI:Init()
	
	self.entry = {}	
	self.offset = 0
	
end

function VGUI:Paint( w, h )
	
	if #self.entry * 50 > h then
	
		local frac = self.offset / ( #self.entry * 50 - PEPBOY_CONTENT_SIZE_Y + 40 )

		surface.SetDrawColor( PEPBOY_COLOR )
		surface.SetMaterial( matLineDashed )
		surface.DrawTexturedRect( 0, 49 + ( PEPBOY_CONTENT_SIZE_Y - 120 )* frac, 4, 50 )
		surface.DrawTexturedRectRotated( 2, 25 + ( PEPBOY_CONTENT_SIZE_Y - 120 ) * frac, 4, 50, 180 )
	
	end
	
end

function VGUI:OnMouseWheeled( dt )
	
	if #self.entry * 50 > PEPBOY_CONTENT_SIZE_Y then
	
		self.offset = math.Clamp( self.offset - dt * 20, 0, #self.entry * 50 - PEPBOY_CONTENT_SIZE_Y + 40 )
		
	end
	
	for k, v in pairs( self.entry ) do
	
		v:SetPos( 10, ( k - 1 ) * 50 - self.offset )
	
	end

end

function VGUI:addItemListEntry( entry )
	
	local label = entry.label or ""
	local desc = entry.desc or ""
	local enabledFunc = entry.enabledFunc or function() return true end
	local clickFunc = entry.clickFunc or function() end
	local rightClickFunc = entry.rightClickFunc or function() end
	local disabledClickFunc = entry.disabledClickFunc or function() end
	local stats = entry.stats or nil
	local itemIcon = entry.itemIcon or nil
	local inUse = entry.inUse or nil // Track whether the item is equipped or not
	
	local infoPanel = function()
	
		local infoPanel = vgui.Create( "pepboy_itemlist_info", self )
		infoPanel:SetPos( PEPBOY_CONTENT_SIZE_X/2, 0 )
		infoPanel:SetSize( PEPBOY_CONTENT_SIZE_X/2, PEPBOY_CONTENT_SIZE_Y )
		infoPanel:setDesc( desc )
		infoPanel:setStats( stats )
		infoPanel:setItemIcon( itemIcon )
		return infoPanel
		
	end

	
	local panel = vgui.Create( "pepboy_itemlist_entry", self )
	panel:SetPos( 10, 0 + #self.entry * 50 )
	panel:SetSize( PEPBOY_CONTENT_SIZE_X/2 - 20, 50 )
	panel:setContent( label )
	panel.inUse = inUse
	panel:setEnabledFunc( enabledFunc )
	panel:setInfoPanel( infoPanel )
	panel.DoClick = clickFunc
	panel.DoRightClick = rightClickFunc
	panel.DoDisabled = disabledClickFunc
	
	table.insert( self.entry, panel )
	
end

function VGUI:setList( t )
	
	self.entry = {}
	
	for _, v in pairs( t ) do
	
		self:addItemListEntry( v.txt, v.enabled )
	
	end
	
end
vgui.Register( "pepboy_itemlist", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.entry = {}
	self.offset = 0
	
end

function VGUI:Paint( w, h )
	
	if self.enabled then
		if self.inUse then
			draw.SimpleText( self.content, "pepboy_27", 18, h/2, Color(0, 0, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( self.content, "pepboy_27", 18, h/2, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )		
		end
		
	else
		
		draw.SimpleText( self.content, "pepboy_27", 18, h/2, PEPBOY_COLOR_DISABLED, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		
	end
		
	if self.active or self.hovered then
		
		if !self.enabled then
		
			surface.SetDrawColor( PEPBOY_COLOR_DISABLED )
		
		else
		
			surface.SetDrawColor( PEPBOY_COLOR )
			
		end
		
		surface.SetMaterial( matLine )
		surface.DrawTexturedRect( 10, 0, self.tw + 2 * 8, 2 )
		surface.DrawTexturedRect( 10, h - 2, self.tw + 2 * 8, 2 )
		surface.DrawTexturedRectRotated( 10, h/2, h, 2, 90 )
		surface.DrawTexturedRectRotated( math.Clamp( self.tw + 2 * 8 + 10, 0, w - 1 ), h/2, h, 2, 90 )
		
		if self.active then
			
			surface.SetDrawColor( math.Clamp( PEPBOY_COLOR.r + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.g + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.b + 30, 0, 255 ), 15 )
			surface.DrawRect( 11, 2, self.tw + 2 * 8 - 1, h - 4 )
			
		end
		
	end
	
end

function VGUI:OnMouseWheeled( dt )
	
	local listP = self:GetParent()
	listP:OnMouseWheeled( dt )

end

function VGUI:setContent( cont )

	self.content = cont
	
	surface.SetFont( "pepboy_27" )
	local tw, th = surface.GetTextSize( cont )
	local w, h = self:GetSize()
	
	self.tw = math.Clamp( tw, 0, w )
	
end

function VGUI:setEnabled( b )

	self.enabled = b

end

function VGUI:setEnabledFunc( func )

	self.enabledFunc = func
	self.enabled = func( localplayer() )

end

function VGUI:OnCursorEntered()
	
	self.enabled = self.enabledFunc( localplayer() )
	
	self.hovered = true
	
	surface.PlaySound( "pepboy/click2.wav" )
	
	self.infoPanel = self.infoPanelFunc()

end

function VGUI:OnCursorExited()
	
	self.infoPanel:Remove()
	
	self.hovered = false
	self.active = false

end

function VGUI:OnMousePressed( m )
	
	if self.enabled then
		
		surface.PlaySound( "pepboy/click1.wav" )
		
		self.active = true
		
	else
		
		surface.PlaySound( "pepboy/error1.wav" )
	
	end
	
end

function VGUI:OnMouseReleased( m )
	
	if self.enabled and self.active then
		
		self.active = false
		
		if m == MOUSE_LEFT then
			
			if self.DoClick then self.DoClick() end	
			
		elseif m == MOUSE_RIGHT then
			
			if self.DoRightClick then self.DoRightClick() end	
			
		end
		
	else
	
		if self.DoDisabled then self.DoDisabled() end
	
	end
	
end

function VGUI:setInfoPanel( panelFunc )

	self.infoPanelFunc = panelFunc

end
vgui.Register( "pepboy_itemlist_entry", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.text_draw_t = {}
	
end

function VGUI:Paint( w, h )
	
	local offsetY = 0
	
	self.textStart = PEPBOY_CONTENT_SIZE_Y/1.45 - 54 - 256
	
	if self.itemIcon then
	
		surface.SetDrawColor( PEPBOY_COLOR )
		surface.SetMaterial( self.itemIcon )
		surface.DrawTexturedRect( w/2 - 128, 0, 256, 256 )

		self.textStart = self.textStart + 256
	
	end
	
	if self.stats then
		
		for k, v in pairs( self.stats ) do
			
			local x = 2 - k
			if k > 2 then
				x = 4 - k
				offsetY = 50
			end
			
			surface.SetDrawColor( PEPBOY_COLOR )
			surface.SetMaterial( matLine )
			surface.DrawTexturedRect( ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) * x , self.textStart - 20 + offsetY, ( w - 4 - PEPBOY_PADDING )/2, 4 )
			surface.SetMaterial( matLineDashed )
			surface.DrawTexturedRect( ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) * x + ( w - 4 - PEPBOY_PADDING )/2, self.textStart - 20 + offsetY, 4, 50 )
			
			draw.SimpleText( v.key, "pepboy_27", ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) * x + 4, self.textStart - 20 + 50/2 + offsetY, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			
			draw.SimpleText( v.val, "pepboy_27", ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) * x + ( w - 4 - PEPBOY_PADDING )/2 - 4, self.textStart - 20 + 50/2 + offsetY, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		
		end
	
		self.textStart = self.textStart + 54 + offsetY
	
	end
	
	for k, v in pairs( self.text_draw_t ) do
		
		if self.smallFont then
		
			draw.SimpleText( v, "pepboy_20", 8, k * 18 + self.textStart, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		
		else
			
			draw.SimpleText( v, "pepboy_27", 8, k * 24 + self.textStart + 8, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			
		end
	
	end
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 0, self.textStart - 20 + 10, w, 4 )
	surface.SetMaterial( matLineDashed )
	surface.DrawTexturedRect( w - 4, self.textStart - 20 + 10, 4, 50 )
	
end

function VGUI:setDesc( txt )

	self.text_draw_t = {}

	local text_t = string.Explode( " ", txt )
	local line = 0
	
	surface.SetFont( "pepboy_27" )
	for k, word in pairs( text_t ) do

		local buff = (self.text_draw_t[line] or "") .. word .. " "
		local tw, _ = surface.GetTextSize( buff )
		
		line = line + math.floor( tw / ( PEPBOY_CONTENT_SIZE_X/2 ) )
		self.text_draw_t[line] = (self.text_draw_t[line] or "") .. word .. " "
	
	end
	
	if #self.text_draw_t > 13 then
		
		self.smallFont = true
		self.text_draw_t = {}

		local text_t = string.Explode( " ", txt )
		local line = 0
		
		surface.SetFont( "pepboy_20" )
		for k, word in pairs( text_t ) do

			local buff = (self.text_draw_t[line] or "") .. word .. " "
			local tw, _ = surface.GetTextSize( buff )
			
			line = line + math.floor( tw / ( PEPBOY_CONTENT_SIZE_X/2 ) )
			self.text_draw_t[line] = (self.text_draw_t[line] or "") .. word .. " "
		
		end
			
	end
	
end

function VGUI:setItemIcon( mat )

	self.itemIcon = mat

end

function VGUI:setStats( t )

	self.stats = t

end
vgui.Register( "pepboy_itemlist_info", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()

	self.avatar = vgui.Create( "AvatarImage", self )
	self.avatar:SetSize( 128, 128 )
	self.avatar:SetPos( 60, 70 )
	self.avatar:SetPlayer( localplayer(), 128 )
	
	self.cash = ""
	self.job = ""
	self.salary = ""
	
end

function VGUI:Paint( w, h )
	
	local hp = localplayer():Health()
	local shd = localplayer():Armor()
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLineDashed )
	
	surface.DrawTexturedRect( 60 - 8, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 - 4 - 2, 4, 60, 90 )
	
	surface.DrawTexturedRect( 60 + 128 + 4, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 - 4 - 2, 4, 60, 270 )
	
	surface.DrawTexturedRectUV( 60 + 128 + 4, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 + 128 + 6, 4, 60, 270 )
	
	surface.DrawTexturedRectUV( 60 - 8, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 + 128 + 6, 4, 60, 90 )
	

	surface.DrawTexturedRect( w - 50 + 8, 70 + 32 - 8, 4, 70 )
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 60 + 128 + 50 - 4, 70 + 32 - 8, w - 50 + 8 - ( 60 + 128 + 50 - 4 ), 4 )

	draw.SimpleText( localplayer():Nick(), "pepboy_40", 60 + 128 + 50, 70 + 32, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	//draw.SimpleText( DarkRP.formatMoney(localplayer():getDarkRPVar( "money" )) or self.cash, "pepboy_40", w - 50, 70 + 32, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	
	//draw.SimpleText( localplayer():getDarkRPVar( "job" ) or self.job, "pepboy_27", 60 + 128 + 50, 70 + 32 + 50, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	//draw.SimpleText( "SALARY   " .. DarkRP.formatMoney(localplayer():getDarkRPVar( "salary" )) or self.salary, "pepboy_27",  w - 50, 70 + 32 + 50, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	

	surface.DrawTexturedRect( 40, PEPBOY_CONTENT_SIZE_Y/1.6, w - 80, 4 )
	draw.SimpleText( "HP", "pepboy_40", 40 + 8, PEPBOY_CONTENT_SIZE_Y/1.6 + 8, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	draw.SimpleText( hp, "pepboy_40", 40 + 8 + 120 - 20, PEPBOY_CONTENT_SIZE_Y/1.6 + 8, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	
	local triangleFront = {
	
		{ x = 40 + 8 + 120 - 20, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 },
		{ x = 40 + 8 + 120, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 },
		{ x = 40 + 8 + 120, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 + 20 }

	}
	
	local triangleBack = {
	
		{ x = w - 100, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 },
		{ x = w - 100 + 20, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 },
		{ x = w - 100, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 4 + 20 }

	}
	
	draw.NoTexture()
	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 8 + 120 + 4, PEPBOY_CONTENT_SIZE_Y/1.6 + 8, ( w - 100 - ( 40 + 8 + 120 ) - 8 ) * math.Clamp( hp / 100, 0, 1 ), 30 )

	
	surface.DrawTexturedRect( 40, PEPBOY_CONTENT_SIZE_Y/1.6 + 120, w - 80, 4 )
	draw.SimpleText( "SHD", "pepboy_32", 40 + 8, PEPBOY_CONTENT_SIZE_Y/1.6 + 75 + 8, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	draw.SimpleText( shd, "pepboy_32", 40 + 8 + 120 - 20, PEPBOY_CONTENT_SIZE_Y/1.6 + 75 + 8, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	
	local triangleFront = {
	
		{ x = 40 + 8 + 120 - 20, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120},
		{ x = 40 + 8 + 120, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120 - 15 },
		{ x = 40 + 8 + 120, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120 }

	}
	
	local triangleBack = {
	
		{ x = w - 100, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120 - 15 },
		{ x = w - 100 + 20, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120 },
		{ x = w - 100, y = PEPBOY_CONTENT_SIZE_Y/1.6 + 120 }

	}

	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 8 + 120 + 4, PEPBOY_CONTENT_SIZE_Y/1.6 + 120 - 24, ( w - 100 - ( 40 + 8 + 120 ) - 8 ) * math.Clamp( shd / 100, 0, 1 ), 20 )
	
end
vgui.Register( "pepboy_status_page", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()
	
	self.rDecr = vgui.Create( "pepboy_decr_incr", self )
	self.rDecr:SetPos( 40 + 180 + 4 + 60 + 15, 60 + 40 - 20 - 4 )
	self.rDecr:SetSize( 20, 20 )
	self.rDecr:setColor( Color( 255, 80, 80, 255 ) )
	self.rDecr.DoClick = function()
	
		self.r = math.Clamp( self.r - 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.r = math.Clamp( self.r - 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( self.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.rIncr = vgui.Create( "pepboy_decr_incr", self )
	self.rIncr:SetPos( PEPBOY_CONTENT_SIZE_X - 30, 60 + 40 - 20 - 4 )
	self.rIncr:SetSize( 20, 20 )
	self.rIncr:setType( 2 )
	self.rIncr:setColor( Color( 255, 80, 80, 255 ) )
	self.rIncr.DoClick = function()
	
		self.r = math.Clamp( self.r + 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.r = math.Clamp( self.r + 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( self.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.gDecr = vgui.Create( "pepboy_decr_incr", self )
	self.gDecr:SetPos( 40 + 180 + 4 + 60 + 15, 60 + 40 - 20 - 4 + 40 )
	self.gDecr:SetSize( 20, 20 )
	self.gDecr:setColor( Color( 80, 255, 80, 255 ) )
	self.gDecr.DoClick = function()
	
		self.g = math.Clamp( self.g - 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.g = math.Clamp( self.g - 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, self.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.gIncr = vgui.Create( "pepboy_decr_incr", self )
	self.gIncr:SetPos( PEPBOY_CONTENT_SIZE_X - 30, 60 + 40 - 20 - 4 + 40 )
	self.gIncr:SetSize( 20, 20 )
	self.gIncr:setType( 2 )
	self.gIncr:setColor( Color( 80, 255, 80, 255 ) )
	self.gIncr.DoClick = function()
	
		self.g = math.Clamp( self.g + 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.g = math.Clamp( self.g + 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, self.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.bDecr = vgui.Create( "pepboy_decr_incr", self )
	self.bDecr:SetPos( 40 + 180 + 4 + 60 + 15, 60 + 40 - 20 - 4 + 40 + 40 )
	self.bDecr:SetSize( 20, 20 )
	self.bDecr:setColor( Color( 80, 80, 255, 255 ) )
	self.bDecr.DoClick = function()
	
		self.b = math.Clamp( self.b - 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.b = math.Clamp( self.b - 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, self.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.bIncr = vgui.Create( "pepboy_decr_incr", self )
	self.bIncr:SetPos( PEPBOY_CONTENT_SIZE_X - 30, 60 + 40 - 20 - 4 + 40 + 40 )
	self.bIncr:SetSize( 20, 20 )
	self.bIncr:setType( 2 )
	self.bIncr:setColor( Color( 80, 80, 255, 255 ) )
	self.bIncr.DoClick = function()
	
		self.b = math.Clamp( self.b + 1, 0, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.b = math.Clamp( self.b + 10, 0, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, self.b, PEPBOY_COLOR.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.aDecr = vgui.Create( "pepboy_decr_incr", self )
	self.aDecr:SetPos( 40 + 8 + 120 - 30 + 30, 60 + 40 + 140 + 4 + 4 )
	self.aDecr:SetSize( 20, 20 )
	self.aDecr.DoClick = function()
	
		self.a = math.Clamp( self.a - 1, 30, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.a = math.Clamp( self.a - 10, 30, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, self.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end
	
	self.aIncr = vgui.Create( "pepboy_decr_incr", self )
	self.aIncr:SetPos( PEPBOY_CONTENT_SIZE_X - 70, 60 + 40 + 140 + 4 + 4 )
	self.aIncr:SetSize( 20, 20 )
	self.aIncr:setType( 2 )
	self.aIncr.DoClick = function()
	
		self.a = math.Clamp( self.a + 1, 30, 255 )
		if input.IsKeyDown( KEY_LSHIFT ) then
		
			self.a = math.Clamp( self.a + 10, 30, 255 )
		
		end
		
		PEPBOY_COLOR = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, self.a )
		PEPBOY_COLOR_DISABLED = Color( PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, PEPBOY_COLOR.a/4)
		
		file.Write( "pepboy/settings.txt", PEPBOY_COLOR.r .. ";" .. PEPBOY_COLOR.g .. ";" .. PEPBOY_COLOR.b .. ";" .. PEPBOY_COLOR.a )
		
	end

	self.r = PEPBOY_COLOR.r
	self.g = PEPBOY_COLOR.g
	self.b = PEPBOY_COLOR.b
	
	self.a = PEPBOY_COLOR.a
	
end

function VGUI:Paint( w, h )
	
	local hp = localplayer():Health()
	local shd = localplayer():Armor()
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLineDashed )
	
	surface.DrawTexturedRect( 60 - 8, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 - 4 - 2, 4, 60, 90 )
	
	surface.DrawTexturedRect( 60 + 128 + 4, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 - 4 - 2, 4, 60, 270 )
	
	surface.DrawTexturedRectUV( 60 + 128 + 4, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 + 128 + 6, 4, 60, 270 )
	
	surface.DrawTexturedRectUV( 60 - 8, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 + 128 + 6, 4, 60, 90 )
	
	surface.DrawRect( 60, 70, 128, 128 )
	
	
	surface.SetMaterial( matLine )
	surface.DrawTexturedRect( 40, 60 + 40 + 140, w - 80, 4 )
	draw.SimpleText( "BRT", "pepboy_32", 40 + 8, 60 + 40 + 140 + 4, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	draw.SimpleText( self.a, "pepboy_32", 40 + 8 + 120 - 30, 60 + 40 + 140 + 4, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )
	
	local triangleFront = {
	
		{ x = 40 + 8 + 120 - 20 + 50, y = 60 + 40 + 140 + 4},
		{ x = 40 + 8 + 120 + 50, y = 60 + 40 + 140 + 4 },
		{ x = 40 + 8 + 120 + 50, y = 60 + 40 + 140 + 4 + 20 }

	}
	
	local triangleBack = {
	
		{ x = w - 100, y = 60 + 40 + 140 + 4 },
		{ x = w - 100 + 20, y = 60 + 40 + 140 + 4 },
		{ x = w - 100, y = 60 + 40 + 140 + 20 + 4 }

	}
	
	draw.NoTexture()
	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 8 + 120 + 4 + 50, 60 + 40 + 140 + 8, ( w - 100 - ( 40 + 8 + 120 ) - 8 - 50 ) * math.Clamp( ( self.a - 30 ) / 225, 0, 1 ), 30 )

	
	surface.DrawTexturedRect( 40 + 180, 60 + 40, w - 80 - 140, 4 )
	draw.SimpleText( "R", "pepboy_32", 40 + 180 + 4, 60 + 40, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	draw.SimpleText( self.r, "pepboy_32", 40 + 180 + 4 + 60, 60 + 40, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	
	local triangleFront = {
	
		{ x = 40 + 180 + 4 + 60 + 60 - 20, y = 60 + 40},
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 - 15 },
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 }

	}
	
	local triangleBack = {
	
		{ x = w - 100 + 40, y = 60 + 40 - 15 },
		{ x = w - 100 + 40 + 20, y = 60 + 40 },
		{ x = w - 100 + 40, y = 60 + 40 }

	}

	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 180 + 4 + 60 + 60 + 4, 60 + 40 - 20 - 4, ( w - 100 - ( 40 + 8 + 120 ) - 8 - 120 - 8 - 8 ) * math.Clamp( self.r / 255, 0, 1 ), 20 )
	
	
	surface.DrawTexturedRect( 40 + 180, 60 + 40 + 40, w - 80 - 140, 4 )
	draw.SimpleText( "G", "pepboy_32", 40 + 180 + 4, 60 + 40 + 40, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	draw.SimpleText( self.g, "pepboy_32", 40 + 180 + 4 + 60, 60 + 40 + 40, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	
	local triangleFront = {
	
		{ x = 40 + 180 + 4 + 60 + 60 - 20, y = 60 + 40 + 40 },
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 - 15 + 40 },
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 + 40 }

	}
	
	local triangleBack = {
	
		{ x = w - 100 + 40, y = 60 + 40 - 15 + 40 },
		{ x = w - 100 + 40 + 20, y = 60 + 40 + 40 },
		{ x = w - 100 + 40, y = 60 + 40 + 40 }

	}

	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 180 + 4 + 60 + 60 + 4, 60 + 40 - 20 - 4 + 40, ( w - 100 - ( 40 + 8 + 120 ) - 8 - 120 - 8 - 8 ) * math.Clamp( self.g / 255, 0, 1 ), 20 )
	
	
	surface.DrawTexturedRect( 40 + 180, 60 + 40 + 40 + 40, w - 80 - 140, 4 )
	draw.SimpleText( "B", "pepboy_32", 40 + 180 + 4, 60 + 40 + 40 + 40, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
	draw.SimpleText( self.b, "pepboy_32", 40 + 180 + 4 + 60, 60 + 40 + 40 + 40, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )
	
	local triangleFront = {
	
		{ x = 40 + 180 + 4 + 60 + 60 - 20, y = 60 + 40 + 40 + 40 },
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 - 15 + 40 + 40 },
		{ x = 40 + 180 + 4 + 60 + 60, y = 60 + 40 + 40 + 40 }

	}
	
	local triangleBack = {
	
		{ x = w - 100 + 40, y = 60 + 40 - 15 + 40 + 40 },
		{ x = w - 100 + 40 + 20, y = 60 + 40 + 40 + 40 },
		{ x = w - 100 + 40, y = 60 + 40 + 40 + 40 }

	}

	surface.DrawPoly( triangleFront )
	surface.DrawPoly( triangleBack )
	
	surface.DrawRect( 40 + 180 + 4 + 60 + 60 + 4, 60 + 40 - 20 - 4 + 40 + 40, ( w - 100 - ( 40 + 8 + 120 ) - 8 - 120 - 8 - 8 ) * math.Clamp( self.b / 255, 0, 1 ), 20 )
	
	
end
vgui.Register( "pepboy_settings_page", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()

	self.type = 1

end

function VGUI:Paint( w, h )

	surface.SetDrawColor( self.color or PEPBOY_COLOR)
	surface.DrawRect( 0, 0, w, h )
	
	surface.SetDrawColor( 0, 0, 0, 255 )
	
	if self.type == 1 then
	
		surface.DrawRect( w/2 - 5, h/2 - 2, w/2, 4 )
	
	elseif self.type == 2 then
	
		surface.DrawRect( w/2 - 5, h/2 - 2, w/2, 4 )
		surface.DrawRect( w/2 - 2, h/2 - 5, 4, h/2 )
		
	end
	
end

function VGUI:setColor( c )

	self.color = c

end

function VGUI:setType( t )

	self.type = t

end

function VGUI:OnMousePressed()

	self.DoClick()

end
vgui.Register( "pepboy_decr_incr", VGUI, "Panel" )


local VGUI = {}
function VGUI:Init()

	self.maxIcons = math.floor( scrW() / 3 / 128 )
	
	matBlur:SetFloat( "$blur", 3 )
	matBlur:Recompute()
	
	self.iconX = 256
	self.iconY = 0
	
	self.weps = ""
	
	self.icons = {}
	
end

function VGUI:Paint()
	
	surface.SetMaterial( matBlur )
	surface.SetDrawColor( 255, 255, 255, 255 )
	
	for i = 0.2, 1, 0.2 do
	
		matBlur:SetFloat( "$blur", 5 * i )
		matBlur:Recompute()
		
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		
	end
	
	surface.SetDrawColor( PEPBOY_COLOR )
	surface.SetMaterial( matLineDashed )
	
	surface.DrawTexturedRect( scrW() / 2 - self.iconX / 2, scrH() / 2 - self.iconY / 2 - 128 - 60 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( scrW() / 2 - self.iconX / 2 + 30, scrH() / 2 - self.iconY / 2 - 128 - 60 - 2, 4, 60, 90 )
	
	surface.DrawTexturedRect( scrW() / 2 + self.iconX / 2, scrH() / 2 - self.iconY / 2 - 128 - 60 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( scrW() / 2 + self.iconX / 2 - 30 + 4, scrH() / 2 - self.iconY / 2 - 128 - 60 - 2, 4, 60, 270 )
	
	
	draw.SimpleText( "Weapons", "pepboy_32", scrW() / 2, scrH() / 2 + self.iconY / 2 - 60 + 30, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	local line = 0
	if #self.content.weapons == 0 then
	
		draw.SimpleText( "None", "pepboy_27", scrW() / 2, scrH() / 2 + self.iconY / 2 - 60 + 30 + 32, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		line = line + 1
		
	else
		
		for k, v in pairs( self.content.weapons ) do
		
			draw.SimpleText( v, "pepboy_27", scrW() / 2, scrH() / 2 + self.iconY / 2 - 60 + 30 + 32 + 27 * line, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			line = line + 1
			
		end
	
	end
	
end

function VGUI:Think()
	
	if input.IsKeyDown( PEPBOY_CLOSE_KEY ) then
	
		self:Remove()
	
	end
	
end

function VGUI:setContent( t )

	self.content = t
	
	self.button = vgui.Create( "pepboy_job_button", self )
	self.button:SetSize( 120, 50 )
	self.button:setContent( "Okay" )
	
	if type( t.model ) == "table" then
		
		self.iconX = self.maxIcons * 128
		self.iconY = math.floor( #t.model / self.maxIcons ) * 128
		
		
		
		local icons = 0
		for k, v in pairs( t.model ) do
			
			icons = icons + 1
			
			local icon = vgui.Create( "DModelPanel", self )
			icon:SetSize( 128, 128 )
			icon:SetPos( scrW() / 2 - 128 + ( icons - self.maxIcons / 2 ) * 128, scrH() / 2 - self.iconY / 2 - 128 - 60 + 128 * math.floor( ( k - 1 ) / self.maxIcons ) )
			icon:SetModel( v )
			function icon:LayoutEntity( Entity ) return end
			icon.DoClick = function() 
			
				DarkRP.setPreferredJobModel( self.content.team, v ) 
				
				for _, v in pairs( self.icons ) do
				
					function v:PaintOver() return end
				
				end
				
				function icon:PaintOver( w, h )
				
					surface.SetDrawColor( 255, 255, 255, 2 )
					surface.DrawRect( 0, 0, w, h )
					
				end
				
				self.button:setEnabled( true )
				
			end
			
			table.insert( self.icons, icon )
			
			if icons == self.maxIcons then icons = 0 end
			
		end
		
	else
	
		self.button:setEnabled( true )
	
	end
	
	self.button:SetPos( scrW() / 2 - 60, scrH() / 2 + self.iconY / 2 - 60 + 30 + 32 + #self.content.weapons * 27 + 16 )
	self.button.DoClick = function()
		
		if self.content.vote or self.content.RequiresVote and self.content.RequiresVote( LocalPlayer(), self.content.team ) then
		
			close()
			self:Remove()
			self.DoClick = RunConsoleCommand( "darkrp", "vote" .. self.content.command )
			
		else
		
			close()
			self:Remove()
			self.DoClick = RunConsoleCommand( "darkrp", self.content.command )
			
		end
		
	end
	
end
vgui.Register( "pepboy_job_selection", VGUI, "Panel" )


local VGUI = {}
local VGUI = {}
function VGUI:Init()
	
	self.entry = {}
	self.offset = 0
	
end

function VGUI:Paint( w, h )
	
	if self.enabled then
		
		draw.SimpleText( self.content, "pepboy_32", w/2, h/2, PEPBOY_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
	else
		
		draw.SimpleText( self.content, "pepboy_32", w/2, h/2, PEPBOY_COLOR_DISABLED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
	end
		
	if self.active or self.hovered then
		
		if !self.enabled then
		
			surface.SetDrawColor( PEPBOY_COLOR_DISABLED )
		
		else
		
			surface.SetDrawColor( PEPBOY_COLOR )
			
		end
		
		surface.SetMaterial( matLine )
		surface.DrawTexturedRect( 2, 0, w + 2 * 8, 2 )
		surface.DrawTexturedRect( 2, h - 2, w + 2 * 8, 2 )
		surface.DrawTexturedRectRotated( 2, h/2, h, 2, 90 )
		surface.DrawTexturedRectRotated( math.Clamp( w + 2 * 8 + 2, 0, w - 1 ), h/2, h, 2, 90 )
		
		if self.active then
			
			surface.SetDrawColor( math.Clamp( PEPBOY_COLOR.r + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.g + 30, 0, 255 ), math.Clamp( PEPBOY_COLOR.b + 30, 0, 255 ), 15 )
			surface.DrawRect( 2, 2, w + 2 * 8 - 1, h - 4 )
			
		end
		
	end
	
end

function VGUI:setContent( cont )

	self.content = cont
	
	surface.SetFont( "pepboy_27" )
	
end

function VGUI:setEnabled( b )

	self.enabled = b

end

function VGUI:OnCursorEntered()
	
	self.hovered = true
	
end

function VGUI:OnCursorExited()
	
	self.hovered = false
	self.active = false

end

function VGUI:OnMousePressed( m )
	
	if self.enabled then
	
		self.active = true
		
	end
	
end

function VGUI:OnMouseReleased( m )
	
	if self.enabled and self.active then
		
		self.active = false
		
		if m == MOUSE_LEFT then
			
			if self.DoClick then self.DoClick() end	
			
		end
		
	end
	
end
vgui.Register( "pepboy_job_button", VGUI, "Panel" )