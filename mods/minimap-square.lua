local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T

local module = GW2UI:register({
  title = T["MiniMap Square"],
  description = T["Draw the mini map in a squared shape instead of a round one."],
  expansions = { ["vanilla"] = true, ["tbc"] = true },
  category = T["World & MiniMap"],
  enabled = true,
})

module.enable = function(self)
  -- Move the zone text up
  ZoneTextFrame:ClearAllPoints()
  ZoneTextFrame:SetPoint("TOP", MinimapCluster, "TOP", 0, 50) -- Adjust the Y offset as needed

  -- Your existing code
  local gw2art = "Interface\\AddOns\\GW2UI\\img\\"
  MinimapCluster:ClearAllPoints()
  MinimapCluster:SetPoint("BOTTOMRIGHT", UIParent, -65, 25)

  MinimapBorder:SetTexture(nil)
  Minimap:SetPoint("CENTER", MinimapCluster, "TOP", 9, -98)
  --Minimap:SetPoint("CENTER", MinimapCluster, "CENTER", 0, 0)
  Minimap:SetMaskTexture("Interface\\BUTTONS\\WHITE8X8")
  Minimap:SetWidth(300)
  Minimap:SetHeight(185)

  DurabilityFrame:ClearAllPoints()
  DurabilityFrame:SetPoint("TOPRIGHT", UIParent, 50, 100)

end
