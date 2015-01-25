Script.Load("lua/Balance.lua")
Script.Load("lua/BalanceHealth.lua")
Script.Load("lua/BalanceMisc.lua")

--HMG
kHeavyMachineGunDamage = 7.0		
kHeavyMachineGunDamageType = kDamageType.Puncture	
kHeavyMachineGunClipSize = 100		
kHeavyMachineGunWeight = 0.21		
kHeavyMachineGunCost = 20			
kHeavyMachineGunDropCost = 25		
kHeavyMachineGunPointValue = 7		
kHeavyMachineGunSpread = Math.Radians(3.8)	

--Class Menu

kClassMenuUseRange = 15

--Class Abilities
kMedicHealCoolDown = 15
kNanoShieldDuration = 5
kAssaultNanoCoolDown = 30

--Structures

//kCommandStationHealth = 30000   
//kCommandStationArmor = 15000 
//kHiveHealth = 40000    
//kHiveArmor = 7500 
//kInfantryPortalHealth = 15250   
//kInfantryPortalArmor = 5000

--Medic 

--Engineer
kSentryDamage = 15

kNumSentriesPerPlayer = 1
kNumObservatoriesPerPlayer = 1
kNumPhaseGatesPerPlayer = 2
kNumArmoriesPerPlayer = 1

kArmoryCost = 0
kObservatoryCost = 0
kPhaseGateCost = 0
kSentryCost = 0



-- CTF Mode Specific
kPickUpFlagScore = 10
kReturnFlagScore = 20
kCaptureFlagScore = 50

kCaptureWinTotal = 5

--Aliens
kEvolutionGestateTime = 1
kUpgradeGestationTime = 1


kSkulkGestateTime = 1
kGorgeGestateTime = 1
kLerkGestateTime = 1
kFadeGestateTime = 1
kOnosGestateTime = 1

kSkulkUpgradeCost = 0
kGorgeUpgradeCost = 0
kLerkUpgradeCost = 0
kFadeUpgradeCost = 0
kOnosUpgradeCost = 0

kGorgeCost = 0
kLerkCost = 0
kFadeCost = 0
kOnosCost = 0

--Skulk

kLeapEnergyCost = 25

--Gorge
kWebBuildCost = 0
kBombVelocity = 16
kHydraCost = 0
kGorgeTunnelCost = 0

--Fade

kStartBlinkEnergyCost = 11
kBlinkEnergyCost = 25
kMetabolizeHealthRegain = 25

