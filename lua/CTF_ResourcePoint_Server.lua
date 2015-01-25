Script.Load("lua/ResourcePoint_Server.lua")

function ResourcePoint:SpawnFlagForTeam(team)

    if self:GetAttached() == nil then
    
        // Force create because entity may not be cleaned up from round reset
        local flag = CreateEntityForTeam(kTechId.Flag, self:GetOrigin(), team:GetTeamNumber(), nil)
        
        if flag then      
            
            self:SetAttached(flag)
            
            return flag
            
        end       
    else
        Print("ResourcePoint:SpawnFlagForTeam(%s): Entity %s already attached.", EnumToString(kTechId, team), self:GetAttached():GetClassName()) 
    end
    return nil
end