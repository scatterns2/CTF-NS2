
local kHealRadius = 14
local kHealAmount = 50
local kMedicAbilityCooldown = 15
local kScoutAbilityCooldown = 15
local kAssaultAbilityCooldown = 15



function Marine:PerformMedicHeal()

    
    // priority on players
    for _, player in ipairs(GetEntitiesForTeamWithinRange("Player", self:GetTeamNumber(), self:GetOrigin(), kHealRadius)) do
    
        if player:GetIsAlive() and player:GetHealth() < player:GetMaxHealth() then
		
			player:AddHealth(kHealAmount)
		
		end
        
    end

end

function Marine:ClassAbility(input)
	
	local abilityPressed = bit.band(input.commands,  Move.ToggleFlashlight) ~= 0
	
	if abilityPressed  then
		if self.hasNanoShield and self.timeLastNano + kAssaultAbilityCooldown < Shared.GetTime() then
				self.timeLastNano = Shared.GetTime()
				self:ActivateNanoShield()
		elseif self.hasMedicHeal and self.timeLastHealed + kMedicAbilityCooldown < Shared.GetTime() then
				self:PerformMedicHeal()
				self.timeLastHealed = Shared.GetTime()	
		elseif self.hasCloakAbility and self.timeLastCloaked + kScoutAbilityCooldown < Shared.GetTime() then
				self:TriggerCloak()
				self.timeLastCloaked = Shared.GetTime()	
		end
	end
end

