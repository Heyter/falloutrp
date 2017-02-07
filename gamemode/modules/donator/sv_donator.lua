
util.AddNetworkString("openTokenShop")

local meta = FindMetaTable("Player")

function meta:openTokenShop()
	net.Start("openTokenShop")
	
	net.Send(self)
end

// Spawn token shop
hook.Add("InitPostEntity", "spawnTokenShop", function()
	timer.Simple(1, function()
		local ent = ents.Create("donator")
		ent:SetPos(TOKEN_SHOP["Position"])
		ent:SetAngles(TOKEN_SHOP["Angles"])
		ent:Spawn()
		ent:SetModel(TOKEN_SHOP["Model"])
	end)
end)