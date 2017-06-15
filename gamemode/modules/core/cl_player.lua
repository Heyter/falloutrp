
// Keep track of how much player data has been loaded
local dataCount = 0

local meta = FindMetaTable("Player")

function meta:getName()
	return self.playerData.name or LocalPlayer():Name()
end

function meta:loadPlayerDataCount()
	dataCount = dataCount + 1

	// We have finished loading playerData, inventory, and quests. Configure the player, send their data to all clients
	if dataCount == 3 then
		net.Start("loadPlayerDataFinish")

		net.SendToServer()

		// Reset the data count incase they load again, ie: faction change
		dataCount = 0
	end
end

net.Receive("customCollision", function()
	timer.Simple(1, function()
		LocalPlayer():SetAvoidPlayers(true)
	end)
end)

net.Receive("loadPlayerData", function()
	local data = net.ReadTable()
	local ply = net.ReadEntity()

	if ply then
		ply.playerData = data
	end

	if LocalPlayer() == ply then
		LocalPlayer():loadPlayerDataCount()
	end
end)

net.Receive("loadClientside", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()
	local experience = net.ReadInt(32)
	local strength = net.ReadInt(8)
	local equipped = net.ReadTable()

	local kills = net.ReadInt(16)
	local rank = net.ReadString()

	//local title = net.ReadTable()

	ply.playerData = ply.playerData or {}
	ply.playerData.name = name
	ply.playerData.experience = experience
	ply.playerData.strength = strength
	ply.equipped = equipped

	ply.playerData.playerkills = kills
	ply.playerData.rank = rank

	//ply.title = title
end)

net.Receive("sendClientside", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()
	local experience = net.ReadInt(32)
	local strength = net.ReadInt(8)
	local equipped = net.ReadTable()

	local kills = net.ReadInt(16)
	local rank = net.ReadString()

	if ply != LocalPlayer() then
		ply.playerData = ply.playerData or {}
		ply.playerData.name = name
		ply.playerData.experience = experience
		ply.playerData.strength = strength
		ply.equipped = equipped

		ply.playerData.playerkills = kills
		ply.playerData.rank = rank
	end
end)

net.Receive("revealWorld", function()
	LocalPlayer().hideWorld = false
end)

local blur = Material("pp/blurscreen")
local blurAmount = 5

hook.Add("HUDPaint", "LoadingBackground", function()
	if LocalPlayer().hideWorld or !LocalPlayer().playerData then
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(blur)
		for i = 1, 3 do
			blur:SetFloat("$blur", (i / 3) * (blurAmount))
			blur:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end

		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(45, 25, 10, 253))
	end
end)
