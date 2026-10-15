local addonName, CC = ...

ClassCodex = CC
CC.version = "0.3.0"
CC.data = CC.data or {}

local events = CreateFrame("Frame")
local watchedEvents = {
    "ADDON_LOADED",
    "PLAYER_LOGIN",
    "PLAYER_SPECIALIZATION_CHANGED",
    "TRAIT_CONFIG_UPDATED",
    "PLAYER_EQUIPMENT_CHANGED",
    "COMBAT_RATING_UPDATE",
}

for _, eventName in ipairs(watchedEvents) do
    events:RegisterEvent(eventName)
end

function CC:Refresh()
    if self.MainFrame and self.MainFrame:IsShown() and self.Render then
        self:Render()
    end
end

SLASH_CLASSCODEX1 = "/codex"
SLASH_CLASSCODEX2 = "/classcodex"

SlashCmdList.CLASSCODEX = function(msg)
    msg = (msg or ""):lower():match("^%s*(.-)%s*$")

    if msg == "reset" then
        ClassCodexDB = {}
        if CC.MainFrame then
            CC.MainFrame:ClearAllPoints()
            CC.MainFrame:SetPoint("CENTER")
        end
        print("|cffd4af37Class Codex:|r window position reset.")
        return
    end

    if CC.Toggle then
        CC:Toggle()
    end
end

events:SetScript("OnEvent", function(_, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        ClassCodexDB = ClassCodexDB or {}
    elseif event == "PLAYER_LOGIN" then
        if CC.InitializeUI then
            CC:InitializeUI()
        end
        print("|cffd4af37Class Codex|r v" .. CC.version .. " loaded. Type /codex")
    else
        CC:Refresh()
    end
end)
