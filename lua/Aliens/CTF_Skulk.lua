Script.Load("lua/Skulk.lua")

local kMaxSpeed = 10

local orig_Skulk_InitWeapons = Skulk.InitWeapons
function Skulk:InitWeapons()

    Alien.InitWeapons(self)
    
    self:GiveItem(BiteLeap.kMapName)
    self:GiveItem(Parasite.kMapName)
    self:SetActiveWeapon(BiteLeap.kMapName)    
    
end

function Skulk:GetMaxSpeed(possible)

    if possible then
        return kMaxSpeed
    end

    local maxspeed = kMaxSpeed
    if self:GetIsWallWalking() then
        maxspeed = maxspeed + 0.25
    end
    
    if self.movementModiferState then
        maxspeed = maxspeed * 0.5
    end
    
    return maxspeed
    
end
