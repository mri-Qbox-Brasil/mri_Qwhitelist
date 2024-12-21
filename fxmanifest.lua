fx_version "cerulean"
game "gta5"

author "StevoScripts | steve"
description "REPO_DESCRIPTION"
version "MRIQBOX_VERSION"

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'resource/client.lua',
    'resource/interactions/**.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/server.lua',
}

dependencies {
    'ox_lib',
    'oxmysql',
    '/server:4500',
}

lua54 "yes"
