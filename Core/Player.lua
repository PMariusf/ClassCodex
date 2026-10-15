local addonName, CC = ...

function CC:GetPlayerInfo()
    local className, classFile, classID = UnitClass("player")
    local specIndex = C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecialization()

    local specID, specName, specIcon
    if specIndex and C_SpecializationInfo and C_SpecializationInfo.GetSpecializationInfo then
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

function CC:GetCurrentStats()
    local crit = GetCritChance and GetCritChance() or 0
    local haste = GetHaste and GetHaste() or 0
    local mastery = GetMasteryEffect and GetMasteryEffect() or 0
    local versatility = 0

    if GetCombatRatingBonus and CR_VERSATILITY_DAMAGE_DONE then
        versatility = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) or 0
    end

    return {
        crit = crit,
        haste = haste,
        mastery = mastery,
        versatility = versatility,
    }
end
