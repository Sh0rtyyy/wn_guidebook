fx_version 'cerulean'
game 'gta5'

author 'mrshortyno'
description 'Guidebook script. Discord for support: https://discord.gg/73FzXcKAQu'
version '1.1.0'
lua54 'yes'

client_scripts {
    'client/*.lua',
}

shared_scripts {
    '@es_extended/imports.lua', -- Remove if you use QB-CORE
	'@ox_lib/init.lua',
	'config.lua',
}
