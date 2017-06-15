
TOKEN_SHOP = {
	Position = Vector(-8716, 9698, 0),
	Angles = Angle(0, 90, 0),
	Model = "models/breen.mdl",

	TokensNeeded = {
		FactionChange = 5,
		NameChange = 5,
		Title = 10,
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
