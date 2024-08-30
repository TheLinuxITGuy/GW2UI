local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T

local module = GW2UI:register({
  title = T["Hide Errors"],
  description = T["Hides and ignores all Lua errors produced by broken addons."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  enabled = nil,
})

module.enable = function(self)
  error = function() return end
  seterrorhandler(error)
end
