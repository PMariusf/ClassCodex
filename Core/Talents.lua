local addonName, CC = ...

local function GetSpellDisplay(definitionInfo)
    if not definitionInfo then return nil end

    local name = definitionInfo.overrideName
    local icon = definitionInfo.overrideIcon
    local spellID = definitionInfo.spellID or definitionInfo.overriddenSpellID

    if spellID and C_Spell and C_Spell.GetSpellInfo then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        if spellInfo then
            name = name or spellInfo.name
            icon = icon or spellInfo.iconID
        end
    end

    return {
        name = name or (spellID and ("Spell " .. spellID) or "Unknown talent"),
        icon = icon,
        spellID = spellID,
    }
end

function CC:GetActiveTalentImportString()
    if not C_ClassTalents or not C_ClassTalents.GetActiveConfigID then
        return nil, "Talent API unavailable"
    end

    if not C_Traits or not C_Traits.GenerateImportString then
        return nil, "Talent export API unavailable"
    end

    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then
        return nil, "No active talent configuration"
    end

    local importString = C_Traits.GenerateImportString(configID)
    if not importString or importString == "" then
        return nil, "Active loadout could not be exported yet"
    end

    return importString
end

function CC:IsRecommendedBuildMatch(recommendedImportString)
    if not recommendedImportString or recommendedImportString == "" then
        return false, "No recommended build string"
    end

    local activeImportString, err = self:GetActiveTalentImportString()
    if not activeImportString then
        return false, err
    end

    return activeImportString == recommendedImportString
end

function CC:GetActiveTalentSnapshot()
    if not C_Traits or not C_ClassTalents or not C_ClassTalents.GetActiveConfigID then
        return nil, "Talent API unavailable"
    end

    local configID = C_ClassTalents.GetActiveConfigID()
    if not configID then
        return nil, "No active talent configuration"
    end

    local configInfo = C_Traits.GetConfigInfo and C_Traits.GetConfigInfo(configID)
    if not configInfo then
        return nil, "Could not read active talent configuration"
    end

    local snapshot = {
        configID = configID,
        loadoutName = configInfo.name,
        talents = {},
        heroTalents = {},
        heroTree = nil,
    }

    if C_Traits.GenerateImportString then
        snapshot.importString = C_Traits.GenerateImportString(configID)
    end

    local activeHeroSpecID
    if C_ClassTalents.GetActiveHeroTalentSpec then
        activeHeroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
    end

    if activeHeroSpecID and C_Traits.GetSubTreeInfo then
        local subTreeInfo = C_Traits.GetSubTreeInfo(configID, activeHeroSpecID)
        if subTreeInfo then
            snapshot.heroTree = {
                id = activeHeroSpecID,
                name = subTreeInfo.name or ("Hero Tree " .. activeHeroSpecID),
                description = subTreeInfo.description,
                iconAtlas = subTreeInfo.iconElementID,
                isActive = subTreeInfo.isActive,
            }
        end
    end

    for _, treeID in ipairs(configInfo.treeIDs or {}) do
        local nodeIDs = C_Traits.GetTreeNodes and C_Traits.GetTreeNodes(treeID) or nil
        for _, nodeID in ipairs(nodeIDs or {}) do
            local nodeInfo = C_Traits.GetNodeInfo and C_Traits.GetNodeInfo(configID, nodeID) or nil
            if nodeInfo and nodeInfo.isVisible and (nodeInfo.activeRank or 0) > 0 and nodeInfo.activeEntry then
                local entryID = nodeInfo.activeEntry.entryID
                local entryInfo = C_Traits.GetEntryInfo and C_Traits.GetEntryInfo(configID, entryID) or nil
                if entryInfo and entryInfo.definitionID then
                    local definitionInfo = C_Traits.GetDefinitionInfo and C_Traits.GetDefinitionInfo(entryInfo.definitionID) or nil
                    local display = GetSpellDisplay(definitionInfo)
                    if display then
                        display.nodeID = nodeID
                        display.entryID = entryID
                        display.rank = nodeInfo.activeRank or nodeInfo.currentRank or 1
                        display.maxRanks = nodeInfo.maxRanks or entryInfo.maxRanks or 1
                        display.subTreeID = nodeInfo.subTreeID

                        if activeHeroSpecID and nodeInfo.subTreeID == activeHeroSpecID then
                            table.insert(snapshot.heroTalents, display)
                        elseif not nodeInfo.subTreeID then
                            table.insert(snapshot.talents, display)
                        end
                    end
                end
            end
        end
    end

    table.sort(snapshot.talents, function(a, b)
        return (a.name or "") < (b.name or "")
    end)
    table.sort(snapshot.heroTalents, function(a, b)
        return (a.name or "") < (b.name or "")
    end)

    return snapshot
end
