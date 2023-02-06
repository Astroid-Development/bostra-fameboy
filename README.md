# bostra-fameboy

This fork is focused on optimizing the original rcore_arcade and d3-arcade fork for QBCore, and adding some new features like levels of crafting the different consoles to accessing different games, and using the game system only as items in the inventory.

Preview:
https://medal.tv/clips/U2XYQKE7xqxUn/vpGoETYnC?invite=cr-MSxUd1IsNDE3NzM0Njgs

Dependencies:
MenuAPI: https://github.com/d3st1nyh4x/MenuAPI (planning to switch to qb-menu)
QBCore Progressbar for item use: https://github.com/qbcore-framework/progressbar


Add these items to your qb-core/shared/items.lua
```	---Fameboy Items
	['fameboy']                   = { ['name'] = 'fameboy', ['label'] = 'Fameboy', ['weight'] = 125,
		['type'] = 'item', ['image'] = 'fameboy.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true,
		['combinable'] = { accept = { 'trojan_usb' }, reward = 'fameboyadvanced',
		anim = { ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
			['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Doing techy stuff...', ['timeOut'] = 7500, } }, ['description'] = 'The Famed and fabled Fameboy' },
	["brokenretrofameboy"]        = { ["name"] = "brokenretrofameboy", ["label"] = "Broken Retro Fameboy", ["weight"] = 200,
		["type"] = "item",
		["image"] = "retrofameboy.png", ["unique"] = false, ["useable"] = false, ["shouldClose"] = false,
		['combinable'] = { accept = { 'electronickit' }, reward = 'retrofameboy',
			anim = { ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
				['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Doing techy stuff...', ['timeOut'] = 7500, } },
		["description"] = "The electronics look fried..." },
	['retrofameboy']              = { ['name'] = 'retrofameboy', ['label'] = 'Retro Fameboy', ['weight'] = 125,
		['type'] = 'item', ['image'] = 'retrofameboy.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true,
		['combinable'] = { accept = { 'usb_drive' }, reward = 'fameboy',
		anim = { ['dict'] = 'anim@amb@business@weed@weed_inspecting_high_dry@',
			['lib'] = 'weed_inspecting_high_base_inspector', ['text'] = 'Doing techy stuff...', ['timeOut'] = 7500, } }, ['description'] = 'The classic and reliable Retro Fameboy' },
	['fameboyadvanced']           = { ['name'] = 'fameboyadvanced', ['label'] = 'Fameboy Advanced', ['weight'] = 125,
		['type'] = 'item', ['image'] = 'fameboyadvanced.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true,
		['combinable'] = nil, ['description'] = 'The advanced Fameboy model' },
````









```Original README```
# HEAVILY based on [rcore_arcade](https://github.com/Xogy/rcore_arcade)

QBCore Arcade System

This fork features small upgrades and framework dependent changes to improve on the original rcore_arcade.

The emulatorjs integration has been PRd to the original rcore_arcade! I will strive to add to the original wherever possible, however, this is a QBCore specific resource which means
some if not most of the incoming changes will not work with the original, which is developed as a standalone/esx script.

I'll add some documentation of the config, however it's pretty straight forward.

There are 3 types of machines, RetroMachine, GamingMachine and SuperMachine.
the above mentioned values correspond to lists of games, where supermachine is an aggregate (combination of) RetroMachine and GamingMachine.
There are comments on the config on how to add new games, but it boils down to selecting a page (dos or ejs), and filling the appropiate query parameters:

DOSBOX:
```
    {
        -- this is the name in the menu/ game list
        name = "Duke Nukem 3D", 
        -- link to msdos page, link to rom, and executable (in this zip, there is an EXE called DUKE3D which starts the game. This may be a BAT in some cases)
        link = string.format("nui://bostra-fameboy/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    }
```
EJS:
```
    {
        -- this is the name in the menu/ game list
        name = "Contra III",
        -- link to ejs page, link to rom, core, uniquename, and unique id (for net play)
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://static.emulatorgames.net/roms/super-nintendo/Contra%20III%20-%20The%20Alien%20Wars%20(U)%20[!].zip", "snes", "Contraiii-snes", "4205"),
    },
```
CPU/GPU, what do they do?

the cpu determines how long the initial loading bar lasts<br>
the gpu determines the resolution of the screen

TODO:
- [x] QB-Target integration to allow all arcade machines to work
- [x] Freeze Player to allow gamepad use without punching and moving in GTA
- [x] Add some animations to show player is using arcade machine / console

KNOWN ISSUES:

UI button to load state will softlock the game requiring an F8 quit.<br>
Gamepad controls character in GTA and emulator at the same time.

MISC:

/testgames opens a "super console" with all games for testing purposes, restricted to admins.

Dependencies

QB-Target<br>
https://github.com/d3st1nyh4x/MenuAPI (fork fixed for large lists)
