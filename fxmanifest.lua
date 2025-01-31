fx_version 'cerulean'
game 'gta5'

author 'Notepad'
description 'Craftable items'

shared_scripts { '@ox_lib/init.lua', 'config.lua'}

client_scripts {'client/*.lua'}

server_scripts {'server/*.lua'}

dependencies { '/onesync', 'ox_lib' }

lua54 'yes'