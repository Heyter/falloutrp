
util.AddNetworkString( "pepboy_died" )
util.AddNetworkString( "pepboy_open" )
util.AddNetworkString( "pepboy_close" )
	
resource.AddFile( "materials/models/pepboy/pepboy_frame.png" )
resource.AddFile( "materials/models/pepboy/glow.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_machine.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_other_weapon.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_pistol.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_pistol_ammo.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_rifle.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_rifle_ammo.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_shipment.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_shotgun.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_shotgun_ammo.vmt" )
resource.AddFile( "materials/models/pepboy/item_icon_sniper.vmt" )
resource.AddFile( "materials/models/pepboy/line_x.vmt" )
resource.AddFile( "materials/models/pepboy/line_y.vmt" )
resource.AddFile( "materials/models/pepboy/pepboy_screen.vmt" )
resource.AddFile( "materials/models/pepboy/pepboy_screenon.vmt" )
	
resource.AddSingleFile( "materials/models/pepboy/pepboy.vmt" )
resource.AddSingleFile( "materials/models/pepboy/pepboy.vtf" )
resource.AddSingleFile( "materials/models/pepboy/pepboy_normal.vtf" )
	
	
resource.AddSingleFile( "sound/pepboy/click1.wav" )
resource.AddSingleFile( "sound/pepboy/click2.wav" )
resource.AddSingleFile( "sound/pepboy/click3.wav" )
resource.AddSingleFile( "sound/pepboy/error1.wav" )
	
	
resource.AddFile( "models/pepboy/pepboy.mdl" )
	
	
resource.AddFile( "resource/fonts/monofont.ttf" )
	
hook.Add("PlayerDeath", "PepPlayerDeath", function(ply)
	net.Start("pepboy_died")
	
	net.Send(ply)
end)

hook.Add("ShowHelp", "PepOpenF1", function(ply)
	net.Start("pepboy_open")
		net.WriteBit(0)
	net.Send(ply)
end)

hook.Add("ShowSpare2", "PepOpenF4", function(ply)
	net.Start("pepboy_open")
		net.WriteBit(1)
	net.Send(ply)
end)