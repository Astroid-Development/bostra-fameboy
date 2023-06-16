fx_version 'adamant'
games { 'gta5' }

author 'Bostra'
description 'Fameboy Game Console System'
version '1.0.0'

shared_scripts {
	"@ox_lib/init.lua"
}

client_scripts {
	"config.lua",
	"client/client.lua",
}

server_script {
	"locale.lua",
	"locales/*.lua",
	"config.lua",
	"server/server.lua",
}

files {
	"html/css/style.css",
	"html/css/reset.css",
	"html/*.html",
	"html/scripts/listener.js",
}

ui_page "html/index.html"

lua54 'yes'