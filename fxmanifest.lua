fx_version 'adamant'
games { 'gta5' }

dependencies {
	'MenuAPI',
	'progressbar'
}

author 'Bostra'
description 'Fameboy Game Console System'
version '1.0.0'

client_scripts {
	"locale.lua",
	"locales/*.lua",
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
	
	"html/css/img/monitor.png",
	"html/css/img/table.png",
	
	"html/*.html",
	
	"html/scripts/listener.js",
}

ui_page "html/index.html"
