
// Converts a boolean to a number
function util.boolToNumber(bool)
	if bool then
		return 1
	else
		return 0
	end
end

// Get the position of an entity's 'foot'
function util.getFeetPosition(ent)
	local trace = util.traceDown(ent)

	return trace and trace.HitPos
end

// Run a trace from the player directly down, to see what they're standing on
function util.traceDown(ent)
	local data = {
		start = ent:GetPos(),
		endpos = ent:GetPos() - Vector(0, 0, 150)
	}

	return util.TraceLine(data)
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
	ent.beingRemoved = true // Don't allow players to use the item while it still exists

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

if SERVER then
	function util.facePlayer(npc, ply)
		local vec1 = npc:GetPos()
		local vec2 = ply:GetShootPos()

		npc:SetAngles((vec1 - vec2):Angle() - Angle(0, 180, 0))
	end
end

if CLIENT then
	function util.cleanupFrame(frame)
		if frame then
			if frame.RemoveOverride then
				frame:RemoveOverride()
			else
				frame:Remove()
				frame = nil
			end
		end
	end

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

	// Return PEPBOY_COLOR with 255 alpha
	function util.getPepboyColor()
		return Color(PEPBOY_COLOR.r, PEPBOY_COLOR.g, PEPBOY_COLOR.b, 255)
	end

	function util.textWrap(text, size, font)
	  surface.SetFont(font)

	  local splitText = string.Split(text, " ")
	  local wrappedText = ""

	  local newLine = ""
	  for i = 1, #splitText do
	    local temp = "" ..newLine ..splitText[i]

	    if surface.GetTextSize(temp) > size then
	      wrappedText = wrappedText ..newLine .."\n"
	      newLine = "" ..splitText[i]
	    else
	      newLine = newLine .." " ..splitText[i]
	    end
	  end

	  wrappedText = string.Trim(wrappedText ..newLine, " ")

	  return wrappedText
	end
end

if SERVER then
	function util.spawnItAll()
		for k,v in pairs(CHEST_LOCATIONS) do
			local ent = ents.Create("chest")
			ent:SetPos(v.Position)
			ent:SetAngles(v.Angles)
			ent:Spawn()
		end

		for k,v in pairs(VEINS) do
			for a,b in pairs(v.Positions) do
				local ent = ents.Create("vein")
				ent:SetModel("models/props_mining/rock002.mdl")
				ent:SetPos(b.Position)
				ent:Spawn()
			end
		end
		for k,v in pairs(NPCS.npcs) do
			for a, b in pairs(v.Positions) do
				local ent = ents.Create("vein")
				ent:SetPos(b.Position)
				ent:Spawn()
				ent:SetModel("models/props_borealis/bluebarrel001.mdl")
			end
		end
	end
end
