name "Jim-Consumables"
author "Jimathy"
version "2.0.03"
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

    --Jim Bridge - https://github.com/jimathy/jim_bridge
    '@jim_bridge/starter.lua',
}

client_scripts {
    'client/*.lua',
}

server_script 'server/*.lua'

dependency 'jim_bridge'