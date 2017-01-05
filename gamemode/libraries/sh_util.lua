
function util.positive(amount)
	return amount and amount > 0
end

if CLIENT then
function util.saveMousePos()
	local mouseX, mouseY = input.GetCursorPos()
	LocalPlayer().savedMouseX = mouseX
	LocalPlayer().savedMouseY = mouseY
end

function util.restoreMousePos()
	local mouseX, mouseY = LocalPlayer().savedMouseX, LocalPlayer().savedMouseY
	
	if mouseX and mouseY then
		input.SetCursorPos(mouseX, mouseY)
	end
end
end