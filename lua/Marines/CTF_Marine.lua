Script.Load("lua/Marine.lua")
Script.Load("lua/Weapons/MarineStructureAbility.lua")
Script.Load("lua/Marines/AvatarMoveMixin.lua")
Script.Load("lua/CloakableMixin.lua")
Script.Load("lua/Marines/CTF_MarineAbilities.lua")
Script.Load("lua/Flags/CTF_FlagBearerMixin.lua")

if Client then
    Script.Load("lua/Marines/CTF_Marine_Client.lua")
end

local networkVars = {

    armorBase = "float (0 to 2045 by 1)",
	healthBase = "float (0 to 250 by 1)",
	speedBase = "float (0 to 25 by 0.1)",
	hasNanoShield = "boolean",
	hasMedicHeal = "boolean",
	camouflaged = "boolean",
	hasCloakAbility = "boolean",
    hasCamouflage = "boolean",
}
AddMixinNetworkVars(CloakableMixin, networkVars)
AddMixinNetworkVars(AvatarMoveMixin, networkVars)
AddMixinNetworkVars(FlagBearerMixin, networkVars)

local orig_Marine_OnInitialized = Marine.OnInitialized
function Marine:OnInitialized()
	
	self.classType = self.classType or kClassTypes.Engineer
  
	local classType = kClassTypesData[self.classType]
	
	self.weaponPrimary 	 = classType and classType.weaponPrimary
	self.weaponSecondary = classType and classType.weaponSecondary
	self.weaponTertiary  = classType and classType.weaponTertiary
	self.armorBase		 = classType and classType.armorBase 
	self.speedBase	 	 = classType and classType.speedBase
	self.healthBase	 	 = classType and classType.healthBase 

	self.classItem 		 = classType and classType.classItem
	self.classSpecial    = classType and classType.classSpecial
	self.marineModel     = classType and classType.marineModel
	self.marineGraph     = classType and classType.marineGraph
	
	self.hasNanoShield = (self.classType == kClassTypes.Assault)
	self.hasMedicHeal = (self.classType == kClassTypes.Medic)
	self.hasCloakAbility = (self.classType == kClassTypes.Recon)

	InitMixin(self, AvatarMoveMixin)
    InitMixin(self, CloakableMixin)
	InitMixin(self, FlagBearerMixin)

	orig_Marine_OnInitialized(self)
	
	self:SetMaxHealth(self.healthBase)
	self:SetHealth(self.healthBase)
	self:SetMaxArmor(self.armorBase)
	
	self.timeLastNano = 0
    self.timeLastHealed = 0
	self.timeLastCloaked = 0
	
end
	
function Marine:GetArmorAmount()
	return self.armorBase	
end
	
function Marine:SetMaxArmor()
    return self.armorBase
end

function Marine:GetMaxSpeed()
    return self.speedBase
end

function Marine:SetMaxHealth()
	return self.healthBase
end

local orig_Marine_InitWeapons = Marine.InitWeapons
function Marine:InitWeapons()
   
   Player.InitWeapons(self)
	
	self:GiveItem(self.weaponPrimary)
	self:GiveItem(self.weaponAuxillary)
    self:GiveItem(self.weaponSecondary)
    self:GiveItem(self.weaponTertiary)
    self:GiveItem(self.classItem)
	self:GiveItem(self.classSpecial)

    self:SetQuickSwitchTarget(self.weaponSecondary)
    self:SetActiveWeapon(self.weaponPrimary)

end

function Marine:SetArmor()
   return self.armorBase
end

function Marine:SetArmor()
   return self.armorBase
end

function Marine:SetMaxArmor()
   return self.armorBase
end

function Marine:Buy()

    // Don't allow display in the ready room, or as phantom
    if self:GetIsLocalPlayer() then
    
        // The Embryo cannot use the buy menu in any case.
        if self:GetTeamNumber() ~= 0  then
        
            if not self.buyMenu  then
            
                self.buyMenu = GetGUIManager():CreateGUIScript("Marines/GUIMarineClassMenu")
                MouseTracker_SetIsVisible(true, "ui/Cursor_MenuDefault.dds", true)
                
            else
                self:CloseMenu()
            end
            
        else
            self:PlayEvolveErrorSound()
        end
        
    end
    
end

local orig_Marine_OverrideInput = Marine.OverrideInput
function Marine:OverrideInput(input)

	// Always let the MarineStructureAbility override input, since it handles client-side-only build menu
	local buildAbility = self:GetWeapon(MarineStructureAbility.kMapName)

	if buildAbility then
		input = buildAbility:OverrideInput(input)
	end
	
	return Player.OverrideInput(self, input)
        
end

local orig_Marine_UpdateGhostModel = MarineUpdateGhostModel
function Marine:UpdateGhostModel()

    self.currentTechId = nil
    self.ghostStructureCoords = nil
    self.ghostStructureValid = false
    self.showGhostModel = false
    
    local weapon = self:GetActiveWeapon()
	
	if weapon then
		if weapon:isa("MarineStructureAbility") then
		
			self.currentTechId = weapon:GetGhostModelTechId()
			self.ghostStructureCoords = weapon:GetGhostModelCoords()
			self.ghostStructureValid = weapon:GetIsPlacementValid()
			self.showGhostModel = weapon:GetShowGhostModel()

			return weapon:GetShowGhostModel()
			
		elseif weapon:isa("LayMines") then
    
			self.currentTechId = kTechId.Mine
			self.ghostStructureCoords = weapon:GetGhostModelCoords()
			self.ghostStructureValid = weapon:GetIsPlacementValid()
			self.showGhostModel = weapon:GetShowGhostModel()
    
		end	
	end

end

if Client then

    function Marine:GetShowGhostModel()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") then
            return weapon:GetShowGhostModel()       
		end
		
        return false
        
    end
	
    function Marine:GetGhostModelOverride()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") and weapon.GetGhostModelName then
            return weapon:GetGhostModelName(self)

						
        end
        
    end
    
    function Marine:GetGhostModelTechId()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") then
            return weapon:GetGhostModelTechId()		
        end
        
    end
   
    function Marine:GetGhostModelCoords()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") then
            return weapon:GetGhostModelCoords()		
        end
        
    end
    
    function Marine:GetLastClickedPosition()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") then
            return weapon.lastClickedPosition
        end
    end

    function Marine:GetIsPlacementValid()
    
        local weapon = self:GetActiveWeapon()
        if weapon and weapon:isa("MarineStructureAbility") then
            return weapon:GetIsPlacementValid()		
        end
    
    end

end

if Server then

    function Marine:ProcessClassBuyAction(message)
	
	    local extraValues = {
		    classType = message.classType
	    }
	    self:Replace(Marine.kMapName,self:GetTeamNumber(), false, nil,extraValues
	    )
	end
end

local origGetHostStructure = GetHostStructure
function GetHostStructureFor(entity, techId)

    local hostStructures = {}
	table.copy(GetEntitiesForTeamWithinRange("CommandStation", entity:GetTeamNumber(), entity:GetOrigin(), kClassMenuUseRange), hostStructures, true)
    table.copy(GetEntitiesForTeamWithinRange("PrototypeLab", entity:GetTeamNumber(), entity:GetOrigin(), PrototypeLab.kResupplyUseRange), hostStructures, true)
    
    if table.count(hostStructures) > 0 then
    
        for index, host in ipairs(hostStructures) do
        
            // check at first if the structure is hostign the techId:
            if GetHostSupportsTechId(entity,host, techId) then
                return host
            end
        
        end
            
    end
    
    return nil

end

local origGetIsCloseToMenuStructure = GetIsCloseToMenuStructure
function GetIsCloseToMenuStructure(player)
    
    local ptlabs = GetEntitiesForTeamWithinRange("PrototypeLab", player:GetTeamNumber(), player:GetOrigin(), PrototypeLab.kResupplyUseRange)
    local commandchairs = GetEntitiesForTeamWithinRange("CommandStation", player:GetTeamNumber(), player:GetOrigin(), kClassMenuUseRange)
    
    return (ptlabs and #ptlabs > 0) or (commandchairs and #commandchairs > 0)

end

local orig_Marine_HandleButtons
function Marine:HandleButtons(input)

    PROFILE("Marine:HandleButtons")
    
    Player.HandleButtons(self, input)
    
	self:ClassAbility(input)
	
end

Class_Reload("Marine", networkVars)