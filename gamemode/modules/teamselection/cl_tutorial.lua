
local frameW, frameH = 800, 600
local nameFrameW, nameFrameH = 800, 600
local wait = 5 // How many seconds a player should be on each image before being able to continue

local images = {
	{image = "falloutrp/tutorial/pipboy1.jpg", description = " The pipboy contains your player data, inventory, and settings.\n It can be accessed by hitting F4.\n In this tab you can equip, use, and drop items."},
	{image = "falloutrp/tutorial/pipboy2.jpg", description = " On this screen you can view your hunger, thirst, level, and your rank.\n A player's rank is determined by their number of player kills."},
	{image = "falloutrp/tutorial/bank.jpg", description = " The bank is very important to use because you DROP all your items when you DIE.\n This is one way you can ensure you will keep your epic loot!"},
	{image = "falloutrp/tutorial/crafting1.jpg", description = " Crafting is a way to make your own weapons, apparel, aid, ammo, and materials\n However these items may not always have the best stats."},
	{image = "falloutrp/tutorial/crafting2.jpg", description = " Once you use the crafting table you choose which type of item you want to make.\n Then the items of that type will show if you have the required level.\n You will also see how many materials you still need to craft it."},
	{image = "falloutrp/tutorial/token.jpg", description = " At the token shop you change your faction or name. You can also create a title.\n WARNING! You only have 1 free faction change!"},
	{image = "falloutrp/tutorial/factory.jpg", description = " Factories are way to get items and are fought over by all 3 factions.\n There are weapon, apparel, ammo, material, and cap factories.\n You can initiate a 'king of the hill' battle by typing /war."},
	{image = "falloutrp/tutorial/npc1.jpg", description = " There are many npcs throughout the wasteland, ranging in difficulty and loot.\n Low level npcs include rats, geckos (not fire and green), mantises, etc."},
	{image = "falloutrp/tutorial/npc2.jpg", description = " The higher level npcs include green and fire geckos, cazadors, and deathclaws.\n It is not recommended to fight these at a lower level!"},
	{image = "falloutrp/tutorial/rock1.jpg", description = " There are veins scattered all over the map which you mine with a pickaxe.\n You can obtain rock and copper from these."},
	{image = "falloutrp/tutorial/rock2.jpg", description = " There are also rare veins which you have to keep your eye out for.\n You can mine these and obtain silver, gold, and crystal!"},
	{image = "falloutrp/tutorial/herb.jpg", description = " You can find herbs and plants around the map which you can scavenge.\n By using them, you might find aid, plant materials, etc."},
	{image = "falloutrp/tutorial/wood.jpg", description = " You can find wood scraps around the map which you can scavenge.\n By using them, you might find wood materials."},
	{image = "falloutrp/tutorial/metal.jpg", description = " You can find metal scraps around the map which you can scavenge.\n By using them, you might find scrap metal or even weapons!"},
	{image = "falloutrp/tutorial/chest.jpg", description = " If you get really lucky you might even come across chests.\n Keep your eyes open! Chests have an abundance of great items.\n Some might be locked and you will need a lockpick."},
	{image = "falloutrp/tutorial/warning.png", description = " WARNING! The most danagerous enemy in this game is OTHER PLAYERS!\n It is HIGHLY recommended that you turn on PvP protection while you can.\n It is very easy to lose your guard and get killed and lose your items!"},
}

local function timeButton(button)
	if !IsValid(button) then return end
	if !button.time then button.time = wait end
	if button.time == 1 then button:SetText("Continue") button:SetDisabled(false) return end
	
	button.time = button.time - 1
	button:SetText("Continue (" ..button.time ..")")
	
	timer.Simple(1, function()
		timeButton(button)
	end)
end

function tutorialSlideShow(newPlayer)
	if frame then
		frame:Remove()
		frame = nil
	end

	local frame = vgui.Create("FalloutRP_Menu", main)
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "TUTORIAL")
	if !newPlayer then
		frame:AddCloseButton()
	end
	frame:MakePopup()
	
	local index = 1
	 
	local imgPanel = vgui.Create("DPanel", frame)
	imgPanel:SetSize(700, 400)
	imgPanel:SetPos(50, 50)
	imgPanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material(images[index]["image"]))
		surface.DrawTexturedRect(0, 0, w, h)
		
		surface.SetDrawColor(COLOR_AMBER)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
	
	local info = vgui.Create("DLabel", frame)
	info:SetFont("FalloutRP2")
	info:SetPos(50, 460)
	info:SetTextColor(COLOR_AMBER)
	info:SetText(images[index]["description"])
	info:SizeToContents()
	
	local button = vgui.Create("FalloutRP_Button", frame)
	button:SetSize(80, 40)
	button:SetPos(frame:GetWide()/2 - button:GetWide()/2, 550 - button:GetTall()/2)
	button:SetText("Continue")
	button.DoClick = function(self)
		if index < #images then
			index = index + 1
			info:SetText(images[index]["description"])
			info:SizeToContents()
			
			if newPlayer then
				self:SetDisabled(true)
				self.time = wait
				timeButton(self)
			end
		else
			frame:Remove()
			frame = nil
			
			// Now allow them to choose another team
			if newPlayer then
				teamSelection()
			end
		end
	end
	if newPlayer then
		button:SetDisabled(true)
	
		timeButton(button)
	end
end

net.Receive("openTutorial", function()
	tutorialSlideShow(false) // Opened via npc
end)