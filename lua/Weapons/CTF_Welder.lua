Script.Load("lua/Weapons/Marine/Welder.lua")

local origWelderPerformWeld = Welder.PerformWeld
function Welder:PerformWeld(player)

	origWelderPerformWeld(self)
	player:SetArmor(player:GetArmor() + kWelderFireDelay * kSelfWeldAmount)
	
end