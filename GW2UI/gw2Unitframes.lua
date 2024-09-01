local _G = GW2UI.GetGlobalEnv()
local T = GW2UI.T
local gw2art = "Interface\\AddOns\\GW2UI\\img\\"

local addonpath
local tocs = { "", "-master", "-tbc", "-wotlk" }
for _, name in pairs(tocs) do
  local current = string.format("GW2UI%s", name)
  local _, title = GetAddOnInfo(current)
  if title then
    addonpath = "Interface\\AddOns\\" .. current
    break
  end
end

-----Reskins the zzz-----
-- Create a new frame
--local overlay = CreateFrame("Frame", nil, PlayerRestIcon:GetParent())
local overlay = CreateFrame("Frame", "overlay", UIParent)
overlay:SetWidth(24)
overlay:SetHeight(24)
overlay:SetPoint("CENTER", circleFrame, "CENTER", 20, -415) -- Position the NEW RESTED icon

--remove the original blizzard zzz
PlayerRestIcon:SetTexture("")
PlayerRestIcon:ClearAllPoints()
PlayerRestIcon:SetPoint("TOPLEFT", PlayerFrame, -3000, 0)

-- Set the texture for the overlay
overlay.texture = overlay:CreateTexture()
overlay.texture:SetAllPoints()
overlay.texture:SetTexture(gw2art .. "Resting\\UIUnitFrameRestingFlipbook.tga")
--overlay.texture:SetTexture("Interface\\AddOns\\tDF\\img\\Unitframe\\flipbookrested-animation.tga")
overlay.texture:SetTexCoord(0/512, 60/512, 0/512, 60/512)
-----Reskins the zzz-----

----------------ANIMATION----------------
-- Define the TexCoords for each frame of the animation
local texCoords = {
  --x changes by 60 y changes by 60
  -- (1)512 (x)    x    512 (y)      (2)512 (x)    x    512 (y)      (3)512 (x)    x    512 (y)       (4)512 (x)    x    512 (y)       (5)512 (x)    x    512 (y)       (6)512 (x)    x    512 (y)
  {0/512, 60/512, 0/512, 60/512}, {60/512, 120/512, 0/512, 60/512}, {120/512, 180/512, 0/512, 60/512}, {180/512, 240/512, 0/512, 60/512}, {240/512, 300/512, 0/512, 60/512}, {300/512, 360/512, 0/512, 60/512}, --z
  {0/512, 60/512, 60/512,120/512}, {60/512, 120/512, 60/512, 120/512}, {120/512, 180/512, 60/512, 120/512}, {180/512, 240/512, 60/512, 120/512}, {240/512, 300/512, 60/512, 120/512}, {300/512, 360/512, 60/512, 120/512}, --zz
  {0/512, 60/512, 120/512, 180/512}, {60/512, 120/512, 120/512, 180/512}, {120/512, 180/512, 120/512, 180/512}, {180/512, 240/512, 120/512, 180/512}, {240/512, 300/512, 120/512, 180/512}, {300/512, 360/512, 120/512, 180/512}, --zz
  {0/512, 60/512, 180/512, 240/512}, {60/512, 120/512, 180/512, 240/512}, {120/512, 180/512, 180/512, 240/512}, {180/512, 240/512, 180/512, 240/512}, {240/512, 300/512, 180/512, 240/512}, {300/512, 360/512, 180/512, 240/512}, --zzz
  {0/512, 60/512, 240/512, 300/512}, {60/512, 120/512, 240/512, 300/512}, {120/512, 180/512, 240/512, 300/512}, {180/512, 240/512, 240/512, 300/512}, {240/512, 300/512, 240/512, 300/512}, {300/512, 360/512, 240/512, 300/512}, --zzz
  {0/512, 60/512, 300/512, 360/512}, {60/512, 120/512, 300/512, 360/512}, {120/512, 180/512, 300/512, 360/512}, {180/512, 240/512, 300/512, 360/512}, {240/512, 300/512, 300/512, 360/512}, {300/512, 360/512, 300/512, 360/512}, --zzz
  --{0/512, 60/512, 360/512, 410/512}, {60/512, 120/512, 360/512, 410/512}, {120/512, 180/512, 360/512, 410/512}, {180/512, 240/512, 360/512, 410/512}, {240/512, 300/512, 360/512, 410/512}, {300/512, 360/512, 360/512, 410/512}, --zzz

}

-- Function to update the texture coordinates
local currentFrame = 1
local function UpdateTexCoords()
  local coords = texCoords[currentFrame]
  overlay.texture:SetTexCoord(unpack(coords))
  currentFrame = currentFrame + 1
  if currentFrame > table.getn(texCoords) then
      currentFrame = 1
  end
end

-- OnUpdate script to change the TexCoords every 0.1 seconds
local timeSinceLastUpdate = 0
local updateInterval = .05 -- .1 default - Adjust this to change the speed of the animation
overlay:SetScript("OnUpdate", function(self, elapsed)
  local elapsed = arg1 or 0
  timeSinceLastUpdate = timeSinceLastUpdate + elapsed
  if timeSinceLastUpdate > updateInterval then
      timeSinceLastUpdate = 0
      UpdateTexCoords()
  end
end)
----------------ANIMATION----------------

----------------SHOW/HIDE ANIMATION----------------
overlay:Hide()

-- Function to check and update the resting state
local function UpdateRestingState()
    if IsResting() then
        overlay:Show()
    else
        overlay:Hide()
    end
end

-- Register the event
overlay:RegisterEvent("PLAYER_UPDATE_RESTING")
overlay:RegisterEvent("PLAYER_ENTERING_WORLD") -- Add this event to check on login
overlay:SetScript("OnEvent", UpdateRestingState)

-- Initial check when the addon is loaded
UpdateRestingState()

----------------SHOW/HIDE ANIMATION----------------

--Target Frame
TargetFrame:ClearAllPoints()
TargetFrame:SetPoint("TOP", UIParent, 60, -20)
--TargetFrameTexture:SetTexture(gw2art .. "target\\targetshadow2.tga")
TargetFrameTexture:SetTexture(gw2art .. "")

-- Create the overlay frame
local overlayFrame = CreateFrame("Frame", "CustomOverlayFrame", TargetFrame)
overlayFrame:SetWidth(512) -- Set the size to match the TargetFrame
overlayFrame:SetHeight(128)

-- Set the texture of the overlay frame
local overlayTexture = overlayFrame:CreateTexture(nil, "OVERLAY")
overlayTexture:SetTexture(gw2art .. "target\\longtarget1.tga")
overlayTexture:SetAllPoints(overlayFrame) -- Make the texture cover the entire frame

-- Position the overlay frame to overlay the TargetFrame
overlayFrame:SetPoint("CENTER", TargetFrame, "CENTER", -35, 10)

--TargetFrameTexture:SetAllPoints(TargetFrame)
--TargetFrameTexture:Hide()
--TargetFrameHealthBar:SetPoint("TOPRIGHT", -100, -29)
TargetFrameHealthBar:SetWidth(200)
TargetFrameHealthBar:SetHeight(10)
TargetFrameHealthBar:SetStatusBarTexture(gw2art .. "statusbar.tga")
TargetFrameManaBar:ClearAllPoints()
TargetFrameManaBar:SetPoint("CENTER", TargetFrameHealthBar, 0, -20)
TargetFrameManaBar:SetWidth(200)
TargetFrameManaBar:SetHeight(5)
--Target Frame Background Texture
TargetFrameBackground:SetWidth(256)
TargetFrameBackground:SetHeight(128)
TargetFrameBackground:SetTexture("")
TargetFrameBackground:SetPoint("TOPRIGHT", TargetFrame, "TOPRIGHT", 0, 0)

-- Move Target level text
local targetLevelText = TargetLevelText
-- Adjust the position of the level text
targetLevelText:ClearAllPoints()
targetLevelText:SetPoint("RIGHT", TargetFrameHealthBar, 0, 20)
targetLevelText:SetTextColor(1,1,1)
  --Move Targetname
local targetName = TargetFrame.name
-- Adjust the position of the name text
targetName:ClearAllPoints()
targetName:SetPoint("LEFT", TargetFrameHealthBar, -20, 20)
targetName:SetTextColor(1,1,1)

--Resize Target portrait
local targetPortrait = TargetFrame.portrait
targetPortrait:SetHeight(61)
targetPortrait:SetWidth(61)

--DF Texture ends

--PLAYERS TARGETS ALL RED
-- enable class color backgrounds
local original = TargetFrame_CheckFaction
function TargetFrame_CheckFaction(self)
  original(self)

  local reaction = UnitReaction("target", "player")

  if UnitIsPlayer("target") then
    local _, class = UnitClass("target")
    local class = { r = 0.6, g = 0.1, b = 0.1, a = 0.5 }
    TargetFrameNameBackground:SetVertexColor(class.r, class.g, class.b, 1)
    TargetFrameNameBackground:Show()
  elseif reaction and reaction > 4 then
    TargetFrameNameBackground:Hide()
  else
    TargetFrameNameBackground:Show()
  end
end
local _, class = UnitClass("player")
local class = { r = 0.6, g = 0.1, b = 0.1, a = 0.5 }
--END PLAYER TARGETS ALL RED

--DF Pet
-- Hook the PetFrame_Update function
  local new_PetFrame_Update = PetFrame_Update
  local new_PetFrame = PetFrame
  PetFrame_Update = function()
    -- Call the original function
    new_PetFrame_Update()
    --PetFrameTexture:SetTexture("Interface\\Addons\\tDF\\img\\pet")
    PetFrameTexture:SetDrawLayer("BACKGROUND") -- Set the draw layer of the texture
    PetFrame:ClearAllPoints()
    PetFrame:SetPoint("BOTTOM", PlayerFrame, -10, -30)
    -- Change the frame strata of the HealthBar and ManaBar

    --PetFrameHealthBar:SetFrameStrata("MEDIUM")
    --PetFrameHealthBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Health]])
      -- Adjust the position of the PetFrameHealthBar
    PetFrameHealthBar:SetHeight(13)
    PetFrameHealthBar:ClearAllPoints()
    PetFrameHealthBar:SetPoint("CENTER", PetFrame, "CENTER", 15, 3)
    --PetFrameManaBar:SetFrameStrata("MEDIUM")
    local class = UnitClass("player")
    if class == "Hunter" then
      --PetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Focus]])
    else
      --PetFrameManaBar:SetStatusBarTexture([[Interface\Addons\tDF\img\Unitframe\UI-HUD-UnitFrame-TargetofTarget-PortraitOn-Bar-Mana]])
    end
    -- Adjust the position of the PetFrameManaBar
    PetFrameManaBar:ClearAllPoints()
    PetFrameManaBar:SetPoint("CENTER", PetFrame, "CENTER", 15, -7)
    -- Adjust the position of the PetName
    PetName:ClearAllPoints()
    PetName:SetPoint("CENTER", PetFrame, "CENTER", 5, 16)
  end 
--DF Pet ends

local original = TargetFrame_CheckClassification
function TargetFrame_CheckClassification()
  local classification = UnitClassification("target")
  if ( classification == "worldboss" ) then
    --TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrame-Boss.blp")
    TargetFrameTexture:SetTexture("")
  elseif ( classification == "rareelite"  ) then
    --TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrame-RareElite.blp")
    TargetFrameTexture:SetTexture("")
  elseif ( classification == "elite"  ) then
    --TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrame-Elite.blp")
    TargetFrameTexture:SetTexture("")
  elseif ( classification == "rare"  ) then
    --TargetFrameTexture:SetTexture("Interface\\AddOns\\tDF\\img\\new-unitframes\\UI-TargetingFrame-Rare.blp")
    TargetFrameTexture:SetTexture("")
  else
    --TargetFrameTexture:SetTexture(gw2art .. "target\\targetshadow2.tga")
    TargetFrameTexture:SetTexture("")
  end
end

local wait = CreateFrame("Frame")
wait:RegisterEvent("PLAYER_ENTERING_WORLD")
wait:SetScript("OnEvent", function()
  if GW2UI.DarkMode then
    PlayerFrameTexture:SetVertexColor(.3,.3,.3,.9)
    TargetFrameTexture:SetVertexColor(.3,.3,.3,.9)
  end

-- adjust healthbar colors to frame colors
local original = TargetFrame_CheckFaction
  function TargetFrame_CheckFaction(self)
    original(self)

    if TargetFrameHealthBar._SetStatusBarColor then
      local r, g, b, a = TargetFrameNameBackground:GetVertexColor()
      TargetFrameHealthBar:_SetStatusBarColor(r, g, b, a)
    end
  end
end)

  -- delay to first draw
  wait:SetScript("OnUpdate", function()
    -- move text strings a bit higher
    if PlayerFrameHealthBar.TextString then
      PlayerFrameHealthBar.TextString:SetPoint("TOP", PlayerFrameHealthBar, "BOTTOM", 0, 32)
    end

    if TargetFrameHealthBar.TextString then
      TargetFrameHealthBar.TextString:SetPoint("TOP", TargetFrameHealthBar, "BOTTOM", 2, 32)
    end

    -- use class color for player (if enabled)
    if PlayerFrameNameBackground then
      -- disable vanilla ui color restore functions
      PlayerFrameHealthBar._SetStatusBarColor = PlayerFrameHealthBar.SetStatusBarColor
      PlayerFrameHealthBar.SetStatusBarColor = function() return end

      -- set player healthbar to class color
      local r, g, b, a = PlayerFrameNameBackground:GetVertexColor()
      PlayerFrameHealthBar:_SetStatusBarColor(r, g, b, a)

      -- hide status textures
      PlayerFrameNameBackground:Hide()
      PlayerFrameNameBackground.Show = function() return end
    end

    -- use frame color for target frame
    if TargetFrameNameBackground then
      -- disable vanilla ui color restore functions
      TargetFrameHealthBar._SetStatusBarColor = TargetFrameHealthBar.SetStatusBarColor
      TargetFrameHealthBar.SetStatusBarColor = function() return end

      -- hide status textures
      TargetFrameNameBackground.Show = function() return end
      TargetFrameNameBackground:Hide()
    end

    TargetFrame_CheckFaction(PlayerFrame)
    wait:UnregisterAllEvents()
    wait:Hide()

-- Party space fix with pet
  if PetFrame:IsVisible() then
    if PartyMemberFrame1:IsVisible() then
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
    else
      --print("partyMember1 does not exist")
    end
  else
      PartyMemberFrame1:ClearAllPoints()
      PartyMemberFrame1:SetPoint("TOPLEFT", UIParent, 30, -150)
  end

  end)

