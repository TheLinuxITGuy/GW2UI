local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T

local module = GW2UI:register({
  title = T["Hide Gryphons"],
  description = T["Hides the gryphons left and right of the action bar."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = true,
})

module.enable = function(self)
  MainMenuBarLeftEndCap:Hide()
  MainMenuBarRightEndCap:Hide()
end
