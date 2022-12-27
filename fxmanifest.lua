fx_version 'cerulean'
game 'gta5'

name 'Serrulata-Studios'
author 'Monesuper#0001'
description ''
version '1.0.0'

shared_script {
    '@ox_lib/init.lua',
    'shared/config.lua',
}

client_scripts {   
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

dependencies {
    'ox_lib',
    'bcs_questionare'
}

lua54 'yes'