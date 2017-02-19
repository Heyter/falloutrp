
util.AddNetworkString("roll")

local function roll(ply, text)
	if string.sub(text, 1, #"/roll") == "/roll" then
		local dice = math.random(1, 100)
		for k,v in pairs(player.GetAll()) do
			if v:GetPos():Distance(ply:GetPos()) < 500 then
				net.Start("roll")
					net.WriteString(ply:getName())
					net.WriteInt(dice, 8)
				net.Send(v)
			end
		end
		
		return ""
	end
end
hook.Add("PlayerSay", "Roll", roll)