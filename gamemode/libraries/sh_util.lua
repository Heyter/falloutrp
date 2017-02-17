
// Converts a boolean to a number
function util.boolToNumber(bool)
	if bool then
		return 1
	else
		return 0
	end
end

// Checks if a string has invalid characters
function util.hasInvalidChars(name)
	if name then
		for k, char in pairs(NAME_INVALID) do
			local start, finish = string.find(name, char, 1, true)
			if start then
				return char
			end
		end
	end
end

// Removes an entity by fading it's transparency (TAKES 1 second to remove entities)
function util.fadeRemove(ent)
	local increment = 25
	ent:SetColor(Color(255, 255, 255, 255 - increment))
	
	//Fade all the way to nothing
	for i = 1, 10 do
		timer.Simple(0.1 * i, function()
			local color = ent:GetColor()
			
			ent:SetRenderMode(RENDERMODE_TRANSALPHA)
			ent:SetColor(Color(color.r, color.g, color.b, color.a - increment))

			if i == 10 then
				SafeRemoveEntity(ent)
			end
		end)
	end
end

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