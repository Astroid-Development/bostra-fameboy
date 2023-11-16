fx_version "adamant"
games { "gta5" }

author "Bostra"
description "Fameboy Game Console System"
version "1.0.0"

files { "html/css/*.css", "html/*.html", "html/scripts/*.js" }
shared_scripts { "@ox_lib/init.lua", "shared/*.lua"}
client_scripts { "client/*.lua"}
server_script { "server/*.lua" }


data_file "DLC_ITYP_REQUEST" "stream/fameboy.ytyp"
ui_page "html/index.html"

lua54 "yes"