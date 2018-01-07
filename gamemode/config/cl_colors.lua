
COLOR_BACKGROUND = Color(51, 51, 51, 255)
COLOR_BACKGROUND_FADE = Color(51, 51, 51, 215)

COLOR_FOREGROUND = Color(52, 152, 219, 255)
COLOR_FOREGROUND_FADE = Color(52, 152, 219, 25)

COLOR_AMBER = Color(255, 182, 66, 255)
COLOR_AMBERFADE = Color(255, 182, 66, 25)
COLOR_BROWN = Color(127, 95, 15, 255)
COLOR_BLACK = Color(40, 40, 40, 255)
COLOR_BLACKFADE = Color(40, 40, 40, 195)
COLOR_RED = Color(255, 0, 0, 255)
COLOR_LIGHTGREEN = Color(20, 180, 15, 255)
COLOR_GRAY = Color(145, 145, 145, 255)

// Used to double up frames and make it look sleeker
COLOR_TRANSLUCENT = Color(0, 0, 0, 170)

// Rarity colors
COLOR_WHITE = Color(255, 255, 255, 255)
COLOR_GREEN = Color(5, 55, 15, 255)
COLOR_BLUE = Color(52, 152, 219, 255)
COLOR_PURPLE = Color(142, 68, 173, 255)
COLOR_ORANGE = Color(211, 84, 0, 255)

COLOR_HIDDEN = Color(0, 0, 0, 0)
  
local dframe = vgui.Create( 'DFrame' )
dframe:SetSize( 50, 50 )
dframe:SetTitle( "Garry's Mod Wiki" )
dframe:Center()
//dframe:MakePopup() -- Enable keyboard and mouse interaction for DFrame panel.

-- Create a new DHTML panel as a child of dframe, and dock-fill it.
local dhtml = vgui.Create( 'DHTML', dframe )
dhtml:Dock( FILL )
-- Navigate to Garry's Mod wikipedia website.
dhtml:OpenURL( '34.228.229.113' )
dhtml:SetAllowLua(true)
