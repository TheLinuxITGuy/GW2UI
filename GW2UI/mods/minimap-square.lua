local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T

  -- Move the zone text up
  ZoneTextFrame:ClearAllPoints()
  ZoneTextFrame:SetPoint("TOP", MinimapCluster, "TOP", 0, 50) -- Adjust the Y offset as needed

  -- Your existing code
  local gw2art = "Interface\\AddOns\\GW2UI\\img\\"
  MinimapCluster:ClearAllPoints()
  --MinimapCluster:SetPoint("BOTTOMRIGHT", UIParent, -40, 100)
  MinimapCluster:SetPoint("BOTTOMRIGHT", UIParent, 0, 200) --meh

  MinimapBorder:SetTexture(nil)
  --Minimap:SetPoint("CENTER", MinimapCluster, "TOP", 9, -98)
  Minimap:SetMaskTexture("Interface\\BUTTONS\\WHITE8X8")
  Minimap:SetWidth(250)
  Minimap:SetHeight(250)
  Minimap:SetPoint("BOTTOMRIGHT", UIParent, -5, 35) -- this is what matters
