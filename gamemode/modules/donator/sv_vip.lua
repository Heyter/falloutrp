
util.AddNetworkString("updateVip")

local meta = FindMetaTable("Player")

function meta:addVip()
	timer.Simple(30, function()
		self.playerData.vip = 1

		DB:RunQuery("UPDATE playerdata SET vip = 1 WHERE steamid = '" ..self:SteamID() .."'")

		net.Start("updateVip")
			net.WriteInt(1, 8)
		net.Send(self)

		self:addToken(1)
	end)
end

function meta:addPermVip()
	self.playerData.vip = 1

	DB:RunQuery("UPDATE playerdata SET vip = 1 WHERE steamid = '" ..self:SteamID() .."'")

	net.Start("updateVip")
		net.WriteInt(1, 8)
	net.Send(self)
end

function meta:removeVip()
	self.playerData.vip = 0

	DB:RunQuery("UPDATE playerdata SET vip = 0 WHERE steamid = '" ..self:SteamID() .."'")

	net.Start("updateVip")
		net.WriteInt(0, 8)
	net.Send(self)
end
