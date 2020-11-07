local lls = LibLootSummary

local List = ZO_Object:Subclass()
lls.List = List

local addQuantity, appendText, coalesce, defaultChat, mergeTables, sortByCurrencyName, sortByItemName, sortByQuality, qualityChoices, qualityChoicesValues
local generateLam2EnabledOption, generateLam2QualityOption, generateLam2IconsOption, generateLam2IconSizeOption, generateLam2TraitsOption, generateLam2HideSingularOption
local GetItemLinkFunctionalQuality, ZO_CachedStrFormat, GetCurrencyName = GetItemLinkFunctionalQuality, ZO_CachedStrFormat, GetCurrencyName
local zo_strgsub, zo_strlen, zo_min = zo_strgsub, zo_strlen, zo_min
local tostring, pairs, ipairs = tostring, pairs, ipairs
local tableInsert, stringFormat, tableSort = table.insert, string.format, table.sort
local linkFormat = "|H%s:item:%s:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
local DEFAULTS

function List:New(options)
    local instance = ZO_Object.New(self)
    instance:Initialize(options)
    return instance
end

function List:Initialize(options)
    self.itemList = {}
    self.itemKeys = {}
    self.currencyList = {}
    self.currencyKeys = {}

    setmetatable(self.itemList, { __mode = "v" })
    setmetatable(self.currencyList, { __mode = "v" })

    self:SetOptions(options or {}, DEFAULTS)
end

function List:AddCurrency(currencyType, quantity)
    if not self:IsEnabled() then
        return
    end

    addQuantity(self.currencyList, self.currencyKeys, currencyType, quantity, self.combineDuplicates)
end
function List:AddItem(bagId, slotIndex, quantity)
    if not self:IsEnabled() then
        return
    end

    if not quantity then
        local stackSize, maxStackSize = GetSlotStackSize(bagId, slotIndex)
        quantity = zo_min(stackSize, maxStackSize)
    end

    self:AddItemLink(GetItemLink(bagId, slotIndex, self.linkStyle), quantity, true)
end
function List:AddItemId(itemId, quantity)
    if not self:IsEnabled() then
        return
    end

    self:AddItemLink(stringFormat(linkFormat, self.linkStyle, itemId), quantity, true)
end
function List:AddItemLink(itemLink, quantity, dontChangeStyle)
    if not self:IsEnabled() then
        return
    end

    if not dontChangeStyle then
        itemLink = zo_strgsub(itemLink, "|H[0-1]:", "|H"..tostring(self.linkStyle)..":")
    end

    addQuantity(self.itemList, self.itemKeys, itemLink, quantity, self.combineDuplicates)
end

function List:GenerateLam2ItemOptions(addonName, savedVarChildTable, defaults)
    defaults = mergeTables(defaults, DEFAULTS)
    return generateLam2EnabledOption(self, addonName, savedVarChildTable, defaults, SI_LLS_ITEM_SUMMARY, SI_LLS_ITEM_SUMMARY_TOOLTIP),
        generateLam2QualityOption(self, savedVarChildTable, defaults, SI_LLS_MIN_ITEM_QUALITY, SI_LLS_MIN_ITEM_QUALITY_TOOLTIP),
        generateLam2IconsOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_ITEM_ICONS, SI_LLS_SHOW_ITEM_ICONS_TOOLTIP),
        generateLam2IconSizeOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_ITEM_ICON_SIZE, SI_LLS_SHOW_ITEM_ICON_SIZE_TOOLTIP),
        generateLam2TraitsOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_ITEM_TRAITS, SI_LLS_SHOW_ITEM_TRAITS_TOOLTIP),
        generateLam2HideSingularOption(self, savedVarChildTable, defaults, SI_LLS_HIDE_ITEM_SINGLE_QTY, SI_LLS_HIDE_ITEM_SINGLE_QTY_TOOLTIP)
end

function List:GenerateLam2LootOptions(addonName, savedVarChildTable, defaults)
    defaults = mergeTables(defaults, DEFAULTS)
    return generateLam2EnabledOption(self, addonName, savedVarChildTable, defaults, SI_LLS_LOOT_SUMMARY, SI_LLS_LOOT_SUMMARY_TOOLTIP),
        generateLam2QualityOption(self, savedVarChildTable, defaults, SI_LLS_MIN_LOOT_QUALITY, SI_LLS_MIN_LOOT_QUALITY_TOOLTIP),
        generateLam2IconsOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_LOOT_ICONS, SI_LLS_SHOW_LOOT_ICONS_TOOLTIP),
        generateLam2IconSizeOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_LOOT_ICON_SIZE, SI_LLS_SHOW_LOOT_ICON_SIZE_TOOLTIP),
        generateLam2TraitsOption(self, savedVarChildTable, defaults, SI_LLS_SHOW_LOOT_TRAITS, SI_LLS_SHOW_LOOT_TRAITS_TOOLTIP),
        generateLam2HideSingularOption(self, savedVarChildTable, defaults, SI_LLS_HIDE_LOOT_SINGLE_QTY, SI_LLS_HIDE_LOOT_SINGLE_QTY_TOOLTIP)
end

--[[ Outputs a verbose summary of all loot and currency ]]
function List:Print()

    if not self:IsEnabled() then
        return
    end

    local lines = {}
    local summary = ""
    local maxLength = (self.chat.maxCharsPerLine or 1200) - ZoUTF8StringLength(self.prefix) - ZoUTF8StringLength(self.suffix)

    -- Add items summary
    if self.sortedByQuality then
        tableSort(self.itemKeys, sortByQuality)
    elseif self.sorted then
        tableSort(self.itemKeys, sortByItemName)
    end

    local quality, quantities, countString, iconStringLength
    for _, itemLink in ipairs(self.itemKeys) do
        quality = GetItemLinkFunctionalQuality(itemLink)
        if quality >= self.minQuality then
            quantities = self.itemList[itemLink]
            for _, quantity in ipairs(quantities) do
                local itemString = itemLink
                if self.showTrait and GetItemLinkEquipType(itemLink) ~= EQUIP_TYPE_INVALID then
                    local traitType = GetItemLinkTraitInfo(itemLink)
                    if traitType and traitType > 0 then
                        itemString = stringFormat("%s (%s)", itemString, GetString("SI_ITEMTRAITTYPE", traitType))
                    end
                end
                if not self.hideSingularQuantities or quantity > 1 then
                    local countString = ZO_CachedStrFormat(GetString(SI_HOOK_POINT_STORE_REPAIR_KIT_COUNT), quantity)
                    itemString = stringFormat("%s %s", itemString, countString)
                end
                iconStringLength = 0
                if self.showIcon then
                    local iconSize = stringFormat("%s%%", tostring(self.iconSize))
                    local iconString = zo_iconFormat(GetItemLinkIcon(itemLink), iconSize, iconSize)
                    if not self.chat.isDefault then
                        iconStringLength = zo_strlen(iconString)
                    end
                    itemString = iconString .. itemString
                end
                summary = appendText(itemString, summary, maxLength, lines, self.delimiter, self.prefix, iconStringLength)
            end
        end
    end

    -- Add money summary
    if self.sorted then
        tableSort(self.currencyKeys, sortByCurrencyName)
    end

    for _, currencyType in ipairs(self.currencyKeys) do
        quantities = self.currencyList[currencyType]
        for _, quantity in ipairs(quantities) do
            local moneyString = GetCurrencyName(currencyType, IsCountSingularForm(quantity))
            countString = quantity > 0 and ZO_CachedStrFormat(GetString(SI_HOOK_POINT_STORE_REPAIR_KIT_COUNT), quantity) or tostring(quantity)
            moneyString = stringFormat("%s %s", moneyString, countString)
            iconStringLength = 0
            if self.showIcon then
                local currencyIcon = ZO_Currency_GetPlatformFormattedCurrencyIcon(currencyType)
                if not self.chat.isDefault then
                    iconStringLength = zo_strlen(currencyIcon)
                end
                moneyString = currencyIcon .. moneyString
            end
            summary = appendText(moneyString, summary, maxLength, lines, self.delimiter, self.prefix, iconStringLength)
        end
    end

    -- Append last line
    if ZoUTF8StringLength(summary) > ZoUTF8StringLength(self.prefix) then
        tableInsert(lines, summary)
    end

    -- Print to chat
    for i, line in ipairs(lines) do
        self.chat:Print(self.prefix .. line .. self.suffix)
        lines[i] = nil -- to allow collect garbage
    end

    self:Reset()
end

function List:Reset()
    self.itemList = {}
    self.itemKeys = {}
    self.currencyList = {}
    self.currencyKeys = {}
end

function List:SetCombineDuplicates(combineDuplicates)
    self.combineDuplicates = combineDuplicates
end

function List:SetDelimiter(delimiter)
    self.delimiter = delimiter
end

function List:SetEnabled(enabled)
    self.enabled = enabled
end

function List:IsEnabled()
    return self.enabled
end

function List:SetHideSingularQuantities(hideSingularQuantities)
    self.hideSingularQuantities = hideSingularQuantities
end

function List:SetLinkStyle(linkStyle)
    self.linkStyle = linkStyle
end

function List:SetMinQuality(quality)
    self.minQuality = quality
end

function List:SetOptions(options, defaults)
    for field, default in pairs(defaults) do
        self[field] = coalesce(options[field], defaults[field])
    end
    if not defaults.chat then
        return
    end
    if options.chat and type(options.chat.Print) == "function" then
        self.chat = options.chat
    else
        self.chat = defaults.chat
    end
end

function List:SetPrefix(prefix)
    self.prefix = prefix
end

function List:SetShowIcon(showIcon)
    self.showIcon = showIcon
end

function List:SetIconSize(size)
    self.iconSize = size
end

function List:SetShowTrait(showTrait)
    self.showTrait = showTrait
end

function List:SetSorted(sorted)
    self.sorted = sorted
end

function List:SetSortedByQuality(sortedByQuality)
    self.sortedByQuality = sortedByQuality
end

function List:SetSuffix(suffix)
    self.suffix = suffix
end

function List:UseLibChatMessage(chat)
    self.chat = chat
end


-- Local functions

function addQuantity(list, keys, key, quantity, combineDuplicates)
    if list[key] then
        if combineDuplicates then
            list[key][1] = list[key][1] + quantity
        else
            tableInsert(list[key], quantity)
        end
    else
        list[key] = { [1] = quantity }
        tableInsert(keys, key)
    end
end

function appendText(text, currentText, maxLength, lines, delimiter, prefix, iconStringLength)
    local currentTextLength = ZoUTF8StringLength(currentText)
    local stringLength = currentTextLength + ZoUTF8StringLength(delimiter) + ZoUTF8StringLength(text)
    -- icons only take up the space of two characters
    if iconStringLength > 0 then
        stringLength = stringLength - iconStringLength + 2 
    end
    if stringLength > maxLength then
        tableInsert(lines, currentText)
        currentText = ""
    elseif currentTextLength > ZoUTF8StringLength(prefix) then
        currentText = currentText .. delimiter
    end
    currentText = currentText .. text
    return currentText
end

function coalesce(...)
    local args = {...}
    for key = 1, #args do
        local value = args[key]
        if value ~= nil then
            return value, key
        end
    end
end

defaultChat = ZO_Object:Subclass()
function defaultChat:New(...)
    local instance = ZO_Object.New(self)
    instance.isDefault = true
    instance.maxCharsPerLine = MAX_TEXT_CHAT_INPUT_CHARACTERS
    return instance
end
function defaultChat:Print(message)
    if CHAT_ROUTER then
        CHAT_ROUTER:AddDebugMessage(message)
    end
end

DEFAULTS = {
    chat = defaultChat:New(),
    combineDuplicates = true,
    delimiter = " ",
    hideSingularQuantities = false,
    enabled = true,
    linkStyle = LINK_STYLE_DEFAULT,
    minQuality = ITEM_FUNCTIONAL_QUALITY_MIN_VALUE,
    prefix = "",
    showIcon = false,
    iconSize = 90,
    showTrait = false,
    sorted = false,
    sortedByQuality = false,
    suffix = "",
}

local function getIcons(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.icons, savedVarChildTable and savedVarChildTable.showIcon, defaults.icons, defaults.showIcon)
end

local function getIconSize(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.iconSize, defaults.iconSize)
end

local function getHideSingularQuantities(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.hideSingularQuantities, defaults.hideSingularQuantities)
end

local function getIsEnabled(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.enabled, defaults.enabled)
end

local function getMinQuality(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.minQuality, defaults.minQuality)
end

local function getTraits(self, savedVarChildTable, defaults)
    return coalesce(savedVarChildTable and savedVarChildTable.traits, savedVarChildTable and savedVarChildTable.showTrait, defaults.traits, defaults.showTrait)
end

function generateLam2EnabledOption(self, addonName, savedVarChildTable, defaults, name, tooltip)
    return 
        -- Enabled
        {
            type = "checkbox",
            name = GetString(name),
            tooltip = zo_strformat(tooltip, addonName),
            getFunc = function()
                return getIsEnabled(self, savedVarChildTable, defaults)
            end,
            setFunc = 
                function(value)
                    savedVarChildTable.enabled = value
                    self:SetEnabled(value)
                end,
            default = defaults.enabled,
        }
end
function generateLam2HideSingularOption(self, savedVarChildTable, defaults, name, tooltip)
    return 
        -- HideSingularQuantities
        {
            type = "checkbox",
            name = GetString(name),
            tooltip = GetString(tooltip),
            getFunc =
                function()
                    return getHideSingularQuantities(self, savedVarChildTable, defaults)
                end,
            setFunc = 
                function(value)
                    savedVarChildTable.hideSingularQuantities = value
                    self:SetHideSingularQuantities(value)
                end,
            default = defaults.hideSingularQuantities,
            disabled =
                function()
                    return not getIsEnabled(self, savedVarChildTable, defaults)
                end,
        }
end
function generateLam2IconsOption(self, savedVarChildTable, defaults, name, tooltip)
    return 
        -- Show Icons
        {
            type = "checkbox",
            name = GetString(name),
            tooltip = GetString(tooltip),
            getFunc = 
                function()
                    return getIcons(self, savedVarChildTable, defaults)
                end,
            setFunc = 
                function(value)
                    savedVarChildTable[defaults.icons ~= nil and "icons" or "showIcon"] = value
                    self:SetShowIcon(value)
                end,
            default = coalesce(defaults.icons, defaults.showIcon),
            disabled =
                function()
                    return not getIsEnabled(self, savedVarChildTable, defaults)
                end,
        }
end
function generateLam2IconSizeOption(self, savedVarChildTable, defaults, name, tooltip)
    return 
        -- Set icons size
        {
            type = "slider",
            min = 50,
            max = 200,
            step = 10,
            decimals = 0,
            clampInput = true,
            name = GetString(name),
            tooltip = GetString(tooltip),
            getFunc = 
                function()
                    return getIconSize(self, savedVarChildTable, defaults)
                end,
            setFunc = 
                function(value)
                    savedVarChildTable.iconSize = value
                    self:SetIconSize(value)
                end,
            default = defaults.iconSize,
            disabled = 
                function()
                    return not getIsEnabled(self, savedVarChildTable, defaults) or not getIcons(self, savedVarChildTable, defaults)
                end,
        }
end
function generateLam2QualityOption(self, savedVarChildTable, defaults, name, tooltip)
    return 
        -- Minimum Quality
        {
            type = "dropdown",
            choices = qualityChoices,
            choicesValues = qualityChoicesValues,
            sort = "numericvalue-up",
            name = GetString(name),
            tooltip = GetString(tooltip),
            getFunc =
                function()
                    return getMinQuality(self, savedVarChildTable, defaults)
                end,
            setFunc = 
                function(value)
                    savedVarChildTable.minQuality = value
                    self:SetMinQuality(value)
                end,
            default = defaults.minQuality,
            disabled =
                function()
                    return not getIsEnabled(self, savedVarChildTable, defaults)
                end,
        }
end
function generateLam2TraitsOption(self, savedVarChildTable, defaults, name, tooltip)
    return 
        -- Show Traits
        {
            type = "checkbox",
            name = GetString(name),
            tooltip = GetString(tooltip),
            getFunc =
                function()
                    return getTraits(self, savedVarChildTable, defaults)
                end,
            setFunc = 
                function(value)
                    
                    savedVarChildTable[defaults.traits ~= nil and "traits" or "showTrait"] = value
                    self:SetShowTrait(value)
                end,
            default = coalesce(defaults.traits, defaults.showTrait),
            disabled =
                function()
                    return not getIsEnabled(self, savedVarChildTable, defaults)
                end,
        }
end

function mergeTables(table1, table2)
    local merged = ZO_ShallowTableCopy(table1)
    for key, value in pairs(table2) do
        if merged[key] == nil then
            merged[key] = value
        end
    end
    return merged
end

function sortByCurrencyName(currencyType1, currencyType2)
    return GetCurrencyName(currencyType1) < GetCurrencyName(currencyType2)
end

function sortByItemName(itemLink1, itemLink2)
    return ZO_CachedStrFormat(SI_LINK_FORMAT_ITEM_NAME, GetItemLinkName(itemLink1)) < ZO_CachedStrFormat(SI_LINK_FORMAT_ITEM_NAME, GetItemLinkName(itemLink2))
end

function sortByQuality(itemLink1, itemLink2)
    local quality1 = GetItemLinkFunctionalQuality(itemLink1)
    local quality2 = GetItemLinkFunctionalQuality(itemLink2)
    if quality1 == quality2 then
        return sortByItemName(itemLink1, itemLink2)
    else
        return quality2 < quality1
    end
end

qualityChoices = {}
qualityChoicesValues = {}
for quality = ITEM_FUNCTIONAL_QUALITY_MIN_VALUE, ITEM_FUNCTIONAL_QUALITY_MAX_VALUE do
    local qualityColor = GetItemQualityColor(quality)
    local qualityString = qualityColor:Colorize(GetString("SI_ITEMQUALITY", quality))
    tableInsert(qualityChoicesValues, quality)
    tableInsert(qualityChoices, qualityString)
end