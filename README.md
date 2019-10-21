# LibLootSummary
An Elder Scrolls Online addon library to assist with printing lists of items to the chat window.

## About this library

This library is intended to simplify outputing summaries of loot to ESO chat

## What it looks like

![](https://i.imgur.com/W5odKXw.png)

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

-- Prefix to get prepended to every line of the summary
local prefix = "MyAddon: "
prefix = "|cFFFFFF" .. prefix -- set line color to white
lls:SetPrefix("prefix)

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