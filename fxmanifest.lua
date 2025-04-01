name "Jim-Consumables"
author "Jimathy"
version "2.0"
description "Consumables Script"
fx_version "cerulean"
game "gta5"
lua54 'yes'

server_script '@oxmysql/lib/MySQL.lua'

shared_scripts {
    'config.lua',
    'shared/emotes.lua',
    'shared/consumables.lua',
    'shared/shared.lua',

    -- Required core scripts
    '@ox_lib/init.lua',
    '@ox_core/lib/init.lua',

    '@es_extended/imports.lua',

    '@qbx_core/modules/playerdata.lua',

    --Jim Bridge
    '@jim_bridge/starter.lua',
}

client_scripts {
    'client/*.lua',
}

server_script 'server/*.lua'

dependency 'jim_bridge'