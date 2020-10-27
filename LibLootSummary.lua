-- LibLootSummary & its files copyright silvereyes                          --
-- Distributed under the MIT license (see LICENSE.txt)          --
------------------------------------------------------------------

local ADDON_NAME = "LibLootSummary"

local lls = {}
LibLootSummary = lls

-- [[ Get AddOn version from manifest file ]]--
local function GetAddOnVersion()
	local addOnManager = GetAddOnManager()
	local numAddOns = addOnManager:GetNumAddOns()
	local name, author
	for i = 1, numAddOns do
		name, _, author = addOnManager:GetAddOnInfo(i)
		if name == ADDON_NAME then
			return addOnManager:GetAddOnVersion(i)
		end
	end
end
lls.version = GetAddOnVersion()

--[[ Shortcut to creating a new LibLootSummary.List instance ]]--
function lls:New(...)
    return lls.List:New(...)
end
setmetatable(lls, { __call = function(_, ...) return lls.List:New(...) end })