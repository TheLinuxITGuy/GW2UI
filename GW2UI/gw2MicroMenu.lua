--[[
Author: YouTube.com/@TheLinuxITGuy
Built on: Linux Mint Debian Edition 12
This lua file hides the original Blizzard art work from 1.12. I've created new buttons and textured them to match
Guild Wars 2.
]]

local gw2art = "Interface\\AddOns\\GW2UI\\img\\microicons\\"
local gw2dimensions = 28
local gw2space = 25
---------------------------------------------Help Micro Button--------------------------------------------------
--Hide the original HelpMicroButton
HelpMicroButton:Hide()
--Create a new Help button
mbHelp = CreateFrame("Button", "mbHelp", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbHelp:SetWidth(gw2dimensions)
mbHelp:SetHeight(gw2dimensions)
mbHelp:SetPoint("TOPLEFT", UIParent, 0, 0) --sets the location of the button

--Set the button's normal texture
mbHelp:SetNormalTexture(gw2art .. "HelpMicroButton-Up.tga")
local HelpNormalTexture = mbHelp:GetNormalTexture()
HelpNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbHelp:SetPushedTexture(gw2art .. "HelpMicroButton-Up.tga")
local HelpPushedTexture = mbHelp:GetPushedTexture()
HelpPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbHelp:SetHighlightTexture(gw2art .. "HelpMicroButton-Up.tga")
local HelpHighlightTexture = mbHelp:GetHighlightTexture()
HelpHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--GameTooltip
mbHelp:SetScript("OnEnter", function()  
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(HelpMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(HelpMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbHelp:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbHelp:SetScript("OnClick", function(self, button, down)
  ToggleHelpFrame()
end)
---------------------------------------------Help Micro Button------------------------------------------------------

---------------------------------------------MainMenu Micro Button--------------------------------------------------
--Hide the original MainMenuMicroButton
MainMenuMicroButton:Hide()
--Create a new button
local mbMainMenu = CreateFrame("Button", "mbMainMenu", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbMainMenu:SetWidth(gw2dimensions)
mbMainMenu:SetHeight(gw2dimensions)
mbMainMenu:SetPoint("TOPLEFT", mbHelp, gw2space, 0) --sets the location of the button original -30, 12

--Set the button's normal texture
mbMainMenu:SetNormalTexture(gw2art .. "MainMenuMicroButton-Up.tga")
local MainMenuNormalTexture = mbMainMenu:GetNormalTexture()
MainMenuNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbMainMenu:SetPushedTexture(gw2art .. "MainMenuMicroButton-Up.tga")
local MainMenuPushedTexture = mbMainMenu:GetPushedTexture()
MainMenuPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbMainMenu:SetHighlightTexture(gw2art .. "MainMenuMicroButton-Up.tga")
local MainMenuHighlightTexture = mbMainMenu:GetHighlightTexture()
MainMenuHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--GameTooltip
mbMainMenu:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(MainMenuMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(MainMenuMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbMainMenu:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbMainMenu:SetScript("OnClick", function(self, button, down)
  ToggleGameMenu()
end)
---------------------------------------------MainMenu Micro Button--------------------------------------------------

---------------------------------------------PvP Micro Button--------------------------------------------------
--Hide the original TWMiniMapBattlefieldFrame
TWMiniMapBattlefieldFrame:Hide()
--Create a new button
local mbPvP = CreateFrame("Button", "mbPvP", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbPvP:ClearAllPoints()
mbPvP:SetWidth(gw2dimensions)
mbPvP:SetHeight(gw2dimensions)
mbPvP:SetPoint("TOPLEFT", mbMainMenu, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbPvP:SetNormalTexture(gw2art .. "PvpMicroButton-Up.tga")
local PvPNormalTexture = mbPvP:GetNormalTexture()
PvPNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbPvP:SetPushedTexture(gw2art .. "PvpMicroButton-Up.tga")
local PvPPushedTexture = mbPvP:GetPushedTexture()
PvPPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbPvP:SetHighlightTexture(gw2art .. "PvpMicroButton-Up.tga")
local PvPHighlightTexture = mbPvP:GetHighlightTexture()
PvPHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

function ShowTWBGQueueMenu()
  local TWBGQueueMinimapMenuFrame = CreateFrame('Frame', 'TWBGQueueMinimapMenuFrame', UIParent, 'UIDropDownMenuTemplate')
  UIDropDownMenu_Initialize(TWBGQueueMinimapMenuFrame, BuildTWBGQueueMenu, "MENU");
  ToggleDropDownMenu(1, nil, TWBGQueueMinimapMenuFrame, "cursor", 25, -50);
end

--GameTooltip
mbPvP:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText("Player vs. Player", 1, 1, 1, 1, true)
  GameTooltip:AddLine("Compete against the enemy faction in the battlegrounds.", nil, nil, nil, true)
  GameTooltip:Show()
end)

mbPvP:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbPvP:SetScript("OnClick", function(self, button, down)
  if BattlefieldFrame:IsVisible() then
    ToggleGameMenu()
  else
    --ShowUIPanel(BattlefieldFrame)
      ShowTWBGQueueMenu()
  end
end)
---------------------------------------------PvP Micro Button--------------------------------------------------

---------------------------------------------Turtle WoW Shop Micro Button--------------------------------------------------
--Hide the original TWMinimapShopFrame
TWMinimapShopFrame:SetParent(UIParent)
TWMinimapShopFrame:ClearAllPoints()
TWMinimapShopFrame:SetPoint("TOPRIGHT", 5000, 5000)
TWMinimapShopFrame:SetAlpha(0)
TWMinimapShopFrame:SetHeight(0)
TWMinimapShopFrame:SetWidth(0)
--Create a new button
local mbShop = CreateFrame("Button", "mbShop", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbShop:SetWidth(gw2dimensions)
mbShop:SetHeight(gw2dimensions)
mbShop:SetPoint("TOPLEFT", mbPvP, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbShop:SetNormalTexture(gw2art .. "StoreMicroButton-Up.tga")
local ShopNormalTexture = mbShop:GetNormalTexture()
ShopNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbShop:SetPushedTexture(gw2art .. "StoreMicroButton-Up.tga")
local ShopPushedTexture = mbShop:GetPushedTexture()
ShopPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbShop:SetHighlightTexture(gw2art .. "StoreMicroButton-Up.tga")
local ShopHighlightTexture = mbShop:GetHighlightTexture()
ShopHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--GameTooltip
mbShop:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText("Donation Rewards", 1, 1, 1, 1, true)
  GameTooltip:AddLine("Thank you for supporting Turtle WoW.", nil, nil, nil, true)
  GameTooltip:Show()
end)

mbShop:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbShop:SetScript("OnClick", function(self, button, down)
  tws_toggle()
end)
---------------------------------------------Turtle WoW Shop Micro Button--------------------------------------------------

---------------------------------------------Looking for Turtle Micro Button--------------------------------------------------
--Hide the original LFT_Minimap
--TWMinimapShopFrame:SetAlpha(0)
LFT_Minimap:SetParent(UIParent)
LFT_Minimap:ClearAllPoints()
LFT_Minimap:SetPoint("BOTTOMRIGHT", UIParent, -270, 55  )
LFT_Minimap:Hide()
-----Creates a new microButton-----
local mbLFT = CreateFrame("Button", "mbLFT", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbLFT:SetWidth(gw2dimensions)
mbLFT:SetHeight(gw2dimensions)
mbLFT:SetPoint("TOPLEFT", mbShop, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbLFT:SetNormalTexture(gw2art .. "LFGMicroButton-Up.tga")
local LFTNormalTexture = mbLFT:GetNormalTexture()
LFTNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbLFT:SetPushedTexture(gw2art .. "LFGMicroButton-Up.tga")
local LFTPushedTexture = mbLFT:GetPushedTexture()
LFTPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbLFT:SetHighlightTexture(gw2art .. "LFGMicroButton-Up.tga")
local LFTHighlightTexture = mbLFT:GetHighlightTexture()
LFTHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--GameTooltip
mbLFT:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText("Looking for Turtles", 1, 1, 1, 1, true)
  GameTooltip:AddLine("Find other players to fill your party. Running to the dungeon is required.", nil, nil, nil, true)
  GameTooltip:Show()
end)

mbLFT:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------

-----Reskins the eye-----
-- Create a new frame
local overlay = CreateFrame("Frame", nil, LFT_MinimapEye:GetParent())

-- Set the frame strata to be higher than LFT_MinimapEye
overlay:SetFrameStrata("DIALOG")

-- Set the size and position of the overlay to match LFT_MinimapEye
overlay:SetWidth(LFT_MinimapEye:GetWidth())
overlay:SetHeight(LFT_MinimapEye:GetHeight())
overlay:SetPoint("CENTER", LFT_MinimapEye, "CENTER")

-- Set the texture for the overlay
overlay.texture = overlay:CreateTexture()
overlay.texture:SetAllPoints()
overlay.texture:SetTexture("Interface\\AddOns\\tDF\\img\\uigroupfinderflipbookeye.tga")
overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)

----------------ANIMATION----------------
-- Define the TexCoords for each frame of the animation
local texCoords = {
  --512 is left and right, 256 is up and down
  {10/512, 55/512, 8/256, 55/256}, -- 1st row
  {74/512, 119/512, 8/256, 55/256}, --256 will stay the same as we are going right down the row
  {138/512, 183/512, 8/256, 55/256}, -- Add 64 to all of 512
  {202/512, 247/512, 8/256, 55/256}, -- Add 64 to all of 256
  {266/512, 311/512, 8/256, 55/256},
  {330/512, 375/512, 8/256, 55/256},
  {394/512, 439/512, 8/256, 55/256},
  {458/512, 503/512, 8/256, 55/256},

  {10/512, 55/512, 72/256, 119/256}, --2nd row
  {74/512, 119/512, 72/256, 119/256}, 
  {138/512, 183/512, 72/256, 119/256},
  {202/512, 247/512, 72/256, 119/256},
  {266/512, 311/512, 72/256, 119/256},
  {330/512, 375/512, 72/256, 119/256},
  {394/512, 439/512, 72/256, 119/256},
  {458/512, 503/512, 72/256, 119/256},

  {10/512, 55/512, 136/256, 183/256}, -- 3rd row
  {74/512, 119/512, 136/256, 183/256},
  {138/512, 183/512, 136/256, 183/256},
  {202/512, 247/512, 136/256, 183/256},
  {266/512, 311/512, 136/256, 183/256},
  {330/512, 375/512, 136/256, 183/256},
  {394/512, 439/512, 136/256, 183/256},
  {458/512, 503/512, 136/256, 183/256},

  {10/512, 55/512, 200/256, 247/256},--4th row
  {74/512, 119/512, 200/256, 247/256},
  {138/512, 183/512, 200/256, 247/256},
  {202/512, 247/512, 200/256, 247/256},
  {266/512, 311/512, 200/256, 247/256}
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
local updateInterval = .1 -- Adjust this to change the speed of the animation
overlay:SetScript("OnUpdate", function(self, elapsed)
  local elapsed = arg1 or 0
  timeSinceLastUpdate = timeSinceLastUpdate + elapsed
  if timeSinceLastUpdate > updateInterval then
      timeSinceLastUpdate = 0
      UpdateTexCoords()
  end
end)

--when group is formed
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")

frame:SetScript("OnEvent", function(self, event, ...)
  if GetNumPartyMembers() > 0 then
    --DEFAULT_CHAT_FRAME:AddMessage("The group has been formed!")
    --code here to stop the animation
    overlay:SetScript("OnUpdate", nil)
    overlay.texture:SetTexCoord(10/512, 55/512, 8/256, 55/256)
  else
    -- Reattach the OnUpdate script to restart the animation
    overlay:SetScript("OnUpdate", function(self, elapsed)
      local elapsed = arg1 or 0
      timeSinceLastUpdate = timeSinceLastUpdate + elapsed
      if timeSinceLastUpdate > updateInterval then
          timeSinceLastUpdate = 0
          UpdateTexCoords()
      end
    end)  
    UpdateTexCoords()
    LFT_Minimap:Hide()
  end
end)
----------------ANIMATION----------------

--findGroupButton
findGroupButton:SetScript("OnClick", function(self, button, down)
  LFT_Minimap:Show()
  overlay.texture:Show()
  findGroup()
end)

--findMoreButton
findMoreButton:SetScript("OnClick", function(self, button, down)
  LFT_Minimap:Show()
  overlay.texture:Show()
  findGroup()
end)

--leaveQueueButton
leaveQueueButton:SetScript("OnClick", function(self, button, down)
  LFT_Minimap:Hide()
  overlay.texture:Hide()
  leaveQueue()
end)
-----Reskins the eye-----

--click
mbLFT:SetScript("OnClick", function(self, button, down)
  LFT_Toggle()
end)
---------------------------------------------Looking for Turtle Micro Button--------------------------------------------------

---------------------------------------------Radio Micro Button--------------------------------------------------
--Hide the original EBC_Minimap
--TWMinimapShopFrame:SetAlpha(0)
EBC_Minimap:SetParent(UIParent)
EBC_Minimap:ClearAllPoints()
EBC_Minimap:Hide()
--Create a new button
local mbEBC = CreateFrame("Button", "mbEBC", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbEBC:SetWidth(gw2dimensions)
mbEBC:SetHeight(gw2dimensions)
mbEBC:SetPoint("TOPLEFT", mbLFT, gw2space, 0 ) --sets the location of the button
--Set the button's normal texture
mbEBC:SetNormalTexture(gw2art .. "GreatVaultMicroButton-Up.tga")
--Get the texture object and set its coordinates
local EBCNormalTexture = mbEBC:GetNormalTexture()
EBCNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)
--Set the button's pushed texture
mbEBC:SetPushedTexture(gw2art .. "GreatVaultMicroButton-Up.tga")
--Get the texture object and set its coordinates
local EBCPushedTexture = mbEBC:GetPushedTexture()
EBCPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)
--Set the button's highlight texture
mbEBC:SetHighlightTexture(gw2art .. "GreatVaultMicroButton-Up.tga")
--Get the texture object and set its coordinates
local EBCHighlightTexture = mbEBC:GetHighlightTexture()
EBCHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32  )
--GameTooltip
mbEBC:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText("Everlook Broadcasting Co.", 1, 1, 1, 1, true)
  GameTooltip:AddLine("Listen to some awesome tunes while you play Turtle WoW.", nil, nil, nil, true)
  GameTooltip:Show()
end)

mbEBC:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
function ShowEBCMinimapDropdown()
  if EBCMinimapDropdown:IsVisible() then
  EBCMinimapDropdown:Hide()
else
  EBCMinimapDropdown:Show()
end
end
mbEBC:SetScript("OnClick", function(self, button, down)
  --Look into the radio EBCMinimapDropdown:SetClampedToScreen()
  EBCMinimapDropdown:ClearAllPoints()
  EBCMinimapDropdown:SetPoint("CENTER", mbEBC, 0, 65)
  ShowEBCMinimapDropdown()
end)
---------------------------------------------Radio Micro Button--------------------------------------------------

---------------------------------------------WorldMap Micro Button--------------------------------------------------
--Hide the original Map Button
WorldMapMicroButton:Hide()
--Create a new button
local mbWorldMap = CreateFrame("Button", "mbWorldMap", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbWorldMap:SetWidth(gw2dimensions)
mbWorldMap:SetHeight(gw2dimensions)
mbWorldMap:SetPoint("TOPLEFT", mbEBC, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbWorldMap:SetNormalTexture(gw2art .. "WorldMapMicroButton-Up.tga")
local WorldMapNormalTexture = mbWorldMap:GetNormalTexture()
WorldMapNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbWorldMap:SetPushedTexture(gw2art .. "WorldMapMicroButton-Up.tga")
local WorldMapPushedTexture = mbWorldMap:GetPushedTexture()
WorldMapPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbWorldMap:SetHighlightTexture(gw2art .. "WorldMapMicroButton-Up.tga")
local WorldMapHighlightTexture = mbWorldMap:GetHighlightTexture()
WorldMapHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--GameTooltip
mbWorldMap:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(WorldMapMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(WorldMapMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbWorldMap:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbWorldMap:SetScript("OnClick", function(self, button, down)
  ToggleWorldMap()
end)
---------------------------------------------WorldMap Micro Button--------------------------------------------------

---------------------------------------------Social Micro Button--------------------------------------------------
--Hide the original SocialsMicroButton
SocialsMicroButton:Hide()
--Create a new button
local mbSocials = CreateFrame("Button", "mbSocials", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbSocials:SetWidth(gw2dimensions)
mbSocials:SetHeight(gw2dimensions)
mbSocials:SetPoint("TOPLEFT", mbWorldMap, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbSocials:SetNormalTexture(gw2art .. "GuildMicroButton-Up.tga")
local SocialsNormalTexture = mbSocials:GetNormalTexture()
SocialsNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbSocials:SetPushedTexture(gw2art .. "GuildMicroButton-Up.tga")
local SocialsPushedTexture = mbSocials:GetPushedTexture()
SocialsPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbSocials:SetHighlightTexture(gw2art .. "GuildMicroButton-Up.tga")
local SocialsHighlightTexture = mbSocials:GetHighlightTexture()
SocialsHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

mbSocials:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(SocialsMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(SocialsMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbSocials:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbSocials:SetScript("OnClick", function(self, button, down)
  ToggleFriendsFrame()
end)
---------------------------------------------Social Micro Button--------------------------------------------------

---------------------------------------------QuestLog Micro Button--------------------------------------------------
--Hide the original QuestLogMicroButton
QuestLogMicroButton:Hide()
--Create a new button
local mbQuestLog = CreateFrame("Button", "mbQuestLog", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbQuestLog:SetWidth(gw2dimensions)
mbQuestLog:SetHeight(gw2dimensions)
mbQuestLog:SetPoint("TOPLEFT", mbSocials, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbQuestLog:SetNormalTexture(gw2art .. "QuestLogMicroButton-Up.tga")
local QuestLogNormalTexture = mbQuestLog:GetNormalTexture()
QuestLogNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbQuestLog:SetPushedTexture(gw2art .. "QuestLogMicroButton-Up.tga")
local QuestLogPushedTexture = mbQuestLog:GetPushedTexture()
QuestLogPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbQuestLog:SetHighlightTexture(gw2art .. "QuestLogMicroButton-Up.tga")
local QuestLogHighlightTexture = mbQuestLog:GetHighlightTexture()
QuestLogHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32   )

mbQuestLog:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(QuestLogMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(QuestLogMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbQuestLog:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbQuestLog:SetScript("OnClick", function(self, button, down)
  ToggleQuestLog()
end)
---------------------------------------------QuestLog Micro Button--------------------------------------------------

---------------------------------------------Talent Micro Button--------------------------------------------------
--Hide the original TalentMicroButton
TalentMicroButton:ClearAllPoints()
TalentMicroButton:SetPoint("BOTTOMLEFT", UIParent, -30, -30)
--TalentMicroButton:Hide() didn't work for the original Talent button, so I moved it off the screen with SetPoint
--Create a new button
local mbTalent = CreateFrame("Button", "mbTalent", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbTalent:SetWidth(gw2dimensions)
mbTalent:SetHeight(gw2dimensions)
mbTalent:SetPoint("TOPLEFT", mbQuestLog, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbTalent:SetNormalTexture(gw2art .. "TalentMicroButton-Up.tga")
local TalentNormalTexture = mbTalent:GetNormalTexture()
TalentNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbTalent:SetPushedTexture(gw2art .. "TalentMicroButton-Up.tga")
local TalentPushedTexture = mbTalent:GetPushedTexture()
TalentPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbTalent:SetHighlightTexture(gw2art .. "TalentMicroButton-Up.tga")
local TalentHighlightTexture = mbTalent:GetHighlightTexture()
TalentHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

mbTalent:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText(TalentMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(TalentMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbTalent:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)

--click
mbTalent:SetScript("OnClick", function(self, button, down)
  ToggleTalentFrame()
end)
---------------------------------------------Talent Micro Button--------------------------------------------------

---------------------------------------------Spellbook Micro Button--------------------------------------------------
--Hide the original QuestLogMicroButton
SpellbookMicroButton:Hide()
--Create a new button
local mbSpellBook = CreateFrame("Button", "mbSpellBook", UIParent, "UIPanelButtonTemplate")
--Set its properties
mbSpellBook:SetWidth(gw2dimensions)
mbSpellBook:SetHeight(gw2dimensions)
mbSpellBook:SetPoint("TOPLEFT", mbTalent, gw2space, 0) --sets the location of the button

--Set the button's normal texture
mbSpellBook:SetNormalTexture(gw2art .. "SpellbookMicroButton-Up.tga")
local SpellbookNormalTexture = mbSpellBook:GetNormalTexture()
SpellbookNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's pushed texture
mbSpellBook:SetPushedTexture(gw2art .. "SpellbookMicroButton-Up.tga")
local SpellbookPushedTexture = mbSpellBook:GetPushedTexture()
SpellbookPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

--Set the button's highlight texture
mbSpellBook:SetHighlightTexture(gw2art .. "SpellbookMicroButton-Up.tga")
local SpellbookHighlightTexture = mbSpellBook:GetHighlightTexture()
SpellbookHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

mbSpellBook:SetScript("OnEnter", function()
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
  GameTooltip:SetText("Spellbook & Abilities", 1, 1, 1, 1, true)
  GameTooltip:AddLine("All of your spells and abilities. To move a spell or ability to your Action Bar, open the Spellbook & Abilities window, left-click that spell or ability, and drag it down to your Action Bar.", nil, nil, nil, true)
  GameTooltip:Show()
end)

mbSpellBook:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)
------
--click
mbSpellBook:SetScript("OnClick", function(self, button, down)
  ToggleSpellBook(BOOKTYPE_SPELL)
end)
---------------------------------------------Spellbook Micro Button--------------------------------------------------

---------------------------------------------Character Micro Button--------------------------------------------------
-- Hide the original CharacterMicroButton
CharacterMicroButton:Hide()

-- Create a new button
local mbCharacter = CreateFrame("Button", "mbCharacter", UIParent, "UIPanelButtonTemplate")

-- Set its properties
mbCharacter:SetWidth(gw2dimensions)
mbCharacter:SetHeight(gw2dimensions)
mbCharacter:ClearAllPoints()
mbCharacter:SetPoint("TOPLEFT", mbSpellBook, gw2space, 0) -- position Character button next to Spellbook

-- Set the button's normal texture
mbCharacter:SetNormalTexture(gw2art .. "CharacterMicroButton-Up.tga")
local CharacterNormalTexture = mbCharacter:GetNormalTexture()
CharacterNormalTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

-- Set the button's pushed texture
mbCharacter:SetPushedTexture(gw2art .. "CharacterMicroButton-Up.tga")
local CharacterPushedTexture = mbCharacter:GetPushedTexture()
CharacterPushedTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

-- Set the button's highlight texture
mbCharacter:SetHighlightTexture(gw2art .. "CharacterMicroButton-Up.tga")
local CharacterHighlightTexture = mbCharacter:GetHighlightTexture()
CharacterHighlightTexture:SetTexCoord(0/32, 32/32, 0/32, 32/32)

-- GameTooltip
mbCharacter:SetScript("OnEnter", function()
  GameTooltip:SetOwner(mbCharacter, "ANCHOR_RIGHT")
  GameTooltip:SetText(CharacterMicroButton.tooltipText, 1, 1, 1, 1, true)
  GameTooltip:AddLine(CharacterMicroButton.newbieText, nil, nil, nil, true)
  GameTooltip:Show()
end)

mbCharacter:SetScript("OnLeave", function()
  GameTooltip:Hide()
end)

-- Click
mbCharacter:SetScript("OnClick", function(self, button, down)
  ToggleCharacter("PaperDollFrame")
end)
---------------------------------------------Character Micro Button--------------------------------------------------

---------------------------------------------Latency Micro Button---------------------------------------------
-- Create your own button
local mbLatency = MainMenuBarPerformanceBarFrameButton

-- Set the normal texture and store a reference to it
mbLatency.texture = mbLatency:CreateTexture(nil, "BACKGROUND")
mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\Latency.tga")
--mbLatency:SetTexCoord(3/32, 28/32, 56/64, 60/64)
-- Set the position and size of your button
mbLatency:ClearAllPoints()
mbLatency:SetPoint("CENTER", mbHelp, 0, -14) -- You can adjust the position as needed
mbLatency:SetWidth(22)
mbLatency:SetHeight(13)

-- Add this to update each frame
mbLatency:SetScript("OnUpdate", function(self, elapsed)
  -- Get the current latency
  local _, _, latencyHome = GetNetStats()
  --this.texture:SetVertexColor(0, 1, 0)
  -- Change the color based on latency
  if latencyHome < 200 then
    mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyGreen.tga")
      -- Latency is good, set color to green
      --this.texture:SetVertexColor(0, 1, 0)
  elseif latencyHome < 300 then
      -- Latency is poor, set color to yellow
      --this.texture:SetVertexColor(1, 1, 0)
      mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyYellow.tga")
  else
      -- Latency is bad, set color to red
      --this.texture:SetVertexColor(1, 0, 0)
      mbLatency:SetNormalTexture("Interface\\AddOns\\tDF\\img\\LatencyRed.tga")
  end
end)
---------------------------------------------Latency Micro Button---------------------------------------------
