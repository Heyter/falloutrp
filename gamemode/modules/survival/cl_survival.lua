
net.Receive("setHunger", function()
	local hunger = net.ReadInt(8)
	
	LocalPlayer().playerData.hunger = hunger
end)

net.Receive("setThirst", function()
	local thirst = net.ReadInt(8)
	
	LocalPlayer().playerData.thirst = thirst
end)