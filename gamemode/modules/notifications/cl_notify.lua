
local meta = FindMetaTable("Player")

local notifySounds = {
	[NOTIFY_GENERIC] = "buttons/button15.wav",
	[NOTIFY_ERROR] = "buttons/button10.wav",
	[NOTIFY_UNDO] = "buttons/button15.wav",
	[NOTIFY_HINT] = "buttons/button15.wav",
	[NOTIFY_CLEANUP] = "buttons/button10.wav"
}

function meta:notify(message, type, length, removeDelay)
	local length = length or 3

	if removeDelay then
		self:removeVguiDelay()
	end

	GAMEMODE:AddNotify(message, type, length)
	surface.PlaySound(notifySounds[type])
end

net.Receive("notify", function()
	local message = net.ReadString()
	local type = net.ReadInt(8)
	local length = net.ReadInt(8)
	local removeDelay = net.ReadBool()
	
	LocalPlayer():notify(message, type, length, removeDelay)
end)