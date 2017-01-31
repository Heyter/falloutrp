
util.AddNetworkString("notify")

local meta = FindMetaTable("Player")

function meta:notify(message, type, length, removeDelay)
	local length = length or 3

	net.Start("notify")
		net.WriteString(message)
		net.WriteInt(type, 8)
		net.WriteInt(length, 8)
		net.WriteBool(tobool(removeDelay))
	net.Send(self)
end

function notifyAll(message, type, length, removeDelay)
	for k,v in pairs(player.GetAll()) do
		v:notify(message, type, length, removeDelay)
	end
end