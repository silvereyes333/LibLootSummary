local strings = {
    ["SI_LLS_ITEM_SUMMARY"]                    = "Отчет предметы",
    ["SI_LLS_ITEM_SUMMARY_TOOLTIP"]            = "<<1>> напечатает отчет предметы, когда закончите.",
    ["SI_LLS_LOOT_SUMMARY"]                    = "Отчет истории добыча",
    ["SI_LLS_LOOT_SUMMARY_TOOLTIP"]            = "<<1>> напечатает отчет добыча, когда закончите.",
    ["SI_LLS_MIN_ITEM_QUALITY"]                = "Минимальное качество товара",
    ["SI_LLS_MIN_ITEM_QUALITY_TOOLTIP"]        = "Предметы с качеством ниже этого значения не включаются в отчет предметов.",
    ["SI_LLS_MIN_LOOT_QUALITY"]                = "Минимальное качество добычи",
    ["SI_LLS_MIN_LOOT_QUALITY_TOOLTIP"]        = "Добыча с качеством ниже этого значения не включаются в отчет истории добыча.",
    ["SI_LLS_SHOW_ITEM_ICONS"]                 = "Показывать значки товара",
    ["SI_LLS_SHOW_ITEM_ICONS_TOOLTIP"]         = "Показывать значки слева от имен товара, которые появляются в отчет.",
    ["SI_LLS_ICON_SIZE"]                       = "Размер значка",
    ["SI_LLS_ICON_SIZE_TOOLTIP"]               = "Используйте процент, чтобы установить размер значков.",
    ["SI_LLS_SHOW_LOOT_ICONS"]                 = "Показывать значки предметы добычи",
    ["SI_LLS_SHOW_LOOT_ICONS_TOOLTIP"]         = "Показывать значки слева от имен предметы добычи, которые появляются в отчет.",
    ["SI_LLS_SHOW_ITEM_TRAITS"]                = "Показать предметы особенности",
    ["SI_LLS_SHOW_ITEM_TRAITS_TOOLTIP"]        = "Показать имена особенности в скобках справа от имен предметы в отчет.",
    ["SI_LLS_SHOW_LOOT_TRAITS"]                = "Показать добычи особенности",
    ["SI_LLS_SHOW_LOOT_TRAITS_TOOLTIP"]        = "Показать имена особенности в скобках справа от имен добычи в отчет.",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY"]            = "Не показывать количество для одного предмет",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY_TOOLTIP"]    = "Числовые метки количества будут напечатаны только справа от названий предметы с количеством больше единицы.",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY"]            = "Не показывать количество для одного предмет",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY_TOOLTIP"]    = "Числовые метки количества будут напечатаны только справа от названий добыча с количеством больше единицы.",
--[[ Thanks to Friday_The13_rus for the following Russian translations! ]]--
    ["SI_LLS_COMBINE_DUPLICATES"]              = "Объединять повторяющиеся предметы",
    ["SI_LLS_COMBINE_DUPLICATES_TOOLTIP"]      = "Ссылки, появляющиеся несколько раз в отчете, будут объеденены в одну и количество предметов будет проссуммировано.",
    ["SI_LLS_SHOW_ITEM_NOT_COLLECTED"]         = "<<1>> Показывать иконки для сетов не в коллекции",
    ["SI_LLS_SHOW_ITEM_NOT_COLLECTED_TOOLTIP"] = "Отображать иконку справа от названия предмета, если он не добавлен в коллекцию.",
    ["SI_LLS_SORT_ORDER_TOOLTIP"]              = "Выберите как будет сортироваться отчет",
    ["SI_LLS_DELIMITER"]                       = "Список разделителей",
    ["SI_LLS_DELIMITER_TOOLTIP"]               = "Выберите какие символы будут разделять предметы в отчете. \"\\n\" значит, что каждый предмет будет отображаться на отдельной строке. ",
    ["SI_LLS_LINK_STYLE"]                      = "Стиль ссылки",
    ["SI_LLS_LINK_STYLE_TOOLTIP"]              = "Выберите как будут отображаться сслыки.",
    ["SI_LLS_QUOTES"]                          = "«<<X:1>>»",
}

for stringId, value in pairs(strings) do
    LLS_STRINGS[stringId] = value
end