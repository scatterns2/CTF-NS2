
class 'GUIFlagScore' (GUIScript)

local kFontScale = GUIScale(Vector(1, 1, 0))
local kTextFontName = "fonts/AgencyFB_large.fnt"
local kFontColor = Color(1, 1, 1, 1)

local kEggSize = GUIScale( Vector(64, 64, 0) )
local kCarrySize = GUIScale( Vector(200, 200, 0) )

local kPadding = GUIScale(32)
local kEggTopOffset = GUIScale(8)
local kBarTopOffset = GUIScale(7)
local kEggSideOffset = GUIScale(72)
local kNameOffset = GUIScale(32)

local kNoEggsColor = Color(1, 0, 0, 1)
local kWhite = Color(1, 1, 1, 1)
local kBlueColor = ColorIntToColor(kMarineTeamColor)
local kBlueHighlightColor = Color(0.30, 0.69, 1, 1)
local kRedColor = kRedColor--ColorIntToColor(kAlienTeamColor)
local kRedHighlightColor = Color(1, 0.79, 0.23, 1)

local kEggTexture = "ui/Gorge.dds"

local kSpawnInOffset = GUIScale(Vector(0, -125, 0))

function UI_GetFlagCaps(teamNumber)
	
	local teamcaps = 0
	local teamInfo = GetTeamInfoEntity(teamNumber)
	if teaminfo then
		teamcaps = teamInfo:GetNumFlagsCaptured() 
	end
	return teamcaps
end	

Print("%s", teamcaps)

function GUIFlagScore:Initialize()
    
    self.pointsDash = GUIManager:CreateTextItem()
    self.pointsDash:SetFontName(kTextFontName)
    self.pointsDash:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.pointsDash:SetPosition(Vector(0, kBarTopOffset + kEggSize.y / 2, 0))
    self.pointsDash:SetTextAlignmentX(GUIItem.Align_Center)
    self.pointsDash:SetTextAlignmentY(GUIItem.Align_Center)
    self.pointsDash:SetColor(kFontColor)
    self.pointsDash:SetScale(kFontScale)
    self.pointsDash:SetFontName(kTextFontName)        
    
    ///////////////////
        
    self.teamIcon = GUIManager:CreateGraphicItem()
    self.teamIcon:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.teamIcon:SetPosition(Vector(-kEggSideOffset-kEggSize.x, kEggTopOffset, 0))
    self.teamIcon:SetTexture(kEggTexture)
    self.teamIcon:SetSize(kEggSize)
    
    // Points
    
    self.teamPoints = GUIManager:CreateTextItem()
    self.teamPoints:SetFontName(kTextFontName)
    self.teamPoints:SetAnchor(GUIItem.Right, GUIItem.Center)
    self.teamPoints:SetPosition(Vector(kPadding * 0.5, 0, 0))
    self.teamPoints:SetTextAlignmentX(GUIItem.Align_Min)
    self.teamPoints:SetTextAlignmentY(GUIItem.Align_Center)
    self.teamPoints:SetColor(kFontColor)
    self.teamPoints:SetScale(kFontScale)
    self.teamPoints:SetFontName(kTextFontName)

    self.teamIcon:AddChild(self.teamPoints)
    
    // Carrier 
    
    self.teamCarrier = GUIManager:CreateTextItem()
    self.teamCarrier:SetFontName(kTextFontName)
    self.teamCarrier:SetAnchor(GUIItem.Right, GUIItem.Center)
    self.teamCarrier:SetPosition(Vector(-kPadding * 0.5 - kEggSize.x, 0, 0))
    self.teamCarrier:SetTextAlignmentX(GUIItem.Align_Max)
    self.teamCarrier:SetTextAlignmentY(GUIItem.Align_Center)
    self.teamCarrier:SetColor(kFontColor)
    self.teamCarrier:SetScale(kFontScale)
    self.teamCarrier:SetFontName(kTextFontName)
    
    self.teamIcon:AddChild(self.teamCarrier)
    
    // ENEMY
    
    self.enemyTeamIcon = GUIManager:CreateGraphicItem()
    self.enemyTeamIcon:SetAnchor(GUIItem.Middle, GUIItem.Top)
    self.enemyTeamIcon:SetPosition(Vector(kEggSideOffset, kEggTopOffset, 0))
    self.enemyTeamIcon:SetTexture(kEggTexture)
    self.enemyTeamIcon:SetSize(kEggSize)
    
    // Points
    
    self.enemyTeamPoints = GUIManager:CreateTextItem()
    self.enemyTeamPoints:SetFontName(kTextFontName)
    self.enemyTeamPoints:SetAnchor(GUIItem.Left, GUIItem.Center)
    self.enemyTeamPoints:SetPosition(Vector(-kPadding * 0.5, 0, 0))
    self.enemyTeamPoints:SetTextAlignmentX(GUIItem.Align_Max)
    self.enemyTeamPoints:SetTextAlignmentY(GUIItem.Align_Center)
    self.enemyTeamPoints:SetColor(kFontColor)
    self.enemyTeamPoints:SetScale(kFontScale)
    self.enemyTeamPoints:SetFontName(kTextFontName)
    
    self.enemyTeamIcon:AddChild(self.enemyTeamPoints)
    
    // Carrier

    self.enemyTeamCarrier = GUIManager:CreateTextItem()
    self.enemyTeamCarrier:SetFontName(kTextFontName)
    self.enemyTeamCarrier:SetAnchor(GUIItem.Left, GUIItem.Center)
    self.enemyTeamCarrier:SetPosition(Vector(kPadding * 0.5 + kEggSize.x, 0, 0))
    self.enemyTeamCarrier:SetTextAlignmentX(GUIItem.Align_Min)
    self.enemyTeamCarrier:SetTextAlignmentY(GUIItem.Align_Center)
    self.enemyTeamCarrier:SetColor(kFontColor)
    self.enemyTeamCarrier:SetScale(kFontScale)
    self.enemyTeamCarrier:SetFontName(kTextFontName)
    
    self.enemyTeamIcon:AddChild(self.enemyTeamCarrier)
end

function GUIFlagScore:Uninitialize()

    GUI.DestroyItem(self.teamIcon)
    self.teamIcon = nil
    
    GUI.DestroyItem(self.teamPoints)
    self.teamPoints = nil
    
    GUI.DestroyItem(self.teamCarrier)
    self.teamCarrier = nil
    
    GUI.DestroyItem(self.enemyTeamIcon)
    self.enemyTeamIcon = nil
    
    GUI.DestroyItem(self.enemyTeamPoints)
    self.enemyTeamPoints = nil

    GUI.DestroyItem(self.enemyTeamCarrier)
    self.enemyTeamCarrier = nil

    GUI.DestroyItem(self.pointsDash)
    self.pointsDash = nil
    
    eggCount = nil
    
end

function GUIFlagScore:Update(deltaTime)

    local player = Client.GetLocalPlayer()
    isVisible = (player ~= nil) 

    self.enemyTeamPoints:SetIsVisible(isVisible)
   // self.enemyTeamCarrier:SetIsVisible(isVisible)
    self.enemyTeamIcon:SetIsVisible(isVisible)
    self.teamPoints:SetIsVisible(isVisible)
    //self.teamCarrier:SetIsVisible(isVisible)
    self.teamIcon:SetIsVisible(isVisible)
    self.pointsDash:SetIsVisible(isVisible)
        
    if player then
    
        local teamNumber = player:GetTeamNumber()
        
        local myTeamColor = kBlueColor 
        local enemyTeamColor = kRedColor 

        if (teamNumber == kTeam1Index) then
            myTeamColor = kRedColor
            enemyTeamColor = kBlueColor
        end

		local points = UI_GetFlagCaps(teamNumber)
		
		self.teamPoints:SetText(ToString(points)) 
        self.teamPoints:SetColor(myTeamColor)
        self.teamIcon:SetColor(myTeamColor)
          
        self.pointsDash:SetText("-")
        self.pointsDash:SetColor(kWhite)

       
    end
    
end