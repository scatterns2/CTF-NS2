Script.Load("lua/InfantryPortal.lua")

function InfantryPortal:GetCanTakeDamageOverride()
    return false
end