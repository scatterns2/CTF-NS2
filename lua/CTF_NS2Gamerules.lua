Script.Load("lua/NS2Gamerules.lua")
if Server then
    Script.Load("lua/CTF_PlayingTeam.lua")
end

if Server then
    local orig_NS2Gamerules_EndGame = NS2Gamerules.EndGame
    function NS2Gamerules:EndGame(winningTeam)
        orig_NS2Gamerules_EndGame(self, winningTeam)
        self.team1Won = nil
        self.team2Won = nil
    end
    
    function NS2Gamerules:CheckGameStart()
    
        if self:GetGameState() == kGameState.NotStarted or self:GetGameState() == kGameState.PreGame then
            
            local team1Players = self.team1:GetNumPlayers()
            local team2Players = self.team2:GetNumPlayers()
                  
            if (((team1Players >= 1) and (team2Players >= 1)) or Shared.GetCheatsEnabled()) then
            
                if self:GetGameState() == kGameState.NotStarted then
                    self:SetGameState(kGameState.PreGame)
                end
                
            else
            
                if self:GetGameState() == kGameState.PreGame then
                    self:SetGameState(kGameState.NotStarted)
                end
                                
            end
            
        end
        
    end

    local orig_NS2Gamerules_CheckGameEnd = NS2Gamerules.CheckGameEnd
    function NS2Gamerules:CheckGameEnd()
        orig_NS2Gamerules_CheckGameEnd(self)
        if self:GetGameStarted() and self.timeGameEnded == nil and not Shared.GetCheatsEnabled() and not self.preventGameEnd then
            local team1Won = self.team1Won or self.team1:GetHasTeamWon()
            local team2Won = self.team2Won or self.team2:GetHasTeamWon()

            if team1Won or team2Won then
            
                -- After a team has entered a win condition, they can not lose it
                self.team1Won = team1Won
                self.team2Won = team2Won
            end
        end
        if self.team1Won then
            self:EndGame( self.team1 )
        elseif self.team2Won then
            self:EndGame( self.team2 )
        end
    end
end