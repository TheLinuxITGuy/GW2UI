local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T

local module = GW2UI:register({
  title = T["Hide Bags"],
  description = T["Hides the bags from the UI."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = true,
})

module.enable = function(self)
    CharacterBag0Slot:Hide()
    CharacterBag1Slot:Hide()
    CharacterBag2Slot:Hide()
    CharacterBag3Slot:Hide()
    MainMenuBarBackpackButton:Hide()
    KeyRingButton:ClearAllPoints()
    KeyRingButton:SetAlpha(0)
    KeyRingButton:Hide()
end