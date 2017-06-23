include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()
end

local indicators = {
	[1] = {"!", Color(241, 196, 15, 255)},
	[2] = {"?", Color(241, 196, 15, 255)},
	[3] = {"!", Color(255, 255, 255, 255)}
}

hook.Add("PostDrawOpaqueRenderables", "QuestHead", function()
	for _, ent in pairs (ents.FindByClass("questgiver")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local name = ent:GetNickname()

			// Draw Name
			local ang = ent:GetAngles()

			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), -90)

			cam.Start3D2D(ent:GetPos() + ent:GetUp()*110, ang, 0.35)
				draw.SimpleTextOutlined(name or "Quest Giver", "FalloutRP4", 0, 0, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
			cam.End3D2D()

			// Draw Quest Indicator
			local indicator
			local unavailable = {}

			for k,v in pairs(QUESTS:getGiverQuests(name)) do
				if !LocalPlayer():hasQuest(v) then
					if LocalPlayer():metQuestPreconditions(v) then
						indicator = 1
						break
					else
						table.insert(unavailable, v)
					end
				elseif !LocalPlayer():isQuestComplete(v) and LocalPlayer():finishedQuestTasks(v) then
					indicator = 2
				end
			end

			if !indicator and #unavailable > 0 then
				indicator = 3
			end

			if indicator then
				cam.Start3D2D(ent:GetPos() + ent:GetUp()*140, ang, 0.35)
					draw.SimpleTextOutlined(indicators[indicator][1], "FalloutRP7", 0, 0, indicators[indicator][2], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				cam.End3D2D()

				local ang = ent:GetAngles()

				ang:RotateAroundAxis(ang:Forward(), 90)
				ang:RotateAroundAxis(ang:Right(), 90)

				cam.Start3D2D(ent:GetPos() + ent:GetUp()*140, ang, 0.35)
					draw.SimpleTextOutlined(indicators[indicator][1], "FalloutRP7", 0, 0, indicators[indicator][2], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))
				cam.End3D2D()
			end
		end
	end
end)
