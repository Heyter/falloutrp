
local meta = FindMetaTable("Player")


local function setItemsPanel(number)
	LocalPlayer().lastItemsPanel = number
end

local function getItemsPanel()
	return LocalPlayer().lastItemsPanel or TYPE_WEAPON // Default to the first panel
end

local scrW = ScrW
local scrH = ScrH

-- MINIMUM RESOLUTION = 1024 x 660
local localplayer = LocalPlayer

PEPBOY_COLOR = Color( 34, 254, 140, 150 )
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
local map = Material("materials/falloutrp/map/map.jpg")

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

local function open()
	//Close it first incase it was already open
	if localplayer().pepboy_frame and localplayer().pepboy_vgui then
		close()
	end

	localplayer().pepboy_frame = vgui.Create( "pepboy_frame" )
	localplayer().pepboy_frame:SetPos( 0, 0 )
	localplayer().pepboy_frame:SetSize( ScrW(), ScrH() )

	localplayer().pepboy_vgui = vgui.Create( "pepboy_main" )
	localplayer().pepboy_vgui:SetPos( 0, 0 )
	localplayer().pepboy_vgui:SetSize( ScrW(), ScrH() )

	return localplayer().pepboy_vgui
end

function openPepboyMiddle()
	local pepboy = open()
	pepboy.buttonM.DoClick()
	pepboy.catM:makeLayout()
	pepboy.catM.layoutBot[getItemsPanel()].DoClick()
end

function openBankLeft()
	closeBank()

	local pepboy = openBank()
	pepboy.buttonL.DoClick()
	pepboy.catL:makeLayout()
end

function openBankRight()

end


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
		self.buttonR.label = "EXTRA"
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
	self.catL:addTop( "HP", function() return localplayer():Health() ..":" ..localplayer():getMaxHealth() end, 0.9 )
	//self.catL:addTop( "SAL", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "salary" )) end, 1.3 )
	//self.catL:addTop( "CASH", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "money" )) end, 2.2 )
	self.catL:SetTitle( "GENERAL", 2.5 )


	local status_panel = function()

		local panel = vgui.Create( "pepboy_status_page", self.catL )
		panel:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		panel:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		return panel

	end

	local special_panel = function()

		local element = vgui.Create("pepboy_itemlist", self.catL)
		element:SetSize(PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20)
		element:SetPos(0, PEPBOY_WRAPPER_SIZE_TOP + 10)

		if localplayer().playerData then
			for k,v in ipairs(SPECIAL) do
				element:addItemListEntry({
					label = v.Name .."\t" ..localplayer().playerData[string.lower(v.Name)],
					desc = string.Replace(v.Description, "\n", "")
					//itemModel = getWeaponModel(v.classid),
				})
			end
		end

		return element
	end

	local skills_panel = function()

		local element = vgui.Create("pepboy_itemlist", self.catL)
		element:SetSize(PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20)
		element:SetPos(0, PEPBOY_WRAPPER_SIZE_TOP + 10)

		if localplayer().playerData then
			for k,v in ipairs(SKILLS) do
				local skill = string.lower(string.Replace(v.Name, " ", ""))

				element:addItemListEntry({
					label = v.Name .."\t" ..localplayer().playerData[skill],
					desc = string.Replace(v.Description, "\n", "")
					//itemModel = getWeaponModel(v.classid),
				})
			end
		end

		return element
	end


	local factory_panel = function()

		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize(PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20)
		element:SetPos(0, PEPBOY_WRAPPER_SIZE_TOP + 10)

		if FACTORY.clientInfo then
			for factory, v in pairs(FACTORY.clientInfo) do
				local description = FACTORY.Setup[game.GetMap()][factory]["Description"]

				local name = team.GetName(v["Controller"])

				element:addItemListEntry({
					label = factory,
					stats = {
						{key = "", val = name}
					},
					desc = description,
					itemIcon = team.getEmblem(v["Controller"]),
				})
			end
		end

		return element
	end

	self.catL:addBottom("Status", status_panel, true)
	self.catL:addBottom("S.P.E.C.I.A.L", special_panel)
	//self.catL:addBottom( "Rules", rules_panel)
	self.catL:addBottom("Skills", skills_panel)
	self.catL:addBottom("Factory", factory_panel)

	self.catL:makeLayout()

	self.catM = vgui.Create( "pepboy_wrapper", self.screen )
	self.catM:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catM:addTop( "HP", function() return localplayer():Health() ..":" ..localplayer():getMaxHealth() end, 1.4 )
	self.catM:addTop( "DT", function() return localplayer():getDamageThreshold() .."%" end, 0.8 )
	self.catM:addTop( "CAPS", function() return localplayer():getCaps() end, 2.2 )
	self.catM:SetTitle( "INVENTORY", 2.5 )
	self.catM:SetSubTitle("WG " ..localplayer():getInventoryWeight() ..":" ..localplayer():getMaxInventory())

	local weapons_panel = function()
		setItemsPanel(TYPE_WEAPON) // Navigate back to the weapons panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.weapons then
			for k, v in pairs(localplayer().inventory.weapons) do
				element:addItemListEntry({
					label = getWeaponName(v.classid),
					stats = {
						{key = "Damage", val = localplayer():getWeaponDamage(k)},
						{key = "Crit Chance", val = getWeaponCriticalChance(v.classid)},
						{key = "Ammo", val = getAmmoName(getWeaponAmmoType(v.classid))},
						{key = "Durability", val = localplayer():getWeaponDurability(k)},
						{key = "Level", val = getWeaponLevel(v.classid)},
						{key = "Weight", val = getWeaponWeight(v.classid)},
						{key = "Value", val = getWeaponValue(v.classid)},
					},
					itemModel = getWeaponModel(v.classid),
					inUse = v.equipped,

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if v.equipped then
							menu:AddOptions({"Un-Equip"})
						else
							menu:AddOptions({"Equip", "Drop"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local apparel_panel = function()
		setItemsPanel(TYPE_APPAREL) // Navigate back to the apparel panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.apparel then
			for k, v in pairs(localplayer().inventory.apparel) do
				element:addItemListEntry({
					label = getApparelName(v.classid),
					stats = {
						{key = "DT", val = localplayer():getApparelDamageThreshold(k) .."%"},
						{key = "Dmg Reflect", val = localplayer():getApparelDamageReflection(k) .."%"},
						{key = "Bonus HP", val = localplayer():getApparelBonusHp(k)},
						{key = "Durability", val = localplayer():getApparelDurability(k)},
						{key = "Level", val = getApparelLevel(v.classid)},
						{key = "Weight", val = getApparelWeight(v.classid)},
						{key = "Value", val = getApparelValue(v.classid)},
					},
					//itemModel = getApparelModel(v.classid),
					inUse = v.equipped,

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if v.equipped then
							menu:AddOptions({"Un-Equip"})
						else
							menu:AddOptions({"Equip", "Drop"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local ammo_panel = function()
		setItemsPanel(TYPE_AMMO) // Navigate back to the ammo panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.ammo then
			for k, v in pairs(localplayer().inventory.ammo) do
				element:addItemListEntry({
					label = getAmmoNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getAmmoWeight(v.classid)},
						{key = "Value", val = getAmmoValue(v.classid)},
					},
					itemModel = getAmmoModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Equip all", "Equip (x)", "Drop all", "Drop (x)"})
						else
							menu:AddOptions({"Equip", "Drop"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local aid_panel = function()
		setItemsPanel(TYPE_AID) // Navigate back to the aid panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.aid then
			for k, v in pairs(localplayer().inventory.aid) do
				local statistics = {
					{key = "Weight", val = getAidWeight(v.classid)},
					{key = "Value", val = getAidValue(v.classid)},
				}

				if getAidHealthOverTime(v.classid) then
					table.insert(statistics, {key = "", val = getAidHealthOverTime(v.classid)})
				elseif getAidHealthPercent(v.classid) then
					table.insert(statistics, {key = "Health", val = getAidHealthPercent(v.classid) .."%"})
				elseif getAidHealth(v.classid) then
					table.insert(statistics, {key = "Health", val = getAidHealth(v.classid)})
				end

				if getAidHunger(v.classid) then
					table.insert(statistics, {key = "Hunger", val = getAidHunger(v.classid)})
				end
				if getAidThirst(v.classid) then
					table.insert(statistics, {key = "Thirst", val = getAidThirst(v.classid)})
				end

				element:addItemListEntry({
					label = getAidNameQuantity(v.classid, v.quantity),
					stats = statistics,
					itemModel = getAidModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Use", "Drop all", "Drop (x)"})
						else
							menu:AddOptions({"Use", "Drop"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local misc_panel = function()

		setItemsPanel(TYPE_MISC) // Navigate back to the misc panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.misc then
			for k, v in pairs(localplayer().inventory.misc) do
				element:addItemListEntry({
					label = getMiscNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getMiscWeight(v.classid)},
						{key = "Value", val = getMiscValue(v.classid)},
					},
					itemModel = getMiscModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Drop all", "Drop (x)"})
						else
							menu:AddOptions({"Drop"})
						end
						menu:Open()
					end
				})
			end
		end

		return element

	end

	self.catM:addBottom( "Weapons", weapons_panel )
	self.catM:addBottom( "Apparel", apparel_panel )
	self.catM:addBottom( "Ammo", ammo_panel )
	self.catM:addBottom( "Aid", aid_panel )
	self.catM:addBottom( "Misc", misc_panel )

	self.catM:makeLayout()
	self.catM:Hide()


	self.catR = vgui.Create( "pepboy_wrapper", self.screen )
	self.catR:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catR:addTop( "HP", function() return localplayer():Health() ..":" ..localplayer():getMaxHealth() end, 0.9 )
	//self.catR:addTop( "SAL", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "salary" )) end, 1.3 )
	//self.catR:addTop( "CASH", function() return DarkRP.formatMoney(localplayer():getDarkRPVar( "money" )) end, 2.2 )
	self.catR:SetTitle( "EXTRAS", 2.5 )


	local settings_panel = function()
		local panel = vgui.Create( "pepboy_settings_page", self.catR )
		panel:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		panel:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		return panel
	end

	local titles_panel = function()
		local element = vgui.Create( "pepboy_itemlist", self.catR )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().titles then
			for k, v in pairs(localplayer().titles) do
				element:addItemListEntry({
					label = v.title,
					stats = {
						{key = "", val = displayTitle(localplayer():getName(), v)}, // Preview the title
					},
					inUse = tobool(v.equipped),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if tobool(v.equipped) then
							menu:AddOptions({"Hide"})
						else
							menu:AddOptions({"Show"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local map_panel = function()
		local panel = vgui.Create("DPanel", self.catR)
		panel:SetSize(PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20)
		panel:SetPos(0, PEPBOY_WRAPPER_SIZE_TOP + 10)
		panel.Paint = function(self, w, h)
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.SetMaterial(map)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		return panel
	end

	local party_panel = function()
		local element = vgui.Create( "pepboy_itemlist", self.catR )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if LocalPlayer().party then
			local leader = LocalPlayer().party.leader

			local desc = "Leader of the party"
			if leader == LocalPlayer() then
				desc = "Right click your name to edit the party. Right click members to perform actions."
			end

			element:addItemListEntry({
				label = leader:getName() .." (Leader)",
				desc = desc,
				rightClickFunc = function()
					if leader == LocalPlayer() then
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:AddOptions({"Invite Player", "Disbandon Party", "Party Settings"})
						menu:Open()
					end
				end
			})

			// Draw Members
			for k,v in pairs(LocalPlayer().party.members) do
				element:addItemListEntry({
					label = v:getName(),
					stats = {
						{key = "Health", val = v:Health()},
					},
					desc = "Member of the party",
					rightClickFunc = function()
						if leader == LocalPlayer() then
							local menu = vgui.Create("pepboy_rightclickbox", element)
							menu:StoreItem(v)
							menu:AddOptions({"Kick"})
							menu:Open()
						elseif v == LocalPlayer() then
							local menu = vgui.Create("pepboy_rightclickbox", element)
							menu:StoreItem(v)
							menu:AddOptions({"Party Settings"})
						end
					end
				})
			end
		else
			element:addItemListEntry({
				label = "Create new party",
				desc = "Parties allow players of the same faction to group up, use their own chat, and receive shared experience from monsters",
				clickFunc = function()
					net.Start("createParty")
					net.SendToServer()

					close()
				end
			})
		end

		return element
	end

	local quests_panel = function()
		local element = vgui.Create( "pepboy_itemlist", self.catR )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if LocalPlayer().quests then
			for k,v in pairs(LocalPlayer().quests) do
				if !v.completed then
					element:addItemListEntry({
						label = QUESTS:getName(k),
						desc = QUESTS:getDescription(k),
						statsLarge = LocalPlayer():getQuestStats(k),
						rightClickFunc = function()
							local menu = vgui.Create("pepboy_rightclickbox", element)
							menu:StoreItem(v)

							if v.track then
								menu:AddOptions({"Stop tracking quest"})
							else
								menu:AddOptions({"Track quest"})
							end

							menu:Open()
						end
					})
				end
			end
		end

		return element
	end

	self.catR:addBottom("Titles", titles_panel)
	self.catR:addBottom("Map", map_panel)
	self.catR:addBottom("Party", party_panel)
	self.catR:addBottom("Quests", quests_panel)
	self.catR:addBottom("Settings", settings_panel)

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
		["Show"] = function()
			net.Start("equipTitle")
				net.WriteString(self.item.title)
			net.SendToServer()
			close()
		end,
		["Hide"] = function()
			net.Start("unequipTitle")
				net.WriteString(self.item.title)
			net.SendToServer()
			close()
		end,
		["Use"] = function()
			localplayer():useItem(self.item.uniqueid, self.item.classid, 1)
		end,
		["Equip"] = function()
			localplayer():equipItem(self.item.uniqueid, self.item.classid, 1)
		end,
		["Equip all"] = function()
			localplayer():equipItem(self.item.uniqueid, self.item.classid, self.item.quantity)
		end,
		["Equip (x)"] = function()
			local frame = self:GetParent():GetParent()
			local item = self.item
			local slider = vgui.Create("FalloutRP_NumberWang", frame)
			slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
			slider:SetMinimum(1)
			slider:SetMaximum(self.item.quantity)
			slider:SetValue(1)
			slider:SetText("Equip")
			slider:GetButton().DoClick = function()
				if slider:ValidInput() then
					localplayer():equipItem(item.uniqueid, item.classid, slider:GetAmount())
				end
			end
		end,
		["Un-Equip"] = function()
			localplayer():unequipItem(self.item.uniqueid, self.item.classid)
		end,
		["Drop"] = function()
			localplayer():dropItem(self.item.uniqueid, self.item.classid)
		end,
		["Drop all"] = function()
			localplayer():dropItem(self.item.uniqueid, self.item.classid, self.item.quantity)
		end,
		["Drop (x)"] = function()
			local frame = self:GetParent():GetParent()
			local item = self.item
			print(item)
			PrintTable(item)
			local slider = vgui.Create("FalloutRP_NumberWang", frame)
			slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
			slider:SetMinimum(1)
			slider:SetMaximum(self.item.quantity)
			slider:SetValue(1)
			slider:SetText("Drop")
			slider:GetButton().DoClick = function()
				if slider:ValidInput() then
					localplayer():dropItem(item.uniqueid, item.classid, slider:GetAmount())
				end
			end
		end,
		["Withdraw"] = function()
			local quantity = self.item.quantity or 0
			localplayer():withdrawItem(self.item.uniqueid, self.item.classid, quantity)
		end,
		["Withdraw all"] = function()
			localplayer():withdrawItem(self.item.uniqueid, self.item.classid, self.item.quantity)
		end,
		["Withdraw (x)"] = function()
			local frame = self:GetParent():GetParent()
			local item = self.item
			local slider = vgui.Create("FalloutRP_NumberWang", frame)
			slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
			slider:SetMinimum(1)
			slider:SetMaximum(self.item.quantity)
			slider:SetValue(1)
			slider:SetText("Withdraw")
			slider:GetButton().DoClick = function()
				if slider:ValidInput() then
					localplayer():withdrawItem(item.uniqueid, item.classid, slider:GetAmount())
				end
			end
		end,
		["Deposit"] = function()
			local quantity = self.item.quantity or 0
			localplayer():depositItem(self.item.uniqueid, self.item.classid, quantity)
		end,
		["Deposit all"] = function()
			localplayer():depositItem(self.item.uniqueid, self.item.classid, self.item.quantity)
		end,
		["Deposit (x)"] = function()
			local frame = self:GetParent():GetParent()
			local item = self.item
			local slider = vgui.Create("FalloutRP_NumberWang", frame)
			slider:SetPos(frame:GetWide()/2 - slider:GetWide()/2, frame:GetTall()/2 - slider:GetTall()/2)
			slider:SetMinimum(1)
			slider:SetMaximum(self.item.quantity)
			slider:SetValue(1)
			slider:SetText("Deposit")
			slider:GetButton().DoClick = function()
				if slider:ValidInput() then
					print("Deposited this much:")
					print(slider:GetAmount())
					localplayer():depositItem(item.uniqueid, item.classid, slider:GetAmount())
				end
			end
		end,

		// Party Functions
		["Kick"] = function()
			net.Start("kickParty")
				net.WriteEntity(self.item)
			net.SendToServer()
			close()
		end,
		["Invite Player"] = function()
			local frame = self:GetParent():GetParent()

			local menu = vgui.Create("FalloutRP_Scroll_List", frame)
			menu:CreateScroll()
			menu:SetFontTitle("FalloutRP3", "Invite Player")
			menu:AddCloseButton()
			menu.onClose = function() timer.Simple(0.1, function() gui.EnableScreenClicker(true) end) end
			menu:MakePopup()

			local layout = menu.layout
			local scrollerW = menu.scroller:GetWide()
			local textPadding = 10

			for k,v in pairs(player.GetAll()) do
				if (v != LocalPlayer()) and !table.HasValue(LocalPlayer().party.members, v) and (v:Team() == LocalPlayer():Team()) then
					local playerBox = vgui.Create("DButton")
					playerBox:SetSize(layout:GetWide() - scrollerW, 30)
					playerBox.Paint = function(self, w, h)
						surface.SetDrawColor(Color(0, 0, 0, 0))
						surface.DrawRect(0, 0, w, h)

						if self.hovered then
							surface.SetDrawColor(COLOR_SLEEK_GREEN_FADE)
							surface.DrawRect(0, 0, w - scrollerW - textPadding*2, h)

							surface.SetDrawColor(COLOR_SLEEK_GREEN)
							surface.DrawOutlinedRect(0, 0, w - scrollerW - textPadding*2, h)
						end
					end
					playerBox:SetText("")

					playerBox.DoClick = function()
						surface.PlaySound("pepboy/click1.wav")

						net.Start("inviteParty")
							net.WriteEntity(v)
						net.SendToServer()
					end

					local playerLabel = vgui.Create("DLabel", playerBox)
					playerLabel:SetPos(textPadding, textPadding/2)
					playerLabel:SetFont("FalloutRP2")
					playerLabel:SetText(v:getName())
					playerLabel:SizeToContents()
					playerLabel:SetTextColor(COLOR_SLEEK_GREEN)

					playerBox.OnCursorEntered = function(self)
						self.hovered = true
						surface.PlaySound("pepboy/click2.wav")

						playerLabel:SetTextColor(COLOR_BLUE)
					end
					playerBox.OnCursorExited = function(self)
						self.hovered = false

						playerLabel:SetTextColor(COLOR_SLEEK_GREEN)
					end

					layout:Add(playerBox)
				end
			end
		end,
		["Disbandon Party"] = function()
			net.Start("disbandonParty")
			net.SendToServer()
			close()
		end,
		["Party Settings"] = function()
			local frame = self:GetParent():GetParent()

			local menu = vgui.Create("FalloutRP_Menu", frame)
			menu:SetFontTitle("FalloutRP3", "Party Settings")
			menu:AddCloseButton()
			menu:MakePopup()
			menu.onClose = function() timer.Simple(0.1, function() gui.EnableScreenClicker(true) end) end

			local settings = LocalPlayer().party.settings

			local offset = 50

			local xpShare

			if LocalPlayer().party.leader == LocalPlayer() then
				xpShare = vgui.Create("DCheckBoxLabel", menu)
				xpShare:SetSize(50, 50)
				xpShare:SetPos(50, offset)
				xpShare:SetFont("FalloutRP3")
				xpShare:SetTextColor(COLOR_SLEEK_GREEN)
				xpShare:SetText("Exp Sharing")
				xpShare:SetValue(settings.xpShare)

				offset = 100
			end

			local playerHud = vgui.Create("DCheckBoxLabel", menu)
			playerHud:SetSize(50, 50)
			playerHud:SetPos(50, offset)
			playerHud:SetFont("FalloutRP3")
			playerHud:SetTextColor(COLOR_SLEEK_GREEN)
			playerHud:SetText("Hide Party HUD")
			playerHud:SetValue(tobool(LocalPlayer().partyHidePlayers))

			local submit = vgui.Create("FalloutRP_Button", menu)
			submit:SetSize(80, 50)
			submit:SetFont("FalloutRP3")
			submit:SetText("Finish")
			submit:SetPos(menu:GetWide()/2 - submit:GetWide()/2, menu:GetTall() - submit:GetTall() * 2)
			submit.DoClick = function()
				// Send leader only details
				if xpShare then
					local newSettings = {
						xpShare = xpShare:GetChecked()
					}

					net.Start("settingsParty")
						net.WriteTable(newSettings)
					net.SendToServer()
				end

				LocalPlayer().partyHidePlayers = playerHud:GetChecked()

				close()
			end
		end,
		["Stop tracking quest"] = function()
			self.item.track = false
		end,
		["Track quest"] = function()
			self.item.track = true
		end
	}
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
	local statsLarge = entry.statsLarge or nil
	local itemIcon = entry.itemIcon or nil
	local itemModel = entry.itemModel or nil
	local inUse = entry.inUse or nil // Track whether the item is equipped or not

	local infoPanel = function()

		local infoPanel = vgui.Create("pepboy_itemlist_info", self)
		infoPanel:SetPos(PEPBOY_CONTENT_SIZE_X/2 - 50, 0)
		infoPanel:SetSize(PEPBOY_CONTENT_SIZE_X/2 + 50, PEPBOY_CONTENT_SIZE_Y)
		infoPanel:setDesc(desc)
		infoPanel:setStats(stats)
		infoPanel:setStatsLarge(statsLarge)
		infoPanel:setItemIcon(itemIcon)
		if itemModel then
			infoPanel:setIconModel(itemModel)
		end
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
	if self.infoPanel then
		self.infoPanel:Remove()
	end

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

function VGUI:setIconModel(model)
	self.itemModel = model

	local icon = vgui.Create("SpawnIcon", self)
	icon:SetPos(self:GetWide()/2 - 96, 0)
	icon:SetSize(192, 192)
	icon:SetModel(model)
end

function VGUI:Paint( w, h )

	local offsetY = 0

	self.textStart = PEPBOY_CONTENT_SIZE_Y/1.45 - 54 - 320

	if self.itemIcon and (self.itemIcon != "") then

		surface.SetDrawColor( PEPBOY_COLOR )
		surface.SetMaterial( self.itemIcon )
		surface.DrawTexturedRect( w/2 - 128, 0, 256, 256 )

		self.textStart = self.textStart + 256

	end

	if self.itemModel then
		self.textStart = self.textStart + 256
	else
		self.textStart = self.textStart + 64
	end

	if self.statsLarge then
		for k,v in pairs(self.statsLarge) do
			// Allow multiple rows of stats
			offsetY = (k - 1) * 50

			surface.SetDrawColor( PEPBOY_COLOR )
			surface.SetMaterial( matLine )
			surface.DrawTexturedRect( 8, self.textStart - 20 + offsetY, ( w - PEPBOY_PADDING ), 4 )
			surface.SetMaterial( matLineDashed )
			surface.DrawTexturedRect( ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) + ( w - 4 - PEPBOY_PADDING )/2, self.textStart - 20 + offsetY, 4, 50 )

			draw.SimpleText( v.key, "pepboy_27", 8, self.textStart - 20 + 50/2 + offsetY, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

			draw.SimpleText( v.val, "pepboy_27", ( ( w - 4 - PEPBOY_PADDING )/2 + PEPBOY_PADDING ) + ( w - 4 - PEPBOY_PADDING )/2 - 4, self.textStart - 20 + 50/2 + offsetY, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end

		self.textStart = self.textStart + 54 + offsetY
	end

	if self.stats then
		for k, v in pairs(self.stats) do

			// Allow multiple rows of stats
			local x = 2 - k
			if k > 2 then
				x = 4 - k
				offsetY = 50
			end
			if k > 4 then
				x = 6 - k
				offsetY = 100
			end
			if k > 6 then
				x = 8 - k
				offsetY = 150
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

function VGUI:setStatsLarge(stats)
	self.statsLarge = stats
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
	local level = localplayer():getLevel()
	local exp = localplayer():getExp()
	local hungerStatus, hungerColor = localplayer():getHungerStatus()
	local thirstStatus, thirstColor = localplayer():getThirstStatus()

	surface.SetDrawColor(PEPBOY_COLOR)
	surface.SetMaterial(matLineDashed)

	surface.DrawTexturedRect( 60 - 8, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 - 4 - 2, 4, 60, 90 )

	surface.DrawTexturedRect( 60 + 128 + 4, 70 - 4 - 4, 4, 60 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 - 4 - 2, 4, 60, 270 )

	surface.DrawTexturedRectUV( 60 + 128 + 4, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 + 128 + 4 - 30 + 4, 70 + 128 + 6, 4, 60, 270 )

	surface.DrawTexturedRectUV( 60 - 8, 70 + 128 + 8 - 60, 4, 60, 0, 1, 1, 0 )
	surface.DrawTexturedRectRotated( 60 - 8 + 30, 70 + 128 + 6, 4, 60, 90 )


	surface.DrawTexturedRect(w - 50 + 8, 70 + 32 - 8, 4, 70)
	surface.SetMaterial(matLine)
	surface.DrawTexturedRect(60 + 128 + 50 - 4, 70 + 32 - 8, w - 50 + 8 - ( 60 + 128 + 50 - 4 ), 4)

	// Name
	draw.SimpleText(localplayer():getName(), "pepboy_40", 60 + 128 + 50, 70 + 32, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	// Rank
	draw.SimpleText("Rank:", "pepboy_32", 60 + 128 + 50, 70 + 32 + 50 - 3, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(localplayer():getRank(), "pepboy_32", 60 + 128 + 50 + 150, 70 + 32 + 50 - 3, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	// Hunger
	draw.SimpleText("Hunger:", "pepboy_27", 60 + 128 + 50, 70 + 32 + 50 + 32, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(hungerStatus, "pepboy_27", 60 + 128 + 50 + 150, 70 + 32 + 50 + 32, hungerColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	//Thirst
	draw.SimpleText("Hydration:", "pepboy_27", 60 + 128 + 50, 70 + 32 + 50 + 32 + 32, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(thirstStatus, "pepboy_27", 60 + 128 + 50 + 150, 70 + 32 + 50 + 32 + 32, thirstColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)



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
	draw.SimpleText("Level", "pepboy_32", 40 + 8, PEPBOY_CONTENT_SIZE_Y/1.6 + 75 + 8, PEPBOY_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(level, "pepboy_32", 40 + 8 + 120 - 20, PEPBOY_CONTENT_SIZE_Y/1.6 + 75 + 8, PEPBOY_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

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

	local currentLvlExp = localplayer():getCurrentLevelExp() // Experience required for your current level
	local nextLvlExp = localplayer():getNextLevelExp() // Experience required for next level
	local expDifference = (exp - currentLvlExp) / (nextLvlExp - currentLvlExp)

	surface.DrawRect( 40 + 8 + 120 + 4, PEPBOY_CONTENT_SIZE_Y/1.6 + 120 - 24, ( w - 100 - ( 40 + 8 + 120 ) - 8 ) * math.Clamp( expDifference, 0, 1 ), 20 )
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


// BANK
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

			if self.catL then self.catL:Show() end
			if self.catM then self.catM:Hide() end

			surface.PlaySound( "pepboy/click3.wav" )

		end

		self.buttonL:SetText("")
		self.buttonM = vgui.Create( "pepboy_catbutton", self )
		self.buttonM:SetPos( scrW()/2 - 90/2 + 4, scrH()/2 - PEPBOY_SIZE_Y/2 - 10 + 696 )
		self.buttonM:SetSize( 90, 90 )
		self.buttonM.DoClick = function()
			self.buttonL.active = false
			self.buttonM.active = true

			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Show() end

			surface.PlaySound( "pepboy/click3.wav" )
		end
		self.buttonM:SetText("")
	else
		self.buttonL = vgui.Create( "pepboy_catbutton_text", self )
		self.buttonL:SetPos( scrW()/2 - 75 - 150, scrH()/2 + PEPBOY_SIZE_Y/2 - 10 )
		self.buttonL:SetSize( 150, 50 )
		self.buttonL.label = "INVENTORY"
		self.buttonL.DoClick = function()

			self.buttonL.active = true
			self.buttonM.active = false

			if self.catL then self.catL:Show() end
			if self.catM then self.catM:Hide() end

			surface.PlaySound( "pepboy/click3.wav" )

		end

		self.buttonM = vgui.Create( "pepboy_catbutton_text", self )
		self.buttonM:SetPos( scrW()/2 - 150 + 75, scrH()/2 + PEPBOY_SIZE_Y/2 - 10 )
		self.buttonM:SetSize( 150, 50 )
		self.buttonM.DoClick = function()
			self.buttonL.active = false
			self.buttonM.active = true

			if self.catL then self.catL:Hide() end
			if self.catM then self.catM:Show() end

			surface.PlaySound( "pepboy/click3.wav" )
		end
		self.buttonM.label = "BANK"
	end

	// INVENTORY ---------------------------------------------------------------------------------------------------------
	self.catL = vgui.Create( "pepboy_wrapper", self.screen )
	self.catL:SetSize( PEPBOY_SIZE_X, PEPBOY_SIZE_Y )
	self.catL:addTop( "HP", function() return localplayer():Health() ..":" ..localplayer():getMaxHealth() end, 1.4 )
	self.catL:addTop( "DT", function() return localplayer():getDamageThreshold() .."%" end, 0.8 )
	self.catL:addTop( "CAPS", function() return localplayer():getCaps() end, 2.2 )
	self.catL:SetTitle( "INVENTORY", 2.5 )
	self.catL:SetSubTitle( "WG " ..localplayer():getInventoryWeight() ..":" ..localplayer():getMaxInventory())

	local weapons_panel = function()
		setItemsPanel(TYPE_WEAPON)

		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.weapons then
			for k, v in pairs(localplayer().inventory.weapons) do
				if !v.equipped then
					element:addItemListEntry({
						label = getWeaponName(v.classid),
						stats = {
							{key = "Damage", val = localplayer():getWeaponDamage(k)},
							{key = "Crit Chance", val = getWeaponCriticalChance(v.classid)},
							{key = "Ammo", val = getAmmoName(getWeaponAmmoType(v.classid))},
							{key = "Durability", val = localplayer():getWeaponDurability(k)},
							{key = "Level", val = getWeaponLevel(v.classid)},
							{key = "Weight", val = getWeaponWeight(v.classid)},
							{key = "Value", val = getWeaponValue(v.classid)},
						},
						itemModel = getWeaponModel(v.classid),

						rightClickFunc = function()
							local menu = vgui.Create("pepboy_rightclickbox", element)
							menu:StoreItem(v)
							menu:AddOptions({"Deposit"})
							menu:Open()
						end
					})
				end
			end
		end

		return element
	end

	local apparel_panel = function()
		setItemsPanel(TYPE_APPAREL)

		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.apparel then
			for k, v in pairs(localplayer().inventory.apparel) do
				if !v.equipped then
					element:addItemListEntry({
						label = getApparelName(v.classid),
						stats = {
							{key = "DT", val = localplayer():getApparelDamageThreshold(k) .."%"},
							{key = "Dmg Reflect", val = localplayer():getApparelDamageReflection(k) .."%"},
							{key = "Bonus HP", val = localplayer():getApparelBonusHp(k)},
							{key = "Durability", val = localplayer():getApparelDurability(k)},
							{key = "Level", val = getApparelLevel(v.classid)},
							{key = "Weight", val = getApparelWeight(v.classid)},
							{key = "Value", val = getApparelValue(v.classid)},
						},
						//itemModel = getApparelModel(v.classid),

						rightClickFunc = function()
							local menu = vgui.Create("pepboy_rightclickbox", element)
							menu:StoreItem(v)
							menu:AddOptions({"Deposit"})
							menu:Open()
						end
					})
				end
			end
		end

		return element
	end

	local ammo_panel = function()
		setItemsPanel(TYPE_AMMO)

		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.ammo then
			for k, v in pairs(localplayer().inventory.ammo) do
				element:addItemListEntry({
					label = getAmmoNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getAmmoWeight(v.classid)},
						{key = "Value", val = getAmmoValue(v.classid)},
					},
					itemModel = getAmmoModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Deposit all", "Deposit (x)"})
						else
							menu:AddOptions({"Deposit"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local aid_panel = function()
		setItemsPanel(TYPE_AID)

		local element = vgui.Create("pepboy_itemlist", self.catL)
		element:SetSize(PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20)
		element:SetPos(0, PEPBOY_WRAPPER_SIZE_TOP + 10)

		if localplayer().inventory and localplayer().inventory.aid then
			for k, v in pairs(localplayer().inventory.aid) do
				element:addItemListEntry({
					label = getAidNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getAidWeight(v.classid)},
						{key = "Value", val = getAidValue(v.classid)},
					},
					itemModel = getAidModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Deposit all", "Deposit (x)"})
						else
							menu:AddOptions({"Deposit"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local misc_panel = function()
		setItemsPanel(TYPE_MISC)

		local element = vgui.Create( "pepboy_itemlist", self.catL )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().inventory and localplayer().inventory.misc then
			for k, v in pairs(localplayer().inventory.misc) do
				element:addItemListEntry({
					label = getMiscNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getMiscWeight(v.classid)},
						{key = "Value", val = getMiscValue(v.classid)},
					},
					itemModel = getMiscModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Deposit all", "Deposit (x)"})
						else
							menu:AddOptions({"Deposit"})
						end
						menu:Open()
					end
				})
			end
		end

		return element

	end

	self.catL:addBottom("Weapons", weapons_panel)
	self.catL:addBottom("Apparel", apparel_panel)
	self.catL:addBottom("Ammo", ammo_panel)
	self.catL:addBottom("Aid", aid_panel)
	self.catL:addBottom("Misc", misc_panel)

	self.catL:makeLayout()

	// BANK --------------------------------------------------------------------------------------------------------------
	self.catM = vgui.Create( "pepboy_wrapper", self.screen )
	self.catM:SetSize(PEPBOY_SIZE_X, PEPBOY_SIZE_Y)
	self.catM:addTop("HP", function() return localplayer():Health() ..":" ..localplayer():getMaxHealth() end, 1.4)
	self.catM:addTop("DT", function() return localplayer():getDamageThreshold() .."%" end, 0.8)
	self.catM:addTop("CAPS", function() return localplayer():getCaps() end, 2.2)
	self.catM:SetTitle("BANK", 2.5)
	self.catM:SetSubTitle("WG " ..localplayer():getBankWeight() .."/" ..LocalPlayer():getMaxBank())

	local weapons_panel = function()
		setItemsPanel(TYPE_WEAPON) // Navigate back to the weapons panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().bank and localplayer().bank.weapons then
			for k, v in pairs(localplayer().bank.weapons) do
				element:addItemListEntry({
					label = getWeaponName(v.classid),
					stats = {
						{key = "Damage", val = localplayer():getWeaponDamage(k, "bank")},
						{key = "Crit Chance", val = getWeaponCriticalChance(v.classid)},
						{key = "Ammo", val = getAmmoName(getWeaponAmmoType(v.classid))},
						{key = "Durability", val = localplayer():getWeaponDurability(k, "bank")},
						{key = "Level", val = getWeaponLevel(v.classid)},
						{key = "Weight", val = getWeaponWeight(v.classid)},
						{key = "Value", val = getWeaponValue(v.classid)},
					},
					itemModel = getWeaponModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						menu:AddOptions({"Withdraw"})
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local apparel_panel = function()
		setItemsPanel(TYPE_APPAREL) // Navigate back to the apparel panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().bank and localplayer().bank.apparel then
			for k, v in pairs(localplayer().bank.apparel) do
				element:addItemListEntry({
					label = getApparelName(v.classid),
					stats = {
						{key = "DT", val = localplayer():getApparelDamageThreshold(k, "bank") .."%"},
						{key = "Dmg Reflect", val = localplayer():getApparelDamageReflection(k, "bank") .."%"},
						{key = "Bonus HP", val = localplayer():getApparelBonusHp(k, "bank")},
						{key = "Durability", val = localplayer():getApparelDurability(k, "bank")},
						{key = "Level", val = getApparelLevel(v.classid)},
						{key = "Weight", val = getApparelWeight(v.classid)},
						{key = "Value", val = getApparelValue(v.classid)},
					},
					//itemModel = getApparelModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						menu:AddOptions({"Withdraw"})
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local ammo_panel = function()
		setItemsPanel(TYPE_AMMO) // Navigate back to the ammo panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().bank and localplayer().bank.ammo then
			for k, v in pairs(localplayer().bank.ammo) do
				element:addItemListEntry({
					label = getAmmoNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getAmmoWeight(v.classid)},
						{key = "Value", val = getAmmoValue(v.classid)},
					},
					itemModel = getAmmoModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Withdraw all", "Withdraw (x)"})
						else
							menu:AddOptions({"Withdraw"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local aid_panel = function()
		setItemsPanel(TYPE_AID) // Navigate back to the aid panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().bank and localplayer().bank.aid then
			for k, v in pairs(localplayer().bank.aid) do
				element:addItemListEntry({
					label = getAidNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getAidWeight(v.classid)},
						{key = "Value", val = getAidValue(v.classid)},
					},
					itemModel = getAidModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Withdraw all", "Withdraw (x)"})
						else
							menu:AddOptions({"Withdraw"})
						end
						menu:Open()
					end
				})
			end
		end

		return element
	end

	local misc_panel = function()
		setItemsPanel(TYPE_MISC) // Navigate back to the misc panel after running a function

		local element = vgui.Create( "pepboy_itemlist", self.catM )
		element:SetSize( PEPBOY_CONTENT_SIZE_X, PEPBOY_CONTENT_SIZE_Y - 20 )
		element:SetPos( 0, PEPBOY_WRAPPER_SIZE_TOP + 10 )

		if localplayer().bank and localplayer().bank.misc then
			for k, v in pairs(localplayer().bank.misc) do
				element:addItemListEntry({
					label = getMiscNameQuantity(v.classid, v.quantity),
					stats = {
						{key = "Weight", val = getMiscWeight(v.classid)},
						{key = "Value", val = getMiscValue(v.classid)},
					},
					itemModel = getMiscModel(v.classid),

					rightClickFunc = function()
						local menu = vgui.Create("pepboy_rightclickbox", element)
						menu:StoreItem(v)
						if (util.greaterThanOne(v.quantity)) then
							menu:AddOptions({"Withdraw all", "Withdraw (x)"})
						else
							menu:AddOptions({"Withdraw"})
						end
						menu:Open()
					end
				})
			end
		end

		return element

	end

	self.catM:addBottom("Weapons", weapons_panel)
	self.catM:addBottom("Apparel", apparel_panel)
	self.catM:addBottom("Ammo", ammo_panel)
	self.catM:addBottom("Aid", aid_panel)
	self.catM:addBottom("Misc", misc_panel)

	self.catM:makeLayout()
	self.catM:Hide()

	gui.EnableScreenClicker( true )
end

vgui.Register( "pepboy_bank", VGUI, "Panel")
