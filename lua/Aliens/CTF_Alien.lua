Script.Load("lua/Alien.lua")
Script.Load("lua/Flags/CTF_FlagBearerMixin.lua")

if Client then
    Script.Load("lua/Aliens/CTF_Alien_Client.lua")
end

local networkVars = {
}

AddMixinNetworkVars(FlagBearerMixin, networkVars)

local orig_Alien_OnInitialized = Alien.OnInitialized
function Alien:OnInitialized()
    InitMixin(self, FlagBearerMixin)
    orig_Alien_OnInitialized(self)
end