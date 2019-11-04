local strings = {
    ["SI_LLS_ITEM_SUMMARY"]                    = "Резюме предметы",
    ["SI_LLS_ITEM_SUMMARY_TOOLTIP"]            = "<<1>> напечатает резюме предметы, когда закончите.",
    ["SI_LLS_LOOT_SUMMARY"]                    = "Резюме истории добыча",
    ["SI_LLS_LOOT_SUMMARY_TOOLTIP"]            = "<<1>> напечатает резюме добыча, когда закончите.",
    ["SI_LLS_MIN_ITEM_QUALITY"]                = "Минимальное качество товара",
    ["SI_LLS_MIN_ITEM_QUALITY_TOOLTIP"]        = "Предметы с качеством ниже этого значения не включаются в резюме предметов.",
    ["SI_LLS_MIN_LOOT_QUALITY"]                = "Минимальное качество добычи",
    ["SI_LLS_MIN_LOOT_QUALITY_TOOLTIP"]        = "Добыча с качеством ниже этого значения не включаются в резюме истории добыча.",
    ["SI_LLS_SHOW_ITEM_ICONS"]                 = "Показать значки предметы",
    ["SI_LLS_SHOW_ITEM_ICONS_TOOLTIP"]         = "Показать значки слева от имен предметы, которые появляются в резюме.",
    ["SI_LLS_SHOW_LOOT_ICONS"]                 = "Показать значки предметов добычи",
    ["SI_LLS_SHOW_LOOT_ICONS_TOOLTIP"]         = "Показать значки слева от имен добычи, которые появляются в резюме.",
    ["SI_LLS_SHOW_ITEM_TRAITS"]                = "Показать предметы особенности",
    ["SI_LLS_SHOW_ITEM_TRAITS_TOOLTIP"]        = "Показать имена особенности в скобках справа от имен предметы в резюме.",
    ["SI_LLS_SHOW_LOOT_TRAITS"]                = "Показать добычи особенности",
    ["SI_LLS_SHOW_LOOT_TRAITS_TOOLTIP"]        = "Показать имена особенности в скобках справа от имен добычи в резюме.",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY"]            = "Не показывать количество для одного предмет",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY_TOOLTIP"]    = "Числовые метки количества будут напечатаны только справа от названий предметы с количеством больше единицы.",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY"]            = "Не показывать количество для одного предмет",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY_TOOLTIP"]    = "Числовые метки количества будут напечатаны только справа от названий добыча с количеством больше единицы.",
}

for stringId, value in pairs(strings) do
    LLS_STRINGS[stringId] = value
end