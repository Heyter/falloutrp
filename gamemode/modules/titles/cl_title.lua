
local frameW, frameH = 800, 600
local padding = 40

function openTitleCreation()
	local preview // The text previewed of name and title combined

	local frame = vgui.Create("FalloutRP_Menu")
	frame:SetPos(ScrW()/2 - frameW/2, ScrH()/2 - frameH/2)
	frame:SetSize(frameW, frameH)
	frame:SetFontTitle("FalloutRP3", "Title Creation")
	frame:AddCloseButton()
	frame:MakePopup()

	local instructions = vgui.Create("DLabel", frame)
	instructions:SetFont("FalloutRP3")
	instructions:SetTextColor(COLOR_SLEEK_GREEN)
	instructions:SetText("Enter Title")
	instructions:SizeToContents()
	instructions:SetPos(frameW/2 - instructions:GetWide()/2, 100)

	local entry = vgui.Create("DTextEntry", frame)
	entry:SetSize(350, 80)
	entry:SetPos(frameW/2 - entry:GetWide()/2, 100 + instructions:GetTall() + padding)
	entry:SetFont("FalloutRP4")
	entry:SetText("Example")
	entry:SetUpdateOnType(true) // Call OnValueChange each type the user removes/adds a letter
	entry.OnValueChange = function(self, value)
		// Update the preview
		preview:updateText()
	end
	entry.AllowInput = function(self, char)
		// Disallow bad characters
		if table.HasValue(TITLE_INVALID, char) then
			LocalPlayer():notify("The character " ..char .." is not allowed in a title.", NOTIFY_ERROR)
			return true
		elseif #self:GetValue() > TITLE_MAX then
			LocalPlayer():notify("Title cannot exceed " ..TITLE_MAX .." characters.", NOTIFY_ERROR)
			return true
		end
	end

	local prefix = vgui.Create("DCheckBoxLabel", frame)
	prefix:SetSize(50, 50)
	prefix:SetPos(frameW/2 - prefix:GetWide()/2, 100 + instructions:GetTall() + padding + entry:GetTall() + padding)
	prefix:SetFont("FalloutRP3")
	prefix:SetTextColor(COLOR_SLEEK_GREEN)
	prefix:SetText("Prefix")
	prefix:SetValue(true)
	prefix.OnChange = function(self, value)
		// Update preview
		preview:updateText()
	end

	preview = vgui.Create("DLabel", frame)
	preview:SetFont("FalloutRP4")
	preview:SetTextColor(COLOR_SLEEK_GREEN)
	preview:SetText(LocalPlayer():getName())
	preview:SizeToContents()
	preview:SetPos(frameW/2 - preview:GetWide()/2, 100 + instructions:GetTall() + padding + entry:GetTall() + padding + prefix:GetTall() + padding)
	function preview:updateText()
		local title = entry:GetValue()
		local checked = prefix:GetChecked()

		if checked then
			preview:SetText(title ..LocalPlayer():getName())
		else
			preview:SetText(LocalPlayer():getName() ..title)
		end

		// Resize/reposition
		preview:SizeToContents()
		preview:SetPos(frameW/2 - preview:GetWide()/2, 100 + instructions:GetTall() + padding + entry:GetTall() + padding + prefix:GetTall() + padding)
	end

	local submit = vgui.Create("FalloutRP_Button", frame)
	submit:SetSize(80, 50)
	submit:SetFont("FalloutRP3")
	submit:SetText("Finish")
	submit:SetPos(frameW/2 - submit:GetWide()/2, 100 + instructions:GetTall() + padding + entry:GetTall() + padding + prefix:GetTall() + padding + preview:GetTall() + padding)
	submit.DoClick = function()
		net.Start("createTitle")
			net.WriteString(entry:GetValue())
			net.WriteBool(prefix:GetChecked())
		net.SendToServer()

		frame:Remove()
	end
end

// Handle prefix and concatenation
function displayTitle(name, tbl)
	local prefix = tobool(tbl.prefix)
	local title = tbl.title

	if prefix then
		return title ..name
	else
		return name ..title
	end
end

net.Receive("updateTitle", function()
	local ply = net.ReadEntity()
	local title = net.ReadTable()

	ply.title = title
end)

net.Receive("updateTitles", function()
	local titles = net.ReadTable()

	LocalPlayer().titles = titles
end)
