local _G = GW2UI.GetGlobalEnv()

  -- general function to hide textures and frames
  local addonpath = "Interface\\AddOns\\GW2UI\\"
  local gw2art = "Interface\\AddOns\\GW2UI\\img\\globe\\"
  local gw2artXP = "Interface\\AddOns\\GW2UI\\img\\XPbar\\"
  local function hide(frame, texture)
    if not frame then return end

    if texture and texture == 1 and frame.SetTexture then
      frame:SetTexture("")
    elseif texture and texture == 2 and frame.SetNormalTexture then
      frame:SetNormalTexture("")
    else
      frame:ClearAllPoints()
      frame.Show = function() return end
      frame:Hide()
    end
  end

  -- frames that shall be hidden
  local frames = {
    -- actionbar paging
    MainMenuBarPageNumber, ActionBarUpButton, ActionBarDownButton,
    -- xp and reputation bar
    MainMenuXPBarTexture0, MainMenuXPBarTexture1,
    MainMenuXPBarTexture2, MainMenuXPBarTexture3,
    ReputationWatchBarTexture2, ReputationWatchBarTexture3,

    -- actionbar backgrounds
    MainMenuBarTexture0, MainMenuBarTexture1,
    MainMenuBarTexture2, MainMenuBarTexture3,
    MainMenuMaxLevelBar2, MainMenuMaxLevelBar3,
    ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
  }

  -- textures that shall be set empty
  local textures = {
    ReputationWatchBarTexture2, ReputationWatchBarTexture3,
    ReputationXPBarTexture2, ReputationXPBarTexture3,
    SlidingActionBarTexture0, SlidingActionBarTexture1,
    
  }

  -- button textures that shall be set empty
  local normtextures = {
    ShapeshiftButton1, ShapeshiftButton2,
    ShapeshiftButton3, ShapeshiftButton4,
    ShapeshiftButton5, ShapeshiftButton6,
  }

  -- elements that shall be resized to 511px
  local resizes = {
    MainMenuBar, MainMenuBarMaxLevelBar,
    ReputationWatchBar, ReputationWatchStatusBar,
    -- MainMenuExpBar
  }

  -- hide frames
  for id, frame in pairs(frames) do hide(frame) end

  -- clear textures
  for id, frame in pairs(textures) do hide(frame, 1) end
  for id, frame in pairs(normtextures) do hide(frame, 2) end

  -- resize actionbar
  for id, frame in pairs(resizes) do frame:SetWidth(0) end

  -- experience bar
  -- Get the screen width
  local screenWidth = UIParent:GetWidth()
  -- Set the width of the MainMenuExpBar to the screen width
  MainMenuExpBar:SetWidth(screenWidth+380)
  MainMenuExpBar:SetHeight(MainMenuExpBar:GetHeight()-4)
  -- Position the MainMenuExpBar at the bottom of the screen
  MainMenuExpBar:ClearAllPoints()
  MainMenuExpBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0)

  -- Create a frame for the character levels
  local levelFrame = CreateFrame("Frame", "LevelFrame", UIParent)
  levelFrame:SetHeight(32)
  levelFrame:SetWidth(128)
  levelFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 0, 0) -- Position in the bottom left corner
  -- Create a texture for the frame
  local texture = levelFrame:CreateTexture(nil, "BACKGROUND")
  texture:SetAllPoints(levelFrame) -- Set the texture to cover the entire frame
  texture:SetTexture(gw2artXP .. "dragon.tga") -- Path to the texture file

  -- Create a font string to display the current character level
  local levelText = levelFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  levelText:SetPoint("CENTER", levelFrame, "CENTER", -20, -5)
  levelText:SetTextColor(1, 1, 1, 1) -- White color

  -- Create a frame for the next level
  local nextLevelFrame = CreateFrame("Frame", "NextLevelFrame", UIParent)
  nextLevelFrame:SetHeight(32)
  nextLevelFrame:SetWidth(128)
  nextLevelFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0) -- Position in the bottom right corner
  -- Create a texture for the frame
  local texture = nextLevelFrame:CreateTexture(nil, "BACKGROUND")
  texture:SetAllPoints(nextLevelFrame) -- Set the texture to cover the entire frame
  texture:SetTexture(gw2artXP .. "dragon.tga") -- Path to the texture file
  texture:SetTexCoord(1, 0, 0, 1)

  -- Create a font string to display the next character level
  local nextLevelText = nextLevelFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  nextLevelText:SetPoint("CENTER", nextLevelFrame, "CENTER", 20, -5)
  nextLevelText:SetTextColor(1, 1, 1, 1) -- White color

  -- Function to update the character levels
  local function UpdateLevels()
      local level = UnitLevel("player")
      levelText:SetText(level)
      nextLevelText:SetText(level + 1)
  end

  -- Register events to update the levels
  levelFrame:RegisterEvent("PLAYER_LEVEL_UP")
  levelFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  levelFrame:SetScript("OnEvent", UpdateLevels)

  nextLevelFrame:RegisterEvent("PLAYER_LEVEL_UP")
  nextLevelFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
  nextLevelFrame:SetScript("OnEvent", UpdateLevels)

  -- Initial update
  UpdateLevels()
  -- Create a frame for the character levels end



  -- reputation bar
  ReputationWatchBar:SetPoint("BOTTOM", MainMenuExpBar, "TOP", 0, 0)
  ReputationWatchBarTexture0:SetPoint("LEFT", ReputationWatchBar, "LEFT")
  ReputationWatchBarTexture1:SetPoint("RIGHT", ReputationWatchBar, "RIGHT")

  -- move menubar texture background
  MainMenuMaxLevelBar0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture0:SetPoint("LEFT", MainMenuBarArtFrame, "LEFT")
  MainMenuBarTexture1:SetPoint("RIGHT", MainMenuBarArtFrame, "RIGHT")

  -- Create a new frame for each ActionBar
  for _, barName in pairs({"MainMenuBar", "BonusActionBarFrame"}) do
      local bar = getglobal(barName)

      -- Create a new frame
      local blackFrame = CreateFrame("Frame", nil, bar)
      --local Rightframe = CreateFrame("Frame", nil, bar)

      -- Set the size of the frame
      blackFrame:SetWidth(700)
      blackFrame:SetHeight(475)

      -- Set the frame's position to the center of the bar
      blackFrame:SetPoint("BOTTOM", UIParent, 0, -180)

      -- Set the strata of the bar and your frame
      bar:SetFrameStrata("LOW")
      blackFrame:SetFrameStrata("LOW")

      -- Create a texture for the frame on the OVERLAY layer
      local Lefttexture = blackFrame:CreateTexture(nil, "BACKGROUND")

      -- Set the texture's image file (replace "Interface\\Addons\\tDF\\img\\MainActionBar3.tga" with the actual path)
      Lefttexture:SetTexture(addonpath .. "img\\HDActionBar.tga")

      -- Set the texture to cover the entire frame
      Lefttexture:SetAllPoints(blackFrame)

      -- Show the frame
      --blackFrame:Show()
      blackFrame:Hide()

  end

  -- Set the strata of all ActionButtons to be above your frame
  for i = 1, 12 do
      getglobal("ActionButton" .. i):SetFrameStrata("MEDIUM")
      getglobal("BonusActionButton" .. i):SetFrameStrata("MEDIUM")
  end

  -- move gryphon textures
  MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 30, 0)
  MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -30, 0)

  -- move MultiBarBottomRight ontop of MultiBarBottomLeft
  MultiBarBottomRight:ClearAllPoints()
  MultiBarBottomRight:SetPoint("BOTTOM", MultiBarBottomLeft, "TOP", 0, 5)
  MultiBarBottomLeft:SetFrameStrata("LOW")

  -- reload custom frame positions after original frame manage runs
  local hookUIParent_ManageFramePositions = UIParent_ManageFramePositions
  UIParent_ManageFramePositions = function(a1, a2, a3)
    -- run original function
    hookUIParent_ManageFramePositions(a1, a2, a3)

    -- move bars above xp bar if xp or reputation is tracked
    MainMenuBarLeftEndCap:ClearAllPoints()
    MainMenuBarRightEndCap:ClearAllPoints()
  -- MainMenuBar:ClearAllPoints()
  if MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() then
    local anchor = GetWatchedFactionInfo() and ReputationWatchBar or MainMenuExpBar
    
      MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 28)
      MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 10)
      MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 10)
    else
      MainMenuBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 13)
      MainMenuBarLeftEndCap:SetPoint("RIGHT", MainMenuBarArtFrame, "LEFT", 26, 25)
      MainMenuBarRightEndCap:SetPoint("LEFT", MainMenuBarArtFrame, "RIGHT", -26, 25)
      MainMenuBarMaxLevelBar:SetAlpha(0)
    end

    MainMenuExpBar:ClearAllPoints()
    MainMenuExpBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 2)

    MultiBarBottomLeft:ClearAllPoints()
    MultiBarBottomLeft:SetPoint("BOTTOM", MainMenuBar, "TOP", 3, -5)
    ReputationWatchStatusBar:ClearAllPoints()
    ReputationWatchStatusBar:SetPoint("BOTTOM", WorldFrame, "BOTTOM", 0, 2)
    
  -- move pet actionbar above other actionbars
  PetActionBarFrame:ClearAllPoints()
  local anchor = MainMenuBarArtFrame

  -- Create a function to update the anchor and position of PetActionBarFrame
  local function updatePetActionBarPosition()
    if MultiBarBottomRight:IsVisible() then
        anchor = MultiBarBottomRight
    elseif MultiBarBottomLeft:IsVisible() then
        anchor = MultiBarBottomLeft
    end
    PetActionBarFrame:SetPoint("CENTER", anchor, "CENTER", -30, 70)  --MOVES PET BAR
  end

  -- Call the function initially to set the position
  updatePetActionBarPosition()

  -- Set scripts to update the position when action bars show/hide
  MultiBarBottomRight:SetScript("OnShow", updatePetActionBarPosition)
  MultiBarBottomRight:SetScript("OnHide", updatePetActionBarPosition)
  MultiBarBottomLeft:SetScript("OnShow", updatePetActionBarPosition)
  MultiBarBottomLeft:SetScript("OnHide", updatePetActionBarPosition)


  -- ShapeshiftBarFrame
  ShapeshiftBarFrame:ClearAllPoints()
  local offset = 0
  local anchor = MultiBarBottomLeftButton1
  anchor = MultiBarBottomLeft:IsVisible() and MultiBarBottomLeft or anchor
  anchor = MultiBarBottomRight:IsVisible() and MultiBarBottomRight or anchor

  offset = anchor == ActionButton1 and ( MainMenuExpBar:IsVisible() or ReputationWatchBar:IsVisible() ) and 6 or 0
  offset = anchor == ActionButton1 and offset + 6 or offset
  ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 2 + offset)

  -- new to support 3rd bar
  local ShapeFrame = CreateFrame("Frame")

      -- Set the OnUpdate script
      ShapeFrame:SetScript("OnUpdate", function(self, elapsed)
      if MultiBarBottomRightButton1 then
          ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 10 + offset)
      else
          ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", anchor, "TOPLEFT", -10, 2 + offset)
      end
      end)

      CastingBarFrame:ClearAllPoints()
      CastingBarFrame:SetPoint("CENTER", circleFrame, 0, -300)

  end

  --Hide the original MainMenuBarPerformanceBarFrame
  MainMenuBarPerformanceBarFrame:ClearAllPoints()
  MainMenuBarPerformanceBarFrame:SetPoint("BOTTOMLEFT", UIParent, -300, -300)

  -- move MultiBarRight up from the Minimap
  MultiBarRight:ClearAllPoints()
  MultiBarRight:SetPoint("TOPRIGHT", Minimap, -1, 550)

  -- Function to resize and remove border from actionbar buttons
  local function CustomizeActionBarButtons()
    for i = 1, 12 do
        -- Customize main ActionButtons
        local button = _G["ActionButton"..i]
        if button then
            -- Increase button size
            button:SetWidth(40)  -- Set your desired width
            button:SetHeight(40) -- Set your desired height

            -- Remove border and other textures
            local border = _G["ActionButton"..i.."Border"]
            if border then
                border:Hide()
            end

            -- Remove normal texture
            local normalTexture = button:GetNormalTexture()
            if normalTexture then
                normalTexture:SetAlpha(0)
            end

            -- Remove other textures if necessary
            local icon = _G["ActionButton"..i.."Icon"]
            if icon then
                icon:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- Adjust icon to fit button size
            end
        end

        -- Customize ActionBar 2 buttons
        local button2 = _G["MultiBarBottomLeftButton"..i]
        if button2 then
            -- Increase button size
            button2:SetWidth(40)  -- Set your desired width
            button2:SetHeight(40) -- Set your desired height

            -- Remove border and other textures
            local border2 = _G["MultiBarBottomLeftButton"..i.."Border"]
            if border2 then
                border2:Hide()
            end

            -- Remove normal texture
            local normalTexture2 = button2:GetNormalTexture()
            if normalTexture2 then
                normalTexture2:SetAlpha(0)
            end

            -- Remove other textures if necessary
            local icon2 = _G["MultiBarBottomLeftButton"..i.."Icon"]
            if icon2 then
                icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92) -- Adjust icon to fit button size
            end
        end
    end

    -- Center the main ActionBar
    ActionButton1:ClearAllPoints()
    ActionButton1:SetPoint("BOTTOM", UIParent, -270, 15) -- Adjust the offset as needed

    for i = 2, 12 do
        local button = _G["ActionButton"..i]
        if button then
            button:ClearAllPoints()
            if i == 7 then
                button:SetPoint("LEFT", _G["ActionButton6"], "RIGHT", 100, 0) -- Add 100 pixels of space between button 6 and 7
            else
                button:SetPoint("LEFT", _G["ActionButton"..(i-1)], "RIGHT", 0, 0)
            end
        end
    end

    -- Center the MultiBarBottomLeft
    MultiBarBottomLeftButton1:ClearAllPoints()
    MultiBarBottomLeftButton1:SetPoint("BOTTOM", UIParent, -270, 60) -- Adjust the offset as needed

    for i = 2, 12 do
        local button2 = _G["MultiBarBottomLeftButton"..i]
        if button2 then
            button2:ClearAllPoints()
            if i == 7 then
                button2:SetPoint("LEFT", _G["MultiBarBottomLeftButton6"], "RIGHT", 100, 0) -- Add 100 pixels of space between button 6 and 7
            else
                button2:SetPoint("LEFT", _G["MultiBarBottomLeftButton"..(i-1)], "RIGHT", 0, 0)
            end
        end
    end

  end

  -- Call the function to apply changes
  CustomizeActionBarButtons()

  -- Hide the PlayerFrame and prevent it from being shown again
  PlayerFrame:Hide()
  PlayerFrame:UnregisterAllEvents()
  PlayerFrame:SetScript("OnShow", function(self)
      self:Hide()
  end)
