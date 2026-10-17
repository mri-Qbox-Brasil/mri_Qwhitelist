fx_version "cerulean"
game "gta5"
lua54 "yes"
use_experimental_fxv2_oal "yes"

description "REPO_DESCRIPTION"
author "MRI QBOX Team"
version "MRIQBOX_VERSION"

ox_lib "locale"

<<<<<<< fork
shared_scripts {
    "@ox_lib/init.lua",
||||||| base
shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    'resource/client.lua',
    'resource/interactions/**.lua',
=======
shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'resource/client.lua',
>>>>>>> upstream
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*.lua"
}

client_scripts {
    "interactions/*.lua",
    "client/*.lua"
}

files {
    "locales/*.json"
}

dependencies {
<<<<<<< fork
    "ox_lib",
    "oxmysql",
    "/server:4500"
||||||| base
    'ox_lib',
    'oxmysql',
    'stevo_lib',
    '/server:4500',
=======
    'ox_lib'
>>>>>>> upstream
}
