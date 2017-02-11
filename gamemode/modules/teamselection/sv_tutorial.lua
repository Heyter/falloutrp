
util.AddNetworkString("openTutorial")

local meta = FindMetaTable("Player")

function meta:openTutorial()
	net.Start("openTutorial")
	net.Send(self)
end	

// Spawn token shop
hook.Add("InitPostEntity", "spawnTutorial", function()
	timer.Simple(1, function()
		local ent = ents.Create("tutorial")
		ent:SetPos(TUTORIAL["Position"])
		ent:SetAngles(TUTORIAL["Angles"])
		ent:Spawn()
		ent:SetModel(TUTORIAL["Model"])
	end)
end)