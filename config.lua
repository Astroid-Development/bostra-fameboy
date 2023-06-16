Config = {}

Config.GPUList = {
    [1] = "ETX2080",
    [2] = "ETX1050",
    [3] = "ETX660",
}

Config.CPUList = {
    [1] = "U9_9900",
    [2] = "U7_8700",
    [3] = "U3_6300",
    [4] = "BENTIUM",
}

Config.GamingMachine = {
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://bostra-fameboy/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },
    {
        name = "Circus Charlie",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://www.retrogames.cz/NES/Circus_Charlie.nes", "nes", "Circus_Charlie-nes", "4201"),
    },
    {
        name = "Pokemon Emerald",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://serve.emulatorgames.net/roms/gameboy-advance/Pokemon%20-%20Emerald%20Version%20(U).zip", "gba", "PokemonEmerald-gba", "4203", "https://downloads.retrostic.com/bioses/gba_bios.zip"),
    },
    {
        name = "Kirby & The Amazing Mirror",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Kirby%20%26%20The%20Amazing%20Mirror%20(U).zip", "gba", "KirbyTheAmazingMirror-gba", "4204", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "The Legend Of Zelda - A Link To The Past",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Legend%20of%20Zelda,%20The%20-%20A%20Link%20To%20The%20Past%20Four%20Swords%20(U)%20[!].zip", "gba", "LegendOfZeldaALinkToThePast-gba", "4206", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "Super Mario Advance 4 - Super Mario Bros. 3",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://serve.emulatorgames.net/roms/gameboy-advance/Super%20Mario%20Advance%204%20-%20Super%20Mario%20Bros.%203%20(U)%20(V1.1).zip", "gba", "SuperMarioAdvance4-SuperMarioBros.3-gba", "4207", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "Castlevania Aria Of Sorrow",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://serve.emulatorgames.net/roms/gameboy-advance/Castlevania%20-%20Aria%20of%20Sorrow%20GBA.zip", "gba", "Castlevania-AriaOfSorrow-gba", "4208", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "Metroid Zero Mission",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Metroid%20-%20Zero%20Mission%20(U)%20[!].zip", "gba", "Metroid-ZeroMission-gba", "4209", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
    {
        name = "Contra III",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://static.emulatorgames.net/roms/super-nintendo/Contra%20III%20-%20The%20Alien%20Wars%20(U)%20[!].zip", "snes", "Contraiii-snes", "4205"),
    },
    {
        name = "Sonic Advanced",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://server.emulatorgames.net/roms/gameboy-advance/Sonic%20Advance%20(U)%20[!].zip", "gba", "SonicAdvance-gba", "4210"),
    },
}