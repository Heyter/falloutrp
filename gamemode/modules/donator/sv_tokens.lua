
util.AddNetworkString("updateTokens")

local meta = FindMetaTable("Player")

function meta:addToken(amount)
	timer.Simple(30, function()
		self.playerData.tokens = self:getTokens() + amount

		local tokens = self:getTokens()

		DB:RunQuery("UPDATE playerdata SET tokens = " ..tokens .." WHERE steamid = '" ..self:SteamID() .."'")

		net.Start("updateTokens")
			net.WriteInt(tokens, 8)
		net.Send(self)
	end)
end

function meta:removeToken(amount)
	self.playerData.tokens = self:getTokens() - amount

	local tokens = self:getTokens()

	DB:RunQuery("UPDATE playerdata SET tokens = " ..tokens .." WHERE steamid = '" ..self:SteamID() .."'")

	self:notify("You have " ..tokens .." tokens remaining.", NOTIFY_GENERIC)

    net.Start("updateTokens")
        net.WriteInt(tokens, 8)
    net.Send(self)
end
