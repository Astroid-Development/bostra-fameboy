## d3-arcade
# HEAVILY based on [https://github.com/Xogy/rcore_arcade](rcore_arcade)

WIP, QBCore version of rcore_arcade

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
        link = string.format("nui://rcore_arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    }
```
EJS:
```
    {
        -- this is the name in the menu/ game list
        name = "Contra III",
        -- link to ejs page, link to rom, core, uniquename, and unique id (for net play)
        link = string.format("nui://rcore_arcade/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://static.emulatorgames.net/roms/super-nintendo/Contra%20III%20-%20The%20Alien%20Wars%20(U)%20[!].zip", "snes", "Contraiii-snes", "4205"),
    },
```
CPU/GPU, what do they do?

the cpu determines how long the initial loading bar lasts
the gpu determines the resolution of the screen

TODO:
QB-Target integration to allow all arcade machines to work
Freeze Player to allow gamepad use without punching and moving in GTA
Add some animations to show player is using arcade machine / computer
Fix non quick save states (maybe)

Dependencies

https://github.com/d3st1nyh4x/MenuAPI (fork fixed for large lists)
