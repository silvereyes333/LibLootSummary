for stringId, value in pairs(LLS_STRINGS) do
    ZO_CreateStringId(stringId, value)
end
LLS_STRINGS = ZO_ClearTable(LLS_STRINGS) -- to allow collect garbage