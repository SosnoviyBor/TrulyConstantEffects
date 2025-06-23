local I = require('openmw.interfaces')

I.Settings.registerPage {
    key = 'TrulyConstantEffects',
    l10n = 'TrulyConstantEffects_HUDSettings',
    name = 'page_name',
    description = 'page_description',
}

I.Settings.registerGroup {
    key = 'SettingsTrulyConstantEffects',
    page = 'TrulyConstantEffects',
    l10n = 'TrulyConstantEffects_HUDSettings',
    name = 'group_name',
    permanentStorage = true,
    settings = {
        {
            key = 'invis',
            name = 'invis_name',
            description = 'invis_description',
            renderer = 'checkbox',
            default = false,
        },
        {
            key = 'summons',
            name = 'summons_name',
            description = 'summons_description',
            renderer = 'checkbox',
            default = false,
        },
        {
            key = 'showMessages',
            name = 'showMessages_name',
            description = 'showMessages_description',
            renderer = 'checkbox',
            default = false,
        },
    },
}