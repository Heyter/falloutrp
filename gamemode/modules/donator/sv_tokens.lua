
util.AddNetworkString("updateTokens")

local meta = FindMetaTable("Player")

function meta:addToken(amount)
	self.playerData.tokens = self:getTokens() + amount

	local tokens = self:getTokens()

	MySQLite.query("UPDATE playerdata SET tokens = " ..tokens .." WHERE steamid = '" ..self:SteamID() .."'")

	net.Start("updateTokens")
		net.WriteInt(tokens, 8)
	net.Send(self)
end

function meta:removeToken(amount)
	self.playerData.tokens = self:getTokens() - amount

	local tokens = self:getTokens()

	MySQLite.query("UPDATE playerdata SET tokens = " ..tokens .." WHERE steamid = '" ..self:SteamID() .."'")

	self:notify("You have " ..tokens .." faction changes remaining.", NOTIFY_GENERIC)

    net.Start("updateTokens")
        net.WriteInt(tokens, 8)
    net.Send(self)
end
