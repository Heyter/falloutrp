
if !FACTORY then
	FACTORY = {} 
end

function FACTORY.ReceiveInfo()
	FACTORY.clientInfo = net.ReadTable()
end
net.Receive("factoryInfo", FACTORY.ReceiveInfo)
 
function FACTORY:DrawTerritories()
	if self.clientInfo then
		local location, time, controller, status, pos
			for place, tab in pairs(self.clientInfo) do
				location = place
				time = tab["Time"]
				controller = tab["Controller"]
				status = tab["Status"]
				pos = Vector(tab["Pos"][1], tab["Pos"][2], tab["Pos"][3])
				
				pos.z = pos.z + 100
				pos = pos:ToScreen()
				pos.y = pos.y

				controller = self:controllerToString(controller)
				
				draw.DrawText(location, "FalloutRP3", pos.x, pos.y - 150, self.Color_Place)
				if time > 0 then
					draw.DrawText(time, "FalloutRP3", pos.x, pos.y - 125, self.Color_Time)
				end
				if (controller == "Uncontested" && status != 1) or (controller != "Uncontested" and controller != team.GetName(LocalPlayer():Team()))  then
					controller = controller .."(/war)"
				end
				draw.DrawText(controller, "FalloutRP3", pos.x, pos.y - 100, self.Color_Controller)
				if status == 1 then
					draw.DrawText("CONTESTED", "FalloutRP3", pos.x, pos.y - 80, self.Color_Contested)
				end
				
			end
	end
end 

local function drawFactories()
	FACTORY:DrawTerritories()
end
hook.Add("HUDPaint", "DrawStuff", drawFactories)


