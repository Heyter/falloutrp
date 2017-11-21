local indicators = {}
local lastcurtime = 0

local function invlerp(min, max, p)
	return (p - min) / (max - min)
end

local ANIMATION_FUNC = {}
ANIMATION_FUNC[1] = function(p)
	if p <= 0.2 then
		local x = invlerp(0, 0.2, p)
		return x*3*0.25 + 0.25
	else
		local x = invlerp(0.2, 1, p)
		return ((-x + 1) / 2) + 0.5
	end
end
ANIMATION_FUNC[2] = function(p)
	if p <= 0.2 then
		local x = invlerp(0, 0.2, p)
		return x*3*0.25 + 0.25
	else
		return 1
	end
end
ANIMATION_FUNC[3] = function(p)
	return 1-p
end

local fxmin, fxmax = -0.5, 0.5
local fymin, fymax = -0.5, 0.5
local fzmin, fzmax = .75, 1

local function spawnIndicator(text, color, pos, vel, ttl)
	local ind = {}

	ind.text = text
	ind.pos = Vector(pos.x, pos.y, pos.z)
	ind.vel = Vector(vel.x, vel.y, vel.z)
	ind.col = Color(color.r, color.g, color.b)

	ind.ttl = ttl
	ind.life = ttl
	ind.spawntime = CurTime()

	surface.SetFont("FalloutRP6")
	local w, h = surface.GetTextSize(text)

	ind.widthH = w/2
	ind.heightH = h/2

	table.insert(indicators, ind)
end

net.Receive("damagePopup", function()
    local ent = net.ReadEntity()
    local dmg = net.ReadInt(16)
    local pos = net.ReadVector()
    local force = net.ReadVector()
    local crit = net.ReadBool()
    local color = COLOR_AMBER

    if dmg == 0 then return end

    if dmg == -99 then
        dmg = "EVADE"
        color = COLOR_BROWN
    elseif crit then
        color = COLOR_RED
    end

    if IsValid(ent) then
        spawnIndicator(dmg, color, pos, force + Vector(math.Rand(fxmin, fxmax), math.Rand(fymin, fymax), math.Rand(fzmin, fzmax) * 1.5), 1.0, crit)
    end
end)

hook.Add("Tick", "damagePopupUpdate", function()
	local curtime = CurTime()
	local dt = curtime - lastcurtime
	lastcurtime = curtime

	if #indicators == 0 then return end

	local gravity = 1.0 * 0.05

	local ind
	for i=1, #indicators do
		ind = indicators[i]
		ind.life = ind.life - dt
		ind.vel.z = ind.vel.z - gravity
		ind.pos = ind.pos + ind.vel
	end

	local i = 1
	while i <= #indicators do
		if indicators[i].life < 0 then
			table.remove(indicators, i)
		else
			i = i + 1
		end
	end
end)

hook.Add("PostDrawTranslucentRenderables", "damagePopupDraw", function()
	if #indicators == 0 then return end

	local observer = (LocalPlayer():GetViewEntity() or LocalPlayer())
	local ang = observer:EyeAngles()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang = Angle( 0, ang.y, ang.r )

	local scale = 0.3
	local alphamul = 255
	local fanimation = ANIMATION_FUNC[GetGlobalInt("HDN_Animation", 0)]

	local cam_Start3D2D        = cam.Start3D2D
	local cam_End3D2D          = cam.End3D2D
	local surface_SetTextColor = surface.SetTextColor
	local surface_SetTextPos   = surface.SetTextPos
	local surface_DrawText     = surface.DrawText

	surface.SetFont("FalloutRP6")

	local ind
	for i=1, #indicators do
		ind = indicators[i]
		cam_Start3D2D(ind.pos, ang, scale * ((fanimation ~= nil) and fanimation((CurTime() - ind.spawntime) / ind.ttl) or 1))
			surface_SetTextColor(ind.col.r, ind.col.g, ind.col.b, (ind.life / ind.ttl * alphamul))
			surface_SetTextPos(-ind.widthH, -ind.heightH)
			surface_DrawText(ind.text)
		cam_End3D2D()
	end
end)
