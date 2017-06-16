
TOKEN_SHOP = {
	Position = Vector(-8716, 9698, 0),
	Angles = Angle(0, 90, 0),
	Model = "models/breen.mdl",

	TokensNeeded = {
		FactionChange = 1,
		NameChange = 1,
		Title = 2,
	}
}

function getFactionTokens()
	return TOKEN_SHOP.TokensNeeded.FactionChange
end

function getNameTokens()
	return TOKEN_SHOP.TokensNeeded.NameChange
end

function getTitleTokens()
	return TOKEN_SHOP.TokensNeeded.Title
end
