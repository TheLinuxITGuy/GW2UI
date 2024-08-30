local _G = GW2UI.GetGlobalEnv()
local GetExpansion = GW2UI.GetExpansion
local GetUnitData = GW2UI.GetUnitData

local NAMEPLATE_OBJECTORDER = { "border", "glow", "name", "level", "levelicon", "raidicon" }
local NAMEPLATE_TYPE = "Button"
if GetExpansion() == "tbc" then
  NAMEPLATE_OBJECTORDER = { "border", "castborder", "casticon", "glow", "name", "level", "levelicon", "raidicon" }
  NAMEPLATE_TYPE = "Frame"
end

local function IsNamePlate(frame)
  if frame:GetObjectType() ~= NAMEPLATE_TYPE then return nil end
  regions = frame:GetRegions()

  if not regions then return nil end
  if not regions.GetObjectType then return nil end
  if not regions.GetTexture then return nil end

  if regions:GetObjectType() ~= "Texture" then return nil end
  return regions:GetTexture() == "Interface\\Tooltips\\Nameplate-Border" or nil
end

local registry = {}
local initialized = 0
local parentcount, childs, plate
GW2UI.libnameplate = CreateFrame("Frame", nil, UIParent)
GW2UI.libnameplate.OnInit = {}
GW2UI.libnameplate.OnShow = {}
GW2UI.libnameplate.OnUpdate = {}
GW2UI.libnameplate:SetScript("OnUpdate", function()
  parentcount = WorldFrame:GetNumChildren()
  if initialized < parentcount then
    childs = { WorldFrame:GetChildren() }
    for i = initialized + 1, parentcount do
      plate = childs[i]

      if IsNamePlate(plate) and not registry[plate] then
        plate.healthbar = plate:GetChildren()
        for i, object in pairs({plate:GetRegions()}) do
          if plate and NAMEPLATE_OBJECTORDER[i] then
            plate[NAMEPLATE_OBJECTORDER[i]] = object
          end
        end

        -- run OnInit functions
        for id, func in pairs(GW2UI.libnameplate.OnInit) do
          func(plate)
        end

        -- register OnUpdate functions
        local oldUpdate = plate:GetScript("OnUpdate")
        plate:SetScript("OnUpdate", function(self, elapsed)
          if oldUpdate then oldUpdate(self, elapsed) end
          for id, func in pairs(GW2UI.libnameplate.OnUpdate) do
            func(self, elapsed)
          end
        end)

        -- register OnShow functions
        local oldShow = plate:GetScript("OnShow")
        plate:SetScript("OnShow", function(self)
          if oldShow then oldShow(self) end
          for id, func in pairs(GW2UI.libnameplate.OnShow) do
            func(self)
          end
        end)

        registry[plate] = plate
      end
    end

    initialized = parentcount
  end
end)
