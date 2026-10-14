local addonName, CC = ...

local tabs = {
    "Overview",
    "Opener",
    "Single Target",
    "AoE",
    "Stats",
    "Defensives",
    "Utility",
    "Macros",
}

local function CreateText(parent, size, template)
    local fs = parent:CreateFontString(nil, "ARTWORK", template or "GameFontNormal")
    local font, _, flags = fs:GetFont()
    fs:SetFont(font, size, flags)
    fs:SetJustifyH("LEFT")
    fs:SetJustifyV("TOP")
    return fs
end

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

local function AddLine(content, anchor, text, index)
    local row = Track(content, CreateFrame("Frame", nil, content))
    row:SetSize(520, 32)
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -7)

    local bullet = CreateText(row, 13, "GameFontHighlight")
    bullet:SetPoint("TOPLEFT", 0, -2)
    bullet:SetText(index and tostring(index) or "•")
    bullet:SetTextColor(0.83, 0.68, 0.22)

    local label = CreateText(row, 14, "GameFontHighlight")
    label:SetPoint("TOPLEFT", bullet, "TOPRIGHT", 10, 0)
    label:SetPoint("RIGHT", row, "RIGHT", 0, 0)
    label:SetText(text)
    label:SetTextColor(0.92, 0.92, 0.92)
    label:SetWordWrap(true)

    return row
end

local function SectionTitle(content, text)
    local title = Track(content, CreateText(content, 20, "GameFontNormalLarge"))
    title:SetPoint("TOPLEFT", 0, 0)
    title:SetText(text)
    title:SetTextColor(0.93, 0.82, 0.43)
    return title
end

local function DrawList(content, titleText, entries)
    local anchor = SectionTitle(content, titleText)
    for i, text in ipairs(entries or {}) do
        anchor = AddLine(content, anchor, text, i)
    end
end

local function DrawOverview(content, guide, info)
    local title = SectionTitle(content, guide.title .. " " .. guide.subtitle)

    local sub = Track(content, CreateText(content, 15, "GameFontHighlight"))
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
    sub:SetText("Detected automatically from your current character.")
    sub:SetTextColor(0.72, 0.72, 0.75)

    local anchor = sub
    for _, text in ipairs(guide.overview or {}) do
        anchor = AddLine(content, anchor, text)
    end

    local technical = Track(content, CreateText(content, 12, "GameFontDisable"))
    technical:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -18)
    technical:SetText(
        "Spec ID: " .. tostring(info.specID or "—")
        .. "   Hero tree ID: " .. tostring(info.heroSpecID or "—")
        .. "   Talent config: " .. tostring(info.activeConfigID or "—")
    )
end

local function DrawStats(content, guide)
    local title = SectionTitle(content, "Desired Stats")

    local priorityLabel = Track(content, CreateText(content, 14, "GameFontNormal"))
    priorityLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -16)
    priorityLabel:SetText("General priority")
    priorityLabel:SetTextColor(0.93, 0.82, 0.43)

    local anchor = priorityLabel
    for i, text in ipairs((guide.stats and guide.stats.priority) or {}) do
        anchor = AddLine(content, anchor, text, i)
    end

    local currentTitle = Track(content, CreateText(content, 17, "GameFontNormalLarge"))
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
        local note = Track(content, CreateText(content, 12, "GameFontDisable"))
        note:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -14)
        note:SetWidth(520)
        note:SetText(guide.stats.note)
        note:SetWordWrap(true)
    end
end

local function DrawMacros(content, guide)
    local anchor = SectionTitle(content, "Macros")

    for _, macro in ipairs(guide.macros or {}) do
        local name = Track(content, CreateText(content, 15, "GameFontNormal"))
        name:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -16)
        name:SetText(macro.name)
        name:SetTextColor(0.93, 0.82, 0.43)

        local box = Track(content, CreateFrame("EditBox", nil, content, "BackdropTemplate"))
        box:SetMultiLine(true)
        box:SetAutoFocus(false)
        box:SetFontObject("ChatFontNormal")
        box:SetTextInsets(10, 10, 8, 8)
        box:SetSize(520, 70)
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

function CC:InitializeUI()
    if self.MainFrame then return end

    local frame = CreateFrame("Frame", "ClassCodexMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(780, 590)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetClampedToScreen(true)
    frame:Hide()

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    frame:SetBackdropColor(0.035, 0.035, 0.045, 0.97)
    frame:SetBackdropBorderColor(0.24, 0.24, 0.28, 1)

    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local point, _, relativePoint, x, y = self:GetPoint()
        ClassCodexDB.point = { point, relativePoint, x, y }
    end)

    if ClassCodexDB and ClassCodexDB.point then
        local p = ClassCodexDB.point
        frame:ClearAllPoints()
        frame:SetPoint(p[1], UIParent, p[2], p[3], p[4])
    end

    local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    header:SetPoint("TOPLEFT", 1, -1)
    header:SetPoint("TOPRIGHT", -1, -1)
    header:SetHeight(86)
    header:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    header:SetBackdropColor(0.07, 0.07, 0.085, 1)

    local accent = header:CreateTexture(nil, "ARTWORK")
    accent:SetColorTexture(0.83, 0.68, 0.22, 1)
    accent:SetPoint("BOTTOMLEFT")
    accent:SetPoint("BOTTOMRIGHT")
    accent:SetHeight(2)

    local title = CreateText(header, 22, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 22, -16)
    title:SetText("CLASS CODEX")
    title:SetTextColor(0.93, 0.82, 0.43)

    frame.identity = CreateText(header, 15, "GameFontHighlight")
    frame.identity:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)

    frame.heroText = CreateText(header, 12, "GameFontDisable")
    frame.heroText:SetPoint("LEFT", frame.identity, "RIGHT", 12, 0)

    local close = CreateFrame("Button", nil, header, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)

    local sidebar = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    sidebar:SetPoint("TOPLEFT", 1, -87)
    sidebar:SetPoint("BOTTOMLEFT", 1, 1)
    sidebar:SetWidth(180)
    sidebar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    sidebar:SetBackdropColor(0.05, 0.05, 0.06, 1)

    local content = CreateFrame("Frame", nil, frame)
    content:SetPoint("TOPLEFT", sidebar, "TOPRIGHT", 24, -22)
    content:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -24, 24)

    frame.content = content
    frame.tabButtons = {}
    frame.currentTab = "Overview"

    for i, tabName in ipairs(tabs) do
        local button = CreateFrame("Button", nil, sidebar, "BackdropTemplate")
        button:SetSize(178, 39)
        button:SetPoint("TOPLEFT", 1, -((i - 1) * 40) - 12)
        button:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })

        local label = CreateText(button, 14, "GameFontHighlight")
        label:SetPoint("LEFT", 18, 0)
        label:SetText(tabName)

        button.label = label
        button.tabName = tabName

        button:SetScript("OnClick", function(self)
            frame.currentTab = self.tabName
            CC:Render()
        end)

        frame.tabButtons[tabName] = button
    end

    self.MainFrame = frame
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
            button:SetBackdropColor(0.05, 0.05, 0.06, 0)
            button.label:SetTextColor(0.88, 0.88, 0.88)
        end
    end

    ClearContent(frame.content)

    if not guide then
        local title = SectionTitle(frame.content, "Guide not added yet")
        local text = Track(frame.content, CreateText(frame.content, 15, "GameFontHighlight"))
        text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -14)
        text:SetWidth(520)
        text:SetText(
            "Class Codex detected "
            .. (info.className or "your class")
            .. (info.specName and (" / " .. info.specName) or "")
            .. ", but v0.2 currently contains the complete demo only for Rogue / Subtlety."
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
    elseif tab == "Defensives" then
        DrawList(frame.content, "Defensives", guide.defensives)
    elseif tab == "Utility" then
        DrawList(frame.content, "Utility", guide.utility)
    elseif tab == "Macros" then
        DrawMacros(frame.content, guide)
    end
end

function CC:Toggle()
    if not self.MainFrame then self:InitializeUI() end

    if self.MainFrame:IsShown() then
        self.MainFrame:Hide()
    else
        self:Render()
        self.MainFrame:Show()
    end
end
