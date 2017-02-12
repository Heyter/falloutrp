hook.Remove("PlayerCanHearPlayersVoice" , "Wat" , function( p1 , p2 )  
    return (p1:GetPos():Distance(p2:GetPos()) <= 2000) 
end ) 