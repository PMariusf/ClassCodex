local addonName, CC = ...

local function Track(content, widget)
    content.children = content.children or {}
    table.insert(content.children, widget)
    return widget
end

local function ClearContent(content)
    for _, child in ipairs(content.children or {}) do
        child:Hide()
        child:SetParent(nil)
    end
    content.children = {}
end

local function SectionTitle(content, text)
    local title = Track(content, CC.CreateText(content, 20, "GameFontNormalLarge"))
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(text)
    title:SetTextColor(0.93, 0.82, 0.43)
    return title
end

local function AddLine(content, anchor, text, index)
    local row = Track(content, CreateFrame("Frame", nil, content))
    row:SetSize(560, 32)
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -7)

    local bullet = CC.CreateText(row, 13, "GameFontHighlight")
    bullet:SetPoint("TOPLEFT", 0, -2)
    bullet:SetText(index and tostring(index) or "•")
    bullet:SetTextColor(0.83, 0.68, 0.22)

    local label = CC.CreateText(row, 14, "GameFontHighlight")
    label:SetPoint("TOPLEFT", bullet, "TOPRIGHT", 10, 0)
    label:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    label:SetText(text)
    label:SetTextColor(0.92, 0.92, 0.92)
    label:SetWordWrap(true)

    return row
end

local function DrawList(content, titleText, entries)
    local anchor = SectionTitle(content, titleText)
    for i, text in ipairs(entries or {}) do
        anchor = AddLine(content, anchor, text, i)
    end
end

local function DrawOverview(content, guide, info)
    local title = SectionTitle(content, guide.title .. " " .. guide.subtitle)

    local sub = Track(content, CC.CreateText(content, 15, "GameFontHighlight"))
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
    sub:SetText("Detected automatically from your current character.")
    sub:SetTextColor(0.72, 0.72, 0.75)

    local anchor = sub
    for _, text in ipairs(guide.overview or {}) do
        anchor = AddLine(content, anchor, text)
    end

    local technical = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
    technical:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -18)
    technical:SetText(
        "Spec ID: " .. tostring(info.specID or "—")
        .. "   Hero tree ID: " .. tostring(info.heroSpecID or "—")
        .. "   Talent config: " .. tostring(info.activeConfigID or "—")
    )
end

local function DrawStats(content, guide)
    local title = SectionTitle(content, "Desired Stats")

    local priorityLabel = Track(content, CC.CreateText(content, 14, "GameFontNormal"))
    priorityLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -16)
    priorityLabel:SetText("General priority")
    priorityLabel:SetTextColor(0.93, 0.82, 0.43)

    local anchor = priorityLabel
    for i, text in ipairs((guide.stats and guide.stats.priority) or {}) do
        anchor = AddLine(content, anchor, text, i)
    end

    local currentTitle = Track(content, CC.CreateText(content, 17, "GameFontNormalLarge"))
    currentTitle:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -24)
    currentTitle:SetText("Your Character")
    currentTitle:SetTextColor(0.93, 0.82, 0.43)

    local stats = CC:GetCurrentStats()
    local rows = {
        string.format("Critical Strike: %.1f%%", stats.crit or 0),
        string.format("Haste: %.1f%%", stats.haste or 0),
        string.format("Mastery: %.1f%%", stats.mastery or 0),
        string.format("Versatility: %.1f%%", stats.versatility or 0),
    }

    anchor = currentTitle
    for _, text in ipairs(rows) do
        anchor = AddLine(content, anchor, text)
    end

    if guide.stats and guide.stats.note then
        local note = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
        note:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -14)
        note:SetWidth(560)
        note:SetText(guide.stats.note)
        note:SetWordWrap(true)
    end
end

local function DrawTalentRow(content, anchor, talent)
    local row = Track(content, CreateFrame("Frame", nil, content, "BackdropTemplate"))
    row:SetSize(560, 46)
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -7)
    row:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    row:SetBackdropColor(0.055, 0.055, 0.065, 0.95)
    row:SetBackdropBorderColor(0.16, 0.16, 0.19, 1)

    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(34, 34)
    icon:SetPoint("LEFT", 6, 0)
    icon:SetTexture(talent.icon or "Interface\\Icons\\INV_Misc_QuestionMark")

    local name = CC.CreateText(row, 14, "GameFontHighlight")
    name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -3)
    name:SetText(talent.name or "Unknown talent")
    name:SetTextColor(0.95, 0.95, 0.95)

    local rank = CC.CreateText(row, 12, "GameFontDisable")
    rank:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 10, 3)
    rank:SetText("Rank " .. tostring(talent.rank or 1) .. " / " .. tostring(talent.maxRanks or 1))

    if talent.spellID then
        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            if GameTooltip and GameTooltip.SetOwner and GameTooltip.SetSpellByID then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetSpellByID(talent.spellID)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function()
            if GameTooltip then GameTooltip:Hide() end
        end)
    end

    return row
end

local function DrawTalentCollectionFromAnchor(content, anchor, talents)
    if not talents or #talents == 0 then
        local empty = Track(content, CC.CreateText(content, 14, "GameFontHighlight"))
        empty:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -14)
        empty:SetWidth(560)
        empty:SetText("No selected talents could be read from the active loadout.")
        empty:SetTextColor(0.72, 0.72, 0.76)
        return empty
    end

    for _, talent in ipairs(talents) do
        anchor = DrawTalentRow(content, anchor, talent)
    end

    return anchor
end

local function DrawTalentCollection(content, titleText, talents, subtitle)
    local title = SectionTitle(content, titleText)
    local anchor = title

    if subtitle then
        local sub = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
        sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
        sub:SetWidth(560)
        sub:SetText(subtitle)
        anchor = sub
    end

    DrawTalentCollectionFromAnchor(content, anchor, talents)
end

local function CreateModeButton(content, anchor, label, key, activeKey)
    local button = Track(content, CreateFrame("Button", nil, content, "UIPanelButtonTemplate"))
    button:SetSize(116, 28)
    button:SetText(label)

    if anchor then
        button:SetPoint("LEFT", anchor, "RIGHT", 8, 0)
    end

    if key == activeKey then
        button:Disable()
    end

    button:SetScript("OnClick", function()
        ClassCodexDB.recommendedBuildMode = key
        CC:Render()
    end)

    return button
end

local function CreateImportBox(content, anchor, importString)
    local box = Track(content, CreateFrame("EditBox", nil, content, "BackdropTemplate"))
    box:SetAutoFocus(false)
    box:SetFontObject("ChatFontNormal")
    box:SetTextInsets(8, 8, 6, 6)
    box:SetSize(560, 34)
    box:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -8)
    box:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    box:SetBackdropColor(0.025, 0.025, 0.03, 1)
    box:SetBackdropBorderColor(0.18, 0.18, 0.21, 1)
    box:SetText(importString or "")
    box:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    box:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    return box
end

local function DrawRecommendedBuild(content, guide, snapshot)
    local builds = guide.recommendedBuilds
    if not builds then return nil end

    ClassCodexDB = ClassCodexDB or {}
    local mode = ClassCodexDB.recommendedBuildMode or "mythicplus"
    if not builds[mode] then mode = "raid" end

    local title = SectionTitle(content, "Recommended Build")

    local raidButton = Track(content, CreateFrame("Button", nil, content, "UIPanelButtonTemplate"))
    raidButton:SetSize(116, 28)
    raidButton:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -12)
    raidButton:SetText("Raid")
    if mode == "raid" then raidButton:Disable() end
    raidButton:SetScript("OnClick", function()
        ClassCodexDB.recommendedBuildMode = "raid"
        CC:Render()
    end)

    local mythicButton = CreateModeButton(content, raidButton, "Mythic+", "mythicplus", mode)

    local profile = builds[mode]
    local profileName = Track(content, CC.CreateText(content, 16, "GameFontNormal"))
    profileName:SetPoint("TOPLEFT", raidButton, "BOTTOMLEFT", 0, -16)
    profileName:SetWidth(560)
    profileName:SetText(profile.name or profile.label or "Recommended build")
    profileName:SetTextColor(0.93, 0.82, 0.43)

    local matches = snapshot and snapshot.importString and profile.importString
        and snapshot.importString == profile.importString

    local status = Track(content, CC.CreateText(content, 14, "GameFontHighlight"))
    status:SetPoint("TOPLEFT", profileName, "BOTTOMLEFT", 0, -8)
    if matches then
        status:SetText("✓ Your active loadout is an exact match")
        status:SetTextColor(0.35, 0.85, 0.45)
    else
        status:SetText("• Your active loadout differs from this recommendation")
        status:SetTextColor(0.95, 0.72, 0.30)
    end

    local meta = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
    meta:SetPoint("TOPLEFT", status, "BOTTOMLEFT", 0, -6)
    meta:SetWidth(560)
    meta:SetText(
        "Hero: " .. tostring(profile.heroTree or "—")
        .. "   Patch: " .. tostring(profile.patch or "—")
        .. "   Source: " .. tostring(profile.source or "—")
    )

    local note = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
    note:SetPoint("TOPLEFT", meta, "BOTTOMLEFT", 0, -8)
    note:SetWidth(560)
    note:SetText(profile.note or "")
    note:SetWordWrap(true)

    local codeLabel = Track(content, CC.CreateText(content, 12, "GameFontNormal"))
    codeLabel:SetPoint("TOPLEFT", note, "BOTTOMLEFT", 0, -12)
    codeLabel:SetText("Import code — click the box, then Ctrl/Cmd+C")
    codeLabel:SetTextColor(0.82, 0.82, 0.85)

    local anchor = CreateImportBox(content, codeLabel, profile.importString)

    if profile.alternative then
        local altLabel = Track(content, CC.CreateText(content, 13, "GameFontNormal"))
        altLabel:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -14)
        altLabel:SetText("Alternative: " .. tostring(profile.alternative.name or "Alternative build"))
        altLabel:SetTextColor(0.80, 0.80, 0.84)
        anchor = CreateImportBox(content, altLabel, profile.alternative.importString)
    end

    return anchor
end

local function DrawTalents(content, guide)
    local snapshot, err = CC:GetActiveTalentSnapshot()
    if not snapshot then
        local title = SectionTitle(content, "Talents")
        local text = Track(content, CC.CreateText(content, 14, "GameFontHighlight"))
        text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
        text:SetText(err or "Unable to read the current talent loadout.")
        return
    end

    local anchor = DrawRecommendedBuild(content, guide, snapshot)
    if not anchor then
        anchor = SectionTitle(content, "Talents")
    end

    local activeTitle = Track(content, CC.CreateText(content, 18, "GameFontNormalLarge"))
    activeTitle:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -24)
    activeTitle:SetText("Your Active Loadout")
    activeTitle:SetTextColor(0.93, 0.82, 0.43)

    local sub = Track(content, CC.CreateText(content, 12, "GameFontDisable"))
    sub:SetPoint("TOPLEFT", activeTitle, "BOTTOMLEFT", 0, -9)
    sub:SetWidth(560)
    sub:SetText(
        (snapshot.loadoutName or "Unnamed loadout")
        .. "  •  Config " .. tostring(snapshot.configID)
    )

    DrawTalentCollectionFromAnchor(content, sub, snapshot.talents)
end

local function DrawHeroTalents(content)
    local snapshot, err = CC:GetActiveTalentSnapshot()
    if not snapshot then
        local title = SectionTitle(content, "Hero Talents")
        local text = Track(content, CC.CreateText(content, 14, "GameFontHighlight"))
        text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
        text:SetText(err or "Unable to read the current Hero Talent tree.")
        return
    end

    local treeName = snapshot.heroTree and snapshot.heroTree.name or "No active Hero Talent tree"
    local subtitle = treeName
    if snapshot.heroTree and snapshot.heroTree.description and snapshot.heroTree.description ~= "" then
        subtitle = subtitle .. " — " .. snapshot.heroTree.description
    end

    DrawTalentCollection(content, "Hero Talents", snapshot.heroTalents, subtitle)
end

local function DrawMacros(content, guide)
    local anchor = SectionTitle(content, "Macros")

    for _, macro in ipairs(guide.macros or {}) do
        local name = Track(content, CC.CreateText(content, 15, "GameFontNormal"))
        name:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -16)
        name:SetText(macro.name)
        name:SetTextColor(0.93, 0.82, 0.43)

        local box = Track(content, CreateFrame("EditBox", nil, content, "BackdropTemplate"))
        box:SetMultiLine(true)
        box:SetAutoFocus(false)
        box:SetFontObject("ChatFontNormal")
        box:SetTextInsets(10, 10, 8, 8)
        box:SetSize(560, 70)
        box:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -6)
        box:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
        })
        box:SetBackdropColor(0.025, 0.025, 0.03, 1)
        box:SetBackdropBorderColor(0.18, 0.18, 0.21, 1)
        box:SetText(macro.body)

        anchor = box
    end
end

local function DrawPlaceholder(content, titleText, body)
    local title = SectionTitle(content, titleText)
    local text = Track(content, CC.CreateText(content, 14, "GameFontHighlight"))
    text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
    text:SetWidth(560)
    text:SetText(body)
    text:SetTextColor(0.78, 0.78, 0.82)
    text:SetWordWrap(true)
end

function CC:Render()
    local frame = self.MainFrame
    if not frame then return end

    local info = self:GetPlayerInfo()
    local guide = self:GetCurrentGuide()

    frame.identity:SetText(
        (info.className or "Unknown Class")
        .. (info.specName and ("  •  " .. info.specName) or "")
    )

    frame.heroText:SetText(
        info.heroSpecID and ("Hero tree ID: " .. info.heroSpecID) or "No active Hero Talent tree"
    )

    for tabName, button in pairs(frame.tabButtons) do
        if tabName == frame.currentTab then
            button:SetBackdropColor(0.13, 0.12, 0.08, 1)
            button.label:SetTextColor(0.93, 0.82, 0.43)
        else
            button:SetBackdropColor(0.045, 0.045, 0.055, 0)
            button.label:SetTextColor(0.88, 0.88, 0.88)
        end
    end

    ClearContent(frame.content)

    if not guide then
        DrawPlaceholder(
            frame.content,
            "Guide not added yet",
            "Class Codex detected " .. (info.className or "your class")
            .. (info.specName and (" / " .. info.specName) or "")
            .. ", but this development build currently contains complete data only for Rogue / Subtlety."
        )
        return
    end

    local tab = frame.currentTab
    if tab == "Overview" then
        DrawOverview(frame.content, guide, info)
    elseif tab == "Opener" then
        DrawList(frame.content, "Opener", guide.opener)
    elseif tab == "Single Target" then
        DrawList(frame.content, "Single Target Priority", guide.singleTarget)
    elseif tab == "AoE" then
        DrawList(frame.content, "AoE Priority", guide.aoe)
    elseif tab == "Stats" then
        DrawStats(frame.content, guide)
    elseif tab == "Talents" then
        DrawTalents(frame.content, guide)
    elseif tab == "Hero Talents" then
        DrawHeroTalents(frame.content)
    elseif tab == "Defensives" then
        DrawList(frame.content, "Defensives", guide.defensives)
    elseif tab == "Utility" then
        DrawList(frame.content, "Utility", guide.utility)
    elseif tab == "Macros" then
        DrawMacros(frame.content, guide)
    end
end
