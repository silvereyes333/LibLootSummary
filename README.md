# LibLootSummary
An Elder Scrolls Online addon library to assist with printing lists of items to the chat window.

## About this library

This library is intended to simplify outputting summaries of loot to ESO chat

## What it looks like

*Minimal output with quality minimum*

![](https://i.imgur.com/yXTQWDo.png)

*With icons and traits, but no quality minimum*

![](https://i.imgur.com/2T74WDi.png)

> **Important!**
> When icons are enabled, many fewer items will fit on a single line (2-3 vs. 6-7). 
> This is because chat has a maximum number of characters per line, and icons are represented by file paths behind the scenes, which use up quite a few characters towards the per-line limit.

## To use in your addon
Simply add `## DependsOn: LibLootSummary` to your addon's manifest text file.

## Usage Example

```
local lls = LibLootSummary:New()

-- If set to false, then successive calls to the Add*() methods for the same item id will
-- be listed separately in the summary.  The default (true) causes the quantities to be
-- summed and listed once in the summary.
lls:SetCombineDuplicates(false)

-- Use comma delimiters between items in the summary, instead of the default single space
lls:SetDelimiter(", ")

-- Use bracket style links
lls:SetLinkStyle(LINK_STYLE_BRACKETS)

-- Filter summary to only purple or gold items
lls:SetMinQuality(ITEM_QUALITY_ARCANE)

-- Display item icons to the left of item names in summary
lls:SetShowIcon(true)

-- Display item trait to the right of item names in summary
lls:SetShowTrait(true)

-- Prefix to get prepended to every line of the summary
local prefix = "MyAddon: "
prefix = "|cFFFFFF" .. prefix -- set line color to white
lls:SetPrefix(prefix)

-- Sort summary alphabetically
lls:SetSorted(true)

-- Suffix to get appended to the end of every line of the summary
lls:SetSuffix("|r") -- reset color to default

-- Reset all settings to defaults and remove all items from the pending summary.
-- LibLootSummary:Print() calls this by default.
lls:Reset()

-- Add item from bag
-- If quantity is nil, then the max stack size possible will be used
lls:AddItem(bagId, slotIndex, quantity)

-- Add 200x Ancestor Silk
lls:AddItemLink("|H1:item:64504:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h", 200)

-- Add 1x Aetherial Dust
lls:AddItemId(115026, 1)

-- Output the entire summary to chat
lls:Print()
```