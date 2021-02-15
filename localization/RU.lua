--[[ Thanks to Friday_The13_rus for the following Russian translations! ]]--
local strings = {
    ["SI_LLS_ITEM_SUMMARY"]                    = "Отчет о предметах",
    ["SI_LLS_ITEM_SUMMARY_TOOLTIP"]            = "<<1>> напечатает отчет о предметах после всех действий.",
    ["SI_LLS_LOOT_SUMMARY"]                    = "Отчет о добыче",
    ["SI_LLS_LOOT_SUMMARY_TOOLTIP"]            = "<<1>> напечатает отчет о добыче после всех действий.",
    ["SI_LLS_MIN_ITEM_QUALITY"]                = "Минимальное качество предмета",
    ["SI_LLS_MIN_ITEM_QUALITY_TOOLTIP"]        = "Предметы с качеством ниже этого значения не включаются в отчет.",
    ["SI_LLS_MIN_LOOT_QUALITY"]                = "Минимальное качество добычи",
    ["SI_LLS_MIN_LOOT_QUALITY_TOOLTIP"]        = "Добыча с качеством ниже этого значения не включается в отчет.",
    ["SI_LLS_SHOW_ITEM_ICONS"]                 = "Показывать иконки предметов",
    ["SI_LLS_SHOW_ITEM_ICONS_TOOLTIP"]         = "Показывать иконку слева от имени предметов, появляющихся в отчете.",
    ["SI_LLS_ICON_SIZE"]                       = "Размер иконки",
    ["SI_LLS_ICON_SIZE_TOOLTIP"]               = "Установите размер иконки в процентах.",
    ["SI_LLS_SHOW_LOOT_ICONS"]                 = "Показывать иконки добычи",
    ["SI_LLS_SHOW_LOOT_ICONS_TOOLTIP"]         = "Показывать иконку слева от имени добычи, появляющейся в отчете.",
    ["SI_LLS_SHOW_ITEM_TRAITS"]                = "Показать особенности предметов",
    ["SI_LLS_SHOW_ITEM_TRAITS_TOOLTIP"]        = "Показать особенности предметов в скобках справа от имени в отчете.",
    ["SI_LLS_SHOW_LOOT_TRAITS"]                = "Показать особенности добычи",
    ["SI_LLS_SHOW_LOOT_TRAITS_TOOLTIP"]        = "Показать особенности добычи в скобках справа от имени в отчете.",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY"]            = "Скрыть количество для одного предмета",
    ["SI_LLS_HIDE_ITEM_SINGLE_QTY_TOOLTIP"]    = "Количество будет напечатано справа от названий предметов только если оно больше единицы.",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY"]            = "Скрыть количество для одной добычи",
    ["SI_LLS_HIDE_LOOT_SINGLE_QTY_TOOLTIP"]    = "Количество будет напечатано справа от названия добычи только если оно больше единицы.",
    ["SI_LLS_COMBINE_DUPLICATES"]              = "Объединять повторяющиеся предметы",
    ["SI_LLS_COMBINE_DUPLICATES_TOOLTIP"]      = "Ссылки, появляющиеся несколько раз в отчете, будут объеденены в одну и количество предметов будет проссуммировано.",
    ["SI_LLS_SHOW_ITEM_NOT_COLLECTED"]         = "<<1>> Показывать иконки для сетов не в коллекции",
    ["SI_LLS_SHOW_ITEM_NOT_COLLECTED_TOOLTIP"] = "Отображать иконку справа от названия предмета, если он не добавлен в коллекцию.",
    ["SI_LLS_SORT_ORDER_TOOLTIP"]              = "Выберите как будет сортироваться отчет",
    ["SI_LLS_DELIMITER"]                       = "Список разделителей",
    ["SI_LLS_DELIMITER_TOOLTIP"]               = "Выберите какие символы будут разделять предметы в отчете. \"\\n\" значит, что каждый предмет будет отображаться на отдельной строке. ",
    ["SI_LLS_LINK_STYLE"]                      = "Стиль ссылки",
    ["SI_LLS_LINK_STYLE_TOOLTIP"]              = "Выберите как будут отображаться сслыки.",
}

for stringId, value in pairs(strings) do
    LLS_STRINGS[stringId] = value
end