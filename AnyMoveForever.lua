-- AnyMove Forever: mover y escalar cualquier ventana o elemento de la interfaz
-- de WoW Forever. Inspirado en MoveAny (D4KiR), escrito desde cero: su codigo
-- es "All Rights Reserved" y no se usa nada de el.
--
-- Como funciona:
--   * Posicion guardada como el CENTRO del marco en unidades de UIParent
--     (x, y) y una escala. Asi el tamano cambia alrededor del centro y la
--     posicion no depende de la escala del marco.
--   * Blizzard recoloca muchos marcos (ventanas al abrirse, bolsas, Modo
--     Edicion...). Se engancha SetPoint/SetScale de cada marco: si lo mueve
--     otro, se vuelve a aplicar lo guardado. "applying" evita el bucle.
--   * Marcos protegidos en combate: no se tocan; quedan en cola y se aplican
--     al salir de combate (PLAYER_REGEN_ENABLED).
--   * Ventanas: se arrastran directamente. Resto: modo mover (/amf), con un
--     recuadro por elemento (arrastrar, rueda = tamano, clic derecho = reset).

local ADDON_NAME, ns = ...
local L = ns.L

local BRAND = "|cffd597ff"
local PREFIX = BRAND .. "AnyMove Forever|r: "
local MIN_SCALE, MAX_SCALE, SCALE_STEP = 0.3, 2.5, 0.05

local db
local elements = {}      -- nombre -> { category, default, window }
local order = {}         -- nombres en el orden de las categorias
local hooked = {}        -- nombre -> true (ya enganchado)
local originals = {}     -- nombre -> puntos y escala antes de tocarlo
local applying = {}      -- nombre -> true mientras lo movemos nosotros
local pending = {}       -- nombre -> true: protegido, a aplicar tras el combate
local movers = {}
local unlocked = false

for _, category in ipairs(ns.CATEGORIES) do
    for _, name in ipairs(category.list) do
        elements[name] = { category = category.key, default = category.default, window = category.windows }
        order[#order + 1] = name
    end
end

-- "PlayerSpellsFrame" -> "Player Spells"
local function Pretty(name)
    return (name:gsub("Frame$", ""):gsub("(%l)(%u)", "%1 %2"):gsub("(%a)(%d)", "%1 %2"))
end
ns.Pretty = Pretty

local function Entry(name)
    db.elements[name] = db.elements[name] or {}
    return db.elements[name]
end

local function IsEnabled(name)
    local entry = db.elements[name]
    if entry and entry.enabled ~= nil then return entry.enabled end
    return elements[name].default
end

local function Blocked(frame)
    return frame:IsProtected() and InCombatLockdown()
end

--------------------------------------------------
-- APLICAR / GUARDAR
--------------------------------------------------
local function SaveOriginal(name, frame)
    if originals[name] then return end
    local original = { scale = frame:GetScale() }
    for i = 1, frame:GetNumPoints() do original[i] = { frame:GetPoint(i) } end
    originals[name] = original
end

local function Apply(name)
    local frame = _G[name]
    if not frame or not IsEnabled(name) then return end
    local entry = db.elements[name]
    if not entry or (not entry.x and not entry.scale) then return end
    if Blocked(frame) then
        pending[name] = true
        return
    end
    SaveOriginal(name, frame)
    applying[name] = true
    if entry.scale then frame:SetScale(entry.scale) end
    if entry.x then
        local ratio = UIParent:GetEffectiveScale() / frame:GetEffectiveScale()
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", entry.x * ratio, entry.y * ratio)
    end
    applying[name] = nil
end
ns.Apply = Apply

-- Guarda el centro actual de un marco (en unidades de UIParent)
local function SaveFromFrame(name, frame)
    local cx, cy = frame:GetCenter()
    if not cx then return end
    local ratio = frame:GetEffectiveScale() / UIParent:GetEffectiveScale()
    local entry = Entry(name)
    entry.x, entry.y = cx * ratio, cy * ratio
end

local function Reset(name)
    local entry = db.elements[name]
    if entry then entry.x, entry.y, entry.scale = nil, nil, nil end
    local frame, original = _G[name], originals[name]
    if frame and original and not Blocked(frame) then
        applying[name] = true
        frame:SetScale(original.scale)
        frame:ClearAllPoints()
        for _, point in ipairs(original) do frame:SetPoint(unpack(point)) end
        applying[name] = nil
        originals[name] = nil
    end
end

--------------------------------------------------
-- REGISTRO DE CADA MARCO
--------------------------------------------------
local function MakeDraggable(name, frame)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:HookScript("OnDragStart", function(self)
        if not IsEnabled(name) or Blocked(self) then return end
        self.anyMoveDragging = true
        self:StartMoving()
    end)
    frame:HookScript("OnDragStop", function(self)
        if not self.anyMoveDragging then return end
        self.anyMoveDragging = nil
        self:StopMovingOrSizing()
        -- La posicion la guarda el addon, no la cache de diseno del juego
        self:SetUserPlaced(false)
        SaveOriginal(name, self)
        SaveFromFrame(name, self)
        Apply(name)
    end)
end

local function Register(name)
    if hooked[name] then return end
    local frame = _G[name]
    if type(frame) ~= "table" or not frame.SetPoint then return end
    hooked[name] = true
    -- Si otro (Blizzard) lo recoloca o reescala, vuelve lo guardado
    hooksecurefunc(frame, "SetPoint", function() if not applying[name] then Apply(name) end end)
    hooksecurefunc(frame, "SetScale", function() if not applying[name] then Apply(name) end end)
    if elements[name].window then MakeDraggable(name, frame) end
    Apply(name)
end

local function RegisterAll()
    for _, name in ipairs(order) do Register(name) end
end

--------------------------------------------------
-- MODO MOVER
--------------------------------------------------
local function PlaceMover(name)
    local mover, frame = movers[name], _G[name]
    if not (mover and frame) then return end
    local ratio = frame:GetEffectiveScale() / mover:GetEffectiveScale()
    local width, height = frame:GetSize()
    local cx, cy = frame:GetCenter()
    mover:ClearAllPoints()
    if cx then
        mover:SetPoint("CENTER", UIParent, "BOTTOMLEFT", cx * ratio, cy * ratio)
    else
        mover:SetPoint("CENTER")
    end
    mover:SetSize(math.max((width or 0) * ratio, 40), math.max((height or 0) * ratio, 20))
end

local function GetMover(name)
    if movers[name] then return movers[name] end
    local mover = CreateFrame("Button", nil, UIParent)
    mover:SetFrameStrata("DIALOG")
    mover:SetMovable(true)
    mover:SetClampedToScreen(true)
    mover:RegisterForDrag("LeftButton")
    mover:RegisterForClicks("RightButtonUp")
    mover:EnableMouseWheel(true)
    mover.bg = mover:CreateTexture(nil, "BACKGROUND")
    mover.bg:SetAllPoints()
    mover.bg:SetColorTexture(0.84, 0.59, 1, 0.35)
    mover.label = mover:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    mover.label:SetPoint("CENTER")
    mover.label:SetText(Pretty(name))
    mover:SetScript("OnDragStart", function(self)
        local frame = _G[name]
        if frame and not Blocked(frame) then self:StartMoving() end
    end)
    mover:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        local frame = _G[name]
        if not frame then return end
        local cx, cy = self:GetCenter()
        local ratio = self:GetEffectiveScale() / UIParent:GetEffectiveScale()
        local entry = Entry(name)
        entry.x, entry.y = cx * ratio, cy * ratio
        Apply(name)
        PlaceMover(name)
    end)
    mover:SetScript("OnMouseWheel", function(_, delta)
        local frame = _G[name]
        if not frame or Blocked(frame) then return end
        local entry = Entry(name)
        local scale = (entry.scale or frame:GetScale()) + delta * SCALE_STEP
        entry.scale = math.min(MAX_SCALE, math.max(MIN_SCALE, scale))
        if not entry.x then SaveFromFrame(name, frame) end
        Apply(name)
        PlaceMover(name)
    end)
    mover:SetScript("OnClick", function(_, button)
        if button == "RightButton" then
            Reset(name)
            PlaceMover(name)
        end
    end)
    mover:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText(Pretty(name))
        GameTooltip:AddLine(L.MOVER_HINT, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    mover:SetScript("OnLeave", function() GameTooltip:Hide() end)
    movers[name] = mover
    return mover
end

-- Recuadros para todo lo activado que exista. Las ventanas solo si estan
-- abiertas (si no, habria decenas encima unas de otras).
local function RefreshMovers()
    for _, mover in pairs(movers) do mover:Hide() end
    if not unlocked then return end
    for _, name in ipairs(order) do
        local frame = _G[name]
        if hooked[name] and IsEnabled(name) and frame and (not elements[name].window or frame:IsVisible()) then
            GetMover(name):Show()
            PlaceMover(name)
        end
    end
end

local function SetUnlocked(value)
    unlocked = value
    RegisterAll()
    RefreshMovers()
    print(PREFIX .. (unlocked and L.UNLOCKED or L.LOCKED))
end

local function ResetAll()
    for _, name in ipairs(order) do Reset(name) end
    RefreshMovers()
    print(PREFIX .. L.RESET_DONE)
end

--------------------------------------------------
-- OPCIONES
--------------------------------------------------
local function OnToggle(name)
    if IsEnabled(name) then
        Register(name)
        Apply(name)
    else
        -- Desactivado: vuelve a donde lo tenia Blizzard (lo guardado se queda,
        -- por si se reactiva)
        local frame, original = _G[name], originals[name]
        if frame and original and not Blocked(frame) then
            applying[name] = true
            frame:SetScale(original.scale)
            frame:ClearAllPoints()
            for _, point in ipairs(original) do frame:SetPoint(unpack(point)) end
            applying[name] = nil
        end
    end
    RefreshMovers()
end

local function CreateOptions()
    local category, layout = Settings.RegisterVerticalLayoutCategory(BRAND .. "AnyMove Forever|r")

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L.GENERAL_HEADER))
    layout:AddInitializer(CreateSettingsButtonInitializer(L.MOVE_MODE, L.MOVE_MODE_BUTTON,
        function() SetUnlocked(not unlocked) end, L.MOVE_MODE_TOOLTIP, true))
    layout:AddInitializer(CreateSettingsButtonInitializer(L.RESET_ALL, L.RESET_ALL_BUTTON,
        ResetAll, L.RESET_ALL_TOOLTIP, true))

    for _, cat in ipairs(ns.CATEGORIES) do
        layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["CATEGORY_" .. cat.key],
            L["CATEGORY_" .. cat.key .. "_TOOLTIP"]))
        for _, name in ipairs(cat.list) do
            local entry = Entry(name)
            if entry.enabled == nil then entry.enabled = cat.default end
            local setting = Settings.RegisterAddOnSetting(category, "AnyMoveForever_" .. name, "enabled",
                entry, Settings.VarType.Boolean, Pretty(name), cat.default)
            setting:SetValueChangedCallback(function() OnToggle(name) end)
            Settings.CreateCheckbox(category, setting, name)
        end
    end

    Settings.RegisterAddOnCategory(category)

    SLASH_ANYMOVEFOREVER1 = "/amf"
    SLASH_ANYMOVEFOREVER2 = "/anymove"
    SlashCmdList.ANYMOVEFOREVER = function(msg)
        local command = (msg or ""):lower():match("^%s*(%S*)")
        if command == "move" or command == "unlock" or command == "lock" then
            SetUnlocked(command == "unlock" or (command == "move" and not unlocked))
        elseif command == "reset" then
            ResetAll()
        else
            Settings.OpenToCategory(category:GetID())
        end
    end
end

--------------------------------------------------
-- ARRANQUE
--------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:SetScript("OnEvent", function(_, event)
    if event == "PLAYER_LOGIN" then
        AnyMoveForeverDB = AnyMoveForeverDB or {}
        db = AnyMoveForeverDB
        db.elements = db.elements or {}
        CreateOptions()
        RegisterAll()
    elseif not db then
        return
    elseif event == "ADDON_LOADED" then
        -- Ventanas de carga bajo demanda (subasta, logros, profesiones...)
        RegisterAll()
    elseif event == "PLAYER_REGEN_ENABLED" then
        for name in pairs(pending) do
            pending[name] = nil
            Apply(name)
        end
    end
end)
