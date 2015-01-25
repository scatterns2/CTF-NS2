Script.Load("lua/Marine_Client.lua")

// Bring up buy menu
function Marine:BuyMenu(structure)
    
    // Don't allow display in the ready room
    if self:GetTeamNumber() ~= 0 and Client.GetLocalPlayer() == self and not self.hasFlag then
    
        if not self.buyMenu then
        
            self.buyMenu = GetGUIManager():CreateGUIScript("GUIMarineBuyMenu")
            
            MarineUI_SetHostStructure(structure)
            
            if structure then
                self.buyMenu:SetHostStructure(structure)
            end
            
            self:TriggerEffects("marine_buy_menu_open")
            
            TEST_EVENT("Marine buy menu displayed")
            
        end
        
    end
    
end

