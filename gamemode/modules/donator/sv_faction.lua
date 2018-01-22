
// Functional
util.AddNetworkString("factionChange")

local meta = FindMetaTable("Player")

function meta:changeFaction(id)
	DB:RunQuery("UPDATE playerdata SET faction = " ..id .." WHERE steamid = '" ..self:SteamID() .."'")

	self:notify("You have changed your faction to " ..team.GetName(id), NOTIFY_GENERIC)

	// Reload the player
	timer.Simple(2, function()
		self:load()
	end)
end

net.Receive("factionChange", function(len, ply)
	local team = net.ReadInt(8)

	ply:changeFaction(team)
	ply:removeToken(getFactionTokens())
end)
