
local _G = GW2UI.GetGlobalEnv()
local gw2art = "Interface\\AddOns\\GW2UI\\img\\globe\\"

-- Create a frame for the circle
local circleFrame = CreateFrame("Button", "CircleFrame", UIParent)
circleFrame:SetHeight(100)
circleFrame:SetWidth(100)
circleFrame:SetPoint("LEFT", _G["ActionButton6"], "RIGHT", 0, 26) -- Center the circle in the 100 pixels space

-- Make the frame interactive
circleFrame:EnableMouse(true)
circleFrame:RegisterForClicks("LeftButtonUp")

-- Set the script to handle the OnClick event
circleFrame:SetScript("OnClick", function()
    TargetUnit("player") -- Select yourself as the target
end)
--[[
circleFrame:SetScript("OnEnter", function()  
    TargetUnit("player")
end)
]]


-- Add the mask texture
local mask = circleFrame:CreateTexture(nil, "BACKGROUND")
mask:SetTexture(gw2art .. "mask.tga")
mask:SetAllPoints(circleFrame)

-- Add the globe texture
local globeTexture = circleFrame:CreateTexture(nil, "ARTWORK")
globeTexture:SetTexture(gw2art .. "globetextured.tga")
globeTexture:SetAllPoints(circleFrame)
globeTexture:SetVertexColor(0, 0, 0, 1) --sets background to black

-- Add the border texture
local border = circleFrame:CreateTexture(nil, "OVERLAY")
border:SetTexture(gw2art .. "globeborder.tga")
border:SetAllPoints(circleFrame)

-- Create a frame to act as a mask
local healthMask = CreateFrame("Frame", nil, circleFrame)
healthMask:SetWidth(100)
healthMask:SetHeight(100)
healthMask:SetPoint("BOTTOM", circleFrame, "BOTTOM", 0, 0)
healthMask:SetFrameLevel(circleFrame:GetFrameLevel() + 1)

-- Add a texture to the mask frame
local healthMaskTexture = healthMask:CreateTexture(nil, "BACKGROUND")
healthMaskTexture:SetTexture(gw2art .. "globetextured.tga")
healthMaskTexture:SetAllPoints(healthMask)

-- Create a frame for the health text
local healthTextFrame = CreateFrame("Frame", nil, circleFrame)
healthTextFrame:SetAllPoints(circleFrame)
healthTextFrame:SetFrameLevel(circleFrame:GetFrameLevel() + 2)

-- Create a font string to display health
local healthText = healthTextFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
healthText:SetPoint("CENTER", healthTextFrame, "CENTER", 0, 0)
healthText:SetTextColor(1, 1, 1, 1) -- White color

-- Function to update health text and mask height
local function UpdateHealth()
    local health = UnitHealth("player")
    local maxHealth = UnitHealthMax("player")
    local healthPercent = health / maxHealth

    healthText:SetText(health .. " / " .. maxHealth)

    -- Update mask height based on health percentage
    healthMask:SetHeight(100 * healthPercent)
end 

-- Register event to update health
circleFrame:RegisterEvent("UNIT_HEALTH")
circleFrame:RegisterEvent("UNIT_MAXHEALTH")
circleFrame:SetScript("OnEvent", UpdateHealth)

-- Initial update
UpdateHealth()

