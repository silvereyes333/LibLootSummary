local lls = LibLootSummary
lls.List = ZO_Object:Subclass()

local addQuantity, appendText, sortByCurrencyName, sortByItemName
local linkFormat = "|H%s:item:%s:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"

function lls.List:New(...)
    local instance = ZO_Object.New(self)
    instance:Initialize()
    return instance
end

function lls.List:Initialize()  
    self.itemList = {}
    self.itemKeys = {}
    self.currencyList = {}
    self.currencyKeys = {}
    
    -- Reset options
    self.prefix = ""
    self.suffix = ""
    self.delimiter = " "
    self.linkStyle = LINK_STYLE_DEFAULT
    self.combineDuplicates = true
    self.sorted = false
end

function lls.List:AddCurrency(currencyType, quantity)
    addQuantity(self.currencyList, self.currencyKeys, currencyType, quantity, self.combineDuplicates)
end
function lls.List:AddItem(bagId, slotIndex, quantity)
    local itemLink = GetItemLink(bagId, slotIndex, self.linkStyle)
    if not quantity then
        local stackSize, maxStackSize = GetSlotStackSize(bagId, slotIndex)
        quantity = math.min(stackSize, maxStackSize)
    end
    self:AddItemLink(itemLink, quantity, true)
end
function lls.List:AddItemId(itemId, quantity)
    local itemLink = string.format(linkFormat, self.linkStyle, itemId)
    self:AddItemLink(itemLink, quantity, true)
end
function lls.List:AddItemLink(itemLink, quantity, dontChangeStyle)

    if not dontChangeStyle then
        itemLink = string.gsub(itemLink, "|H[0-1]:", "|H"..tostring(self.linkStyle)..":")
    end
    
    addQuantity(self.itemList, self.itemKeys, itemLink, quantity, self.combineDuplicates)
end

--[[ Outputs a verbose summary of all loot and currency ]]
function lls.List:Print()

    local lines = {}
    local summary = ""
    local maxLength = MAX_TEXT_CHAT_INPUT_CHARACTERS - string.len(self.prefix) - string.len(self.suffix)
    
    -- Add items summary
    if self.sorted then
        table.sort(self.itemKeys, sortByItemName)
    end
    for _, itemLink in ipairs(self.itemKeys) do
        local quantities = self.itemList[itemLink]
        for _, quantity in ipairs(quantities) do
            local countString = zo_strformat(GetString(SI_HOOK_POINT_STORE_REPAIR_KIT_COUNT), quantity)
            local itemString = zo_strformat("<<1>> <<2>>", itemLink, countString)
            summary = appendText(itemString, summary, maxLength, lines, self.delimiter, self.prefix)
        end
    end
    
    -- Add money summary
    if self.sorted then
        table.sort(self.currencyKeys, sortByCurrencyName)
    end
    for _, currencyType in ipairs(self.currencyKeys) do
        local quantities = self.currencyList[currencyType]
        for _, quantity in ipairs(quantities) do
            local moneyString = zo_strformat("<<1>>", 
                                            ZO_CurrencyControl_FormatCurrencyAndAppendIcon(
                                                quantity, true, currencyType, IsInGamepadPreferredMode()))
            summary = appendText(moneyString, summary, maxLength, lines, self.delimiter, self.prefix)
        end
    end
    
    -- Append last line
    if string.len(summary) > string.len(self.prefix) then
        table.insert(lines, summary)
    end
    
    -- Print to chat
    for _, line in ipairs(lines) do
        d(self.prefix .. line .. self.suffix)
    end
    
    self:Reset()
end

function lls.List:Reset()
    self:Initialize()
end

function lls.List:SetCombineDuplicates(combineDuplicates)
    self.combineDuplicates = combineDuplicates
end

function lls.List:SetDelimiter(delimiter)
    self.delimiter = delimiter
end

function lls.List:SetLinkStyle(linkStyle)
    self.linkStyle = linkStyle
end

function lls.List:SetPrefix(prefix)
    self.prefix = prefix
end

function lls.List:SetSorted(sorted)
    self.sorted = sorted
end

function lls.List:SetSuffix(suffix)
    self.suffix = suffix
end

-- Local functions

function addQuantity(list, keys, key, quantity, combineDuplicates)
    if list[key] then
        if combineDuplicates then
            list[key][1] = list[key][1] + quantity
        else
            table.insert(list[key], quantity)
        end
    else
        list[key] = { [1] = quantity }
        table.insert(keys, key)
    end
end

function appendText(text, currentText, maxLength, lines, delimiter, prefix)
    local newLine
    if string.len(currentText) + string.len(delimiter) + string.len(text) > maxLength then
        table.insert(lines, currentText)
        currentText = ""
    elseif string.len(currentText) > string.len(prefix) then
        currentText = currentText .. delimiter
    end
    currentText = currentText .. text
    return currentText
end

function sortByCurrencyName(currencyType1, currencyType2)
    return zo_strformat(GetCurrencyName(currencyType1)) < zo_strformat(GetCurrencyName(currencyType2))
end

function sortByItemName(itemLink1, itemLink2)
    return zo_strformat(GetItemLinkName(itemLink1)) < zo_strformat(GetItemLinkName(itemLink2))
end