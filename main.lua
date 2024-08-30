local _G = _G or getfenv(0)

SLASH_RELOAD1 = '/rl'
function SlashCmdList.RELOAD(msg, editbox) ReloadUI() end

message = function(msg)
  DEFAULT_CHAT_FRAME:AddMessage(msg or "nil")
end
print = message

error = function(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffff0000".. (msg or "nil" ))
end
seterrorhandler(error)

GW2UI = CreateFrame("Frame")
GW2UI.mods = {}

 -- load translation tables
 GW2UI.L = (GW2UI_locale[GetLocale()] or GW2UI_locale["enUS"])
 GW2UI.T = (GW2UI_translation[GetLocale()] or GW2UI_translation["enUS"])

 -- use table index key as translation fallback
 GW2UI.T = setmetatable(GW2UI.T, { __index = function(tab,key)
   local value = tostring(key)
   rawset(tab, key, value)
   return value
 end})

 GW2UI:RegisterEvent("VARIABLES_LOADED")
 GW2UI:SetScript("OnEvent", function()

   -- load current expansion
  local expansion = GW2UI:GetExpansion()

  -- initialize empty config
  if not GW2UI_config then GW2UI_config = {} end

  -- read all registered mods
  for title, mod in pairs(GW2UI.mods) do
    -- write initial default config
    if not GW2UI_config[title] then
      GW2UI_config[title] = mod.enabled and 1 or 0
    end

    -- load enabled mods
    if mod.expansions[expansion] and GW2UI_config[title] == 1 then
      mod:enable()
    end
  end
end)

GW2UI.register = function(self, mod)
  GW2UI.mods[mod.title] = mod
  return GW2UI.mods[mod.title]
end
