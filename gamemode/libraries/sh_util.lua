

function util.roll(within, max)
	local max = max or 100
	local multiplier = 1000 // So decimal points actually make a difference

	return math.random(1, max * multiplier) <= (within * multiplier)
end

function util.positive(amount)
	return isnumber(amount) and amount and amount > 0
end

function util.greaterThanOne(amount)
	return amount and amount > 1
end

function util.isInt(n)
	return isnumber(n) and n == math.floor(n)
end

function util.getWinningKeyTie(tab, currentKey, currentValue)
	local highest = -10000
	local winner = nil

	for k, v in pairs( tab ) do
		if ( v > highest ) then 
			winner = k
			highest = v
		end
	end

	//The highest is the same as the current controller, so return the current controller.
	if currentValue == highest then
		return currentKey
	end
	
	return winner
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