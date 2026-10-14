local addonName, CC = ...

CC.tabs = {
    "Overview",
    "Opener",
    "Single Target",
    "AoE",
    "Stats",
    "Talents",
    "Hero Talents",
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

CC.CreateText = CreateText

function CC:InitializeUI()
    if self.MainFrame then return end

    local frame = CreateFrame("Frame", "ClassCodexMainFrame", UIParent, "BackdropTemplate")
    frame:SetSize(820, 620)
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
    frame:SetBackdropColor(0.03, 0.03, 0.04, 0.98)
    frame:SetBackdropBorderColor(0.22, 0.22, 0.27, 1)

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
    header:SetHeight(92)
    header:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    header:SetBackdropColor(0.065, 0.065, 0.08, 1)

    local accent = header:CreateTexture(nil, "ARTWORK")
    accent:SetColorTexture(0.83, 0.68, 0.22, 1)
    accent:SetPoint("BOTTOMLEFT")
    accent:SetPoint("BOTTOMRIGHT")
    accent:SetHeight(2)

    local title = CreateText(header, 23, "GameFontNormalLarge")
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
    sidebar:SetPoint("TOPLEFT", 1, -93)
    sidebar:SetPoint("BOTTOMLEFT", 1, 1)
    sidebar:SetWidth(190)
    sidebar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    sidebar:SetBackdropColor(0.045, 0.045, 0.055, 1)

    local scrollFrame = CreateFrame("ScrollFrame", "ClassCodexScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", sidebar, "TOPRIGHT", 26, -24)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -42, 26)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(560, 1800)
    content.children = {}
    scrollFrame:SetScrollChild(content)

    frame.scrollFrame = scrollFrame
    frame.content = content
    frame.tabButtons = {}
    frame.currentTab = "Overview"

    for i, tabName in ipairs(self.tabs) do
        local button = CreateFrame("Button", nil, sidebar, "BackdropTemplate")
        button:SetSize(188, 38)
        button:SetPoint("TOPLEFT", 1, -((i - 1) * 39) - 12)
        button:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })

        local label = CreateText(button, 14, "GameFontHighlight")
        label:SetPoint("LEFT", 18, 0)
        label:SetText(tabName)

        button.label = label
        button.tabName = tabName
        button:SetScript("OnClick", function(self)
            frame.currentTab = self.tabName
            if frame.scrollFrame then
                frame.scrollFrame:SetVerticalScroll(0)
            end
            CC:Render()
        end)

        frame.tabButtons[tabName] = button
    end

    self.MainFrame = frame
end

function CC:Toggle()
    if not self.MainFrame then
        self:InitializeUI()
    end

    if self.MainFrame:IsShown() then
        self.MainFrame:Hide()
    else
        self:Render()
        self.MainFrame:Show()
    end
end
