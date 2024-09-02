--[[

]]
-- Create a new frame
local petHealthFrame = CreateFrame("StatusBar", "PetHealthFrame", UIParent)
petHealthFrame:SetWidth(100) -- Set the size of the frame
petHealthFrame:SetHeight(10)
petHealthFrame:SetPoint("CENTER", PetActionBarFrame, -170, -40) -- Position the frame

-- Set the texture
petHealthFrame:SetStatusBarTexture("Interface\\AddOns\\GW2UI\\img\\statusbar.tga")
petHealthFrame:GetStatusBarTexture():SetVertexColor(0.6, 0.1, 0.1) -- Set the color to red

-- Create a text label
local healthText = petHealthFrame:CreateFontString(nil, "OVERLAY")
healthText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
healthText:SetPoint("CENTER", petHealthFrame, "CENTER", 0, 0)
healthText:SetTextColor(1, 1, 1) -- Set the text color to white

-- Function to update the health bar and text
local function UpdatePetHealth()
    --if UnitExists("pet") then
    if PetActionBarFrame then
        local health = UnitHealth("pet")
        local maxHealth = UnitHealthMax("pet")
        petHealthFrame:SetMinMaxValues(0, maxHealth)
        petHealthFrame:SetValue(health)
        healthText:SetText(string.format("%d%%", (health / maxHealth) * 100))
        petHealthFrame:Show()
        --print("Pet show")
    else
        petHealthFrame:Hide()
        healthText:Hide()
        --print("Pet hide")
    end
end

-- Initial update
UpdatePetHealth()

-- Create an OnUpdate script to update the health bar regularly
petHealthFrame:SetScript("OnUpdate", function(self, elapsed)
    UpdatePetHealth()
end)

-- Register events to update the frame when the pet is summoned or dismissed
petHealthFrame:RegisterEvent("UNIT_PET")
petHealthFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
petHealthFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "UNIT_PET" or event == "PLAYER_ENTERING_WORLD" then
        UpdatePetHealth()
    end
end)

-- Create a new frame for the pet portrait
local petPortraitFrame = CreateFrame("Frame", "PetPortraitFrame", UIParent)
petPortraitFrame:SetWidth(50) -- Set the size of the portrait frame
petPortraitFrame:SetHeight(50)
petPortraitFrame:SetPoint("LEFT", petHealthFrame, "RIGHT", 10, 0) -- Position the frame to the right of the health frame
petPortraitFrame:SetFrameStrata("LOW")

-- Create a texture for the pet portrait
local petPortraitTexture = petPortraitFrame:CreateTexture(nil, "BACKGROUND")
petPortraitTexture:SetAllPoints(petPortraitFrame)

-- Function to update the pet portrait
local function UpdatePetPortrait()
    if UnitExists("pet") then
        SetPortraitTexture(petPortraitTexture, "pet")
        petPortraitFrame:Show()
    else
        petPortraitFrame:Hide()
    end
end

-- Initial update
UpdatePetPortrait()

-- Register events to update the portrait when the pet is summoned or dismissed
petPortraitFrame:RegisterEvent("UNIT_PET")
petPortraitFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
petPortraitFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "UNIT_PET" or event == "PLAYER_ENTERING_WORLD" then
        UpdatePetPortrait()
    end
end)

