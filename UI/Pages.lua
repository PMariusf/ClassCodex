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
        DrawPlaceholder(frame.content, "Talents", "Talent loadout display and comparison will be added next.")
    elseif tab == "Hero Talents" then
        DrawPlaceholder(frame.content, "Hero Talents", "The active Hero Talent tree is already detected. The visual tree and recommended build will be added next.")
    elseif tab == "Defensives" then
        DrawList(frame.content, "Defensives", guide.defensives)
    elseif tab == "Utility" then
        DrawList(frame.content, "Utility", guide.utility)
    elseif tab == "Macros" then
        DrawMacros(frame.content, guide)
    end
end
