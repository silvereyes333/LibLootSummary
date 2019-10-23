-- LibLootSummary & its files copyright silvereyes                          --
-- Distributed under the MIT license (see LICENSE.txt)          --
------------------------------------------------------------------

LibLootSummary = { version = "1.1.1" }
local lls = LibLootSummary
local lists = {}
local globalList, getListByScope

function lls:AddCurrency(currencyType, quantity, scope)
    getListByScope(scope):AddCurrency(currencyType, quantity)
end

function lls:AddItem(bagId, slotIndex, quantity, scope)
    getListByScope(scope):AddItem(bagId, slotIndex, quantity)
end

function lls:AddItemId(itemId, quantity, scope)
    getListByScope(scope):AddItemId(itemId, quantity)
end

function lls:AddItemLink(itemLink, quantity, dontChangeStyle, scope)
    getListByScope(scope):AddItemLink(itemLink, quantity, dontChangeStyle)
end

--[[ Shortcut to creating a new LibLootSumary.List instance ]]--
function lls:New()
    return lls.List:New()
end

--[[ Outputs a verbose summary of all loot and currency ]]
function lls:Print(scope)
    getListByScope(scope):Print()
end

function lls:Reset(scope)
    getListByScope(scope):Reset()
end

function lls:SetCombineDuplicates(newCombineDuplicates, scope)
    getListByScope(scope):SetCombineDuplicates(newCombineDuplicates)
end

function lls:SetDelimiter(newDelimiter, scope)
    getListByScope(scope):SetDelimiter(newDelimiter)
end

function lls:SetLinkStyle(newLinkStyle, scope)
    getListByScope(scope):SetLinkStyle(newLinkStyle)
end

function lls:SetMinQuality(quality, scope)
    getListByScope(scope):SetMinQuality(quality)
end

function lls:SetPrefix(newPrefix, scope)
    getListByScope(scope):SetPrefix(newPrefix)
end

function lls:SetShowIcon(showIcon, scope)
    getListByScope(scope):SetShowIcon(showIcon)
end

function lls.SetShowTrait(showTrait, scope)
    getListByScope(scope):SetShowTrait(showTrait)
end

function lls:SetSuffix(newSuffix, scope)
    getListByScope(scope):SetSuffix(newSuffix)
end

function getListByScope(scope)
    if scope == nil then
        if not globalList then
            globalList = lls.List:New()
        end
        return globalList
    end
    local list = lists[scope]
    if not list then
        lists[scope] = lls.List:New()
    end
    return lists[scope]
end