local addonName, CC = ...

local ROTATION_TABS = {
    ["Opener"] = true,
    ["Single Target"] = true,
    ["AoE"] = true,
}

local PROFILES = {
    [259] = {
        resource = "Energy + Combo Points",
        resourceText = "Pool before major windows, spend at 5+ Combo Points, and avoid capping either resource.",
        burst = "Deathmark + Kingsbane",
        burstText = "Establish Garrote and Rupture first, then commit Deathmark/Kingsbane when the target will live through the window.",
    },
    [260] = {
        resource = "Energy + Combo Points",
        resourceText = "Keep resources flowing, spend frequently at 6+ Combo Points, and use Adrenaline Rush while Combo Points are low.",
        burst = "Adrenaline Rush cycle",
        burstText = "Cycle Adrenaline Rush and Between the Eyes aggressively; maintain Blade Flurry whenever worthwhile cleave targets are present.",
    },
    [261] = {
        resource = "Energy + Combo Points",
        resourceText = "Build to 6+ Combo Points for major finishers, avoid capping, and pool slightly before Shadow Dance burst windows.",
        burst = "Shadow Dance window",
        burstText = "Lead with Goremaw's Bite when ready, then align Shadow Dance with Shadow Blades and Secret Technique.",
    },
}

local function RemoveCallout(content)
    if not content or not content.classCodexRotationCallout then return end
    content.classCodexRotationCallout:Hide()
    content.classCodexRotationCallout:SetParent(nil)
    content.classCodexRotationCallout = nil
end

local function GetRowText(row)
    if not row or not row.GetRegions then return "" end

    local parts = {}
    for _, region in ipairs({ row:GetRegions() }) do
        if region and region.GetText then
            local text = region:GetText()
            if text and text ~= "" then
                table.insert(parts, text)
            end
        end
    end

    return table.concat(parts, " "):lower()
end

local function StyleRotationRows(content)
    for _, child in ipairs(content.children or {}) do
        if child and child.GetHeight and child.SetBackdropBorderColor and child:GetHeight() == 48 then
            local text = GetRowText(child)

            if text:find("cooldown", 1, true)
                or text:find("shadow dance", 1, true)
                or text:find("shadow blades", 1, true)
                or text:find("deathmark", 1, true)
                or text:find("kingsbane", 1, true)
                or text:find("adrenaline rush", 1, true)
            then
                child:SetBackdropBorderColor(0.83, 0.68, 0.22, 1)
            elseif text:find("combo point", 1, true)
                or text:find("energy", 1, true)
                or text:find("build", 1, true)
                or text:find("spend", 1, true)
            then
                child:SetBackdropBorderColor(0.30, 0.63, 0.82, 1)
            elseif text:find("maintain", 1, true)
                or text:find("keep ", 1, true)
                or text:find("active", 1, true)
            then
                child:SetBackdropBorderColor(0.36, 0.72, 0.46, 1)
            end
        end
    end
end

function CC:ApplyRotationCallouts()
    local frame = self.MainFrame
    if not frame or not ROTATION_TABS[frame.currentTab] then return end

    local info = self:GetPlayerInfo()
    local profile = info and PROFILES[info.specID]
    if not profile then return end

    local content = frame.content
    if not content then return end

    local first = content.children and content.children[1]
    if first and first.ClearAllPoints and first.SetPoint then
        first:ClearAllPoints()
        first:SetPoint("TOPLEFT", 0, -104)
    end

    local panel = CreateFrame("Frame", nil, content, "BackdropTemplate")
    panel:SetSize(560, 88)
    panel:SetPoint("TOPLEFT", 0, 0)
    panel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    panel:SetBackdropColor(0.035, 0.035, 0.045, 0.97)
    panel:SetBackdropBorderColor(0.18, 0.18, 0.22, 1)

    local accent = panel:CreateTexture(nil, "ARTWORK")
    accent:SetColorTexture(0.83, 0.68, 0.22, 1)
    accent:SetPoint("TOPLEFT", 0, 0)
    accent:SetPoint("BOTTOMLEFT", 0, 0)
    accent:SetWidth(3)

    local resourceLabel = CC.CreateText(panel, 11, "GameFontNormal")
    resourceLabel:SetPoint("TOPLEFT", 14, -10)
    resourceLabel:SetText("RESOURCE  •  " .. profile.resource)
    resourceLabel:SetTextColor(0.45, 0.72, 0.90)

    local resourceText = CC.CreateText(panel, 12, "GameFontHighlight")
    resourceText:SetPoint("TOPLEFT", resourceLabel, "BOTTOMLEFT", 0, -3)
    resourceText:SetWidth(532)
    resourceText:SetText(profile.resourceText)
    resourceText:SetTextColor(0.86, 0.86, 0.88)
    resourceText:SetWordWrap(true)

    local burstLabel = CC.CreateText(panel, 11, "GameFontNormal")
    burstLabel:SetPoint("TOPLEFT", resourceText, "BOTTOMLEFT", 0, -7)
    burstLabel:SetText("COOLDOWN  •  " .. profile.burst)
    burstLabel:SetTextColor(0.93, 0.82, 0.43)

    local burstText = CC.CreateText(panel, 12, "GameFontHighlight")
    burstText:SetPoint("TOPLEFT", burstLabel, "BOTTOMLEFT", 0, -3)
    burstText:SetWidth(532)
    burstText:SetText(profile.burstText)
    burstText:SetTextColor(0.86, 0.86, 0.88)
    burstText:SetWordWrap(true)

    content.classCodexRotationCallout = panel
    StyleRotationRows(content)
end

local OriginalRender = CC.Render
function CC:Render()
    local content = self.MainFrame and self.MainFrame.content
    RemoveCallout(content)

    OriginalRender(self)
    self:ApplyRotationCallouts()
end
