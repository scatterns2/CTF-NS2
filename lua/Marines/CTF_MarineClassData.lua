kClassTypes = enum {
	"Medic",
	"Recon",
	"Engineer",
	"Assault",
	"Assassin",
	"Grenadier",

}

kClassTypesData = {
	--Support Class 
	[kClassTypes.Medic] = {
		speedBase 		 = 6.5,
		healthBase 		 = 155,	
		armorBase 		 = 50,
		weaponPrimary	 = Flamethrower.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = HealGun.kMapName,
		classItem		 = GasGrenadeThrower.kMapName,
		classSpecial     = nil,
		avatarModel 	 = PrecacheAsset("models/marine/male/male.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),
	},
	[kClassTypes.Engineer] = {
		speedBase  		 = 7,
		healthBase 		 = 150,
		armorBase 		 = 75,
		weaponPrimary 	 = Rifle.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = Welder.kMapName,
		classItem		 = Builder.kMapName,
		classSpecial     = MarineStructureAbility.kMapName,
		avatarModel 	 = PrecacheAsset("models/marine/female/female.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),

	},
	--Light Class
	[kClassTypes.Recon]    = {
		speedBase  		 = 8.5,
		healthBase 		 = 100,
		armorBase 		 = 50,
		weaponPrimary	 = Shotgun.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = Axe.kMapName,
		classItem		 = PulseGrenadeThrower.kMapName,
		classSpecial     = nil,
		avatarModel 	 = PrecacheAsset("models/marine/male/male.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),
	},
	--
	[kClassTypes.Assassin]    = {
		speedBase  		 = 9,
		healthBase 		 = 100,
		armorBase 		 = 50,
		weaponPrimary	 = Katana.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = nil,
		classItem		 = nil,
		classSpecial     = nil,
		avatarModel 	 = PrecacheAsset("models/marine/male/male.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),
	},

	--assault
	[kClassTypes.Assault] = {
		speedBase 		 = 6,
		healthBase 		 = 175,
		armorBase 		 = 120,
		weaponPrimary 	 = HeavyMachineGun.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = Axe.kMapName,
		classItem		 = ClusterGrenadeThrower.kMapName,
		classSpecial     = LayMines.kMapName,
		avatarModel 	 = PrecacheAsset("models/marine/female/female.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),
	},
	[kClassTypes.Grenadier] = {
		speedBase 		 = 6,
		healthBase 		 = 175,
		armorBase 		 = 150,
		weaponPrimary 	 = GrenadeLauncher.kMapName,
		weaponSecondary  = Pistol.kMapName,
		weaponTertiary   = Axe.kMapName,
		classItem		 = ClusterGrenadeThrower.kMapName,
		classSpecial     = AmmoPack.kMapName,
		avatarModel 	 = PrecacheAsset("models/marine/female/female.model"),
		avatarGraph		 = PrecacheAsset("models/marine/male/male.animation_graph"),
	},

}	
			
	


	