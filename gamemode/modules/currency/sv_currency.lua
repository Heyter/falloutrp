
util.AddNetworkString("addCaps")

local meta = FindMetaTable("Player")

function meta:addCaps(amount)
	self.playerData.bottlecaps = self:getCaps() + amount

	net.Start("addCaps")
		net.WriteInt(self:getCaps(), 32)
	net.Send(self)
	
	MySQLite.query("UPDATE playerdata SET bottlecaps = " ..self:getCaps() .." WHERE steamid = '" ..self:SteamID() .."'")
end

function dropCaps(ply, text)
	local split = string.Split(text, " ")
	if (#split == 2) and (split[1] == "/dropmoney") and (tonumber(split[2])) and (tonumber(split[2]) > 0) then
		local amount = tonumber(split[2])
		if ply:canAfford(amount) then
			ply:addCaps(-amount)
			createLoot(ply:GetPos() + (ply:GetForward() * 25), {createItem(0, amount)})
			
			return ""
		else
			ply:notify("You do not have that many caps.", NOTIFY_ERROR)
		end
	end
end
hook.Add("PlayerSay", "dropCaps", dropCaps)