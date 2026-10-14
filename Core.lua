local addonName, CC = ...

ClassCodex = CC
CC.version = "0.2.0"
CC.data = CC.data or {}

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
events:RegisterEvent("TRAIT_CONFIG_UPDATED")
events:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
events:RegisterEvent("COMBAT_RATING_UPDATE")

function CC:GetPlayerInfo()
    local className, classFile, classID = UnitClass("player")
    local specIndex = C_SpecializationInfo.GetSpecialization()

    local specID, specName, specIcon
    if specIndex then
        specID, specName, _, specIcon = C_SpecializationInfo.GetSpecializationInfo(specIndex)
    end

    local heroSpecID
    if C_ClassTalents and C_ClassTalents.GetActiveHeroTalentSpec then
        heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
    end

    local activeConfigID
    if C_ClassTalents and C_ClassTalents.GetActiveConfigID then
        activeConfigID = C_ClassTalents.GetActiveConfigID()
    end

    return {
        className = className,
        classFile = classFile,
        classID = classID,
        specIndex = specIndex,
        specID = specID,
        specName = specName,
        specIcon = specIcon,
        heroSpecID = heroSpecID,
        activeConfigID = activeConfigID,
    }
end

function CC:GetCurrentGuide()
    local info = self:GetPlayerInfo()
    if not info.classFile or not info.specID then return nil end

    local classData = self.data[info.classFile]
    return classData and classData[info.specID] or nil
end

function CC:GetCurrentStats()
    local crit = GetCritChance and GetCritChance() or 0
    local haste = GetHaste and GetHaste() or 0
    local mastery = GetMasteryEffect and GetMasteryEffect() or 0
    local vers = 0

    if GetCombatRatingBonus and CR_VERSATILITY_DAMAGE_DONE then
        vers = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) or 0
    end

    return {
        crit = crit,
        haste = haste,
        mastery = mastery,
        versatility = vers,
    }
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
        if CC.InitializeUI then CC:InitializeUI() end
        print("|cffd4af37Class Codex|r loaded. Type /codex")
    else
        CC:Refresh()
    end
end)
