-- This moves the Quest Tracker to the top right and moves the Durability frame

local function DurabilityFrameMove()
    --it wouldnt stay so hide it
    --QuestWatchFrame:ClearAllPoints()
    --QuestWatchFrame:Hide()
    --QuestWatchFrame:SetPoint("TOPRIGHT", UIParent, -20, -60)

    DurabilityFrame:ClearAllPoints()
    DurabilityFrame:SetPoint("TOPRIGHT", MinimapCluster, -10, 80)
end

-- create a timer
local timer = CreateFrame("Frame")
timer:Hide()
timer:SetScript("OnUpdate", function()
    if GetTime() >= timer.time then
        timer.time = nil
        DurabilityFrameMove() --- Function we made above ---- 
        this:Hide()
        this:SetScript("OnUpdate", nil)
    end
end)

local events = CreateFrame("Frame", nil, UIParent)
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:SetScript("OnEvent", function()
    -- trigger the timer to go off 1 second after login
    timer.time = GetTime() + 1
    timer:Show()
end)
