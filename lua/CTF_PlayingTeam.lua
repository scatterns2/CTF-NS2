Script.Load("lua/PlayingTeam.lua")

local networkVars = {

	numFlagsCaptured = "integer (0 to 99)",

}

local orig_PlayingTeam_OnInitialized = PlayingTeam.OnInitialized
function PlayingTeam:OnInitialized()
    orig_PlayingTeam_OnInitialized(self)
    self.numFlagsCaptured = 0
end

function PlayingTeam:SpawnBaseFlag(self, techPoint)

    local techPointOrigin = Vector(techPoint:GetOrigin())
    
    local closestPoint = nil
    local closestPointDistance = 0
    
    for index, current in ientitylist(Shared.GetEntitiesWithClassname("ResourcePoint")) do
    
        // The resource point and tech point must be in locations that share the same name.
        local sameLocation = techPoint:GetLocationName() == current:GetLocationName()
        if sameLocation then
        
            local pointOrigin = Vector(current:GetOrigin())
            local distance = (pointOrigin - techPointOrigin):GetLength()
            
            if current:GetAttached() == nil and closestPoint == nil or distance < closestPointDistance then
            
                closestPoint = current
                closestPointDistance = distance
                
            end
            
        end
        
    end
    
    // Now spawn appropriate resource tower there
    if closestPoint ~= nil then
        return closestPoint:SpawnFlagForTeam(self) 
    end
    
    return nil
    
end

function PlayingTeam:AddFlagCapture()
    self.numFlagsCaptured = self.numFlagsCaptured + 1
    Print("Team %d, has captured a flag. They now have %d flags captured", self:GetTeamNumber(), self.numFlagsCaptured)
end

function PlayingTeam:GetNumFlagsCaptured()
    return self.numFlagsCaptured
end

function PlayingTeam:GetHasTeamWon()

    PROFILE("PlayingTeam:GetHasTeamWon")

    if GetGamerules():GetGameStarted() and not Shared.GetCheatsEnabled() then
        local numFlags = self:GetNumFlagsCaptured()
        if numFlags == kCaptureWinTotal then            
            return true 
        end
    end    
    return false
end