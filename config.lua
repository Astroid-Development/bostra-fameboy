Config = {}

-- Which translation you wish to use ?
Config.Locale = "en"

-- do not change unless you know what you're doing
Config.GPUList = {
    [1] = "ETX2080",
    [2] = "ETX1050",
    [3] = "ETX660",
}

-- do not change unless you know what you're doing
Config.CPUList = {
    [1] = "U9_9900",
    [2] = "U7_8700",
    [3] = "U3_6300",
    [4] = "BENTIUM",
}

-- game list for gaming machine
Config.GamingMachine = {
    {
        name = "DOOM",
        link = string.format("nui://bostra-fameboy/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
    },
    {
        name = "Duke Nukem 3D",
        link = string.format("nui://bostra-fameboymeboymeboy/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
    },
    {
        name = "Wolfenstein 3D",
        link = string.format("nui://bostra-fameboy/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
    },
    -- emulatorjs powers this second page, it takes in a rom url, a "core" type (eg nes, snes, etc) a game name, and an id for network play (yep! some cores support network play!)
    -- for more info see : 
    -- https://github.com/ethanaobrien/emulatorjs/tree/main/docs
    {
        name = "Circus Charlie",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://www.retrogames.cz/NES/Circus_Charlie.nes", "nes", "Circus_Charlie-nes", "4201"),
    },
    {
        name = "Sonic The Hedgehog",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://www.retrogames.cz/Genesis/SonictheHedgehog.zip", "segaMD", "SonictheHedgehog-segaMD", "4202"),
    },
    -- some cores require a bios, you may pass it in like this
    {
        name = "Pokemon Fire Red",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Pokemon%20Ultra%20Violet%20(1.22)%20LSA%20(Fire%20Red%20Hack).zip", "gba", "PokemonFireRed-gba", "4203", "https://downloads.retrostic.com/bioses/gba_bios.zip"),
    },
        -- you may need to encode characters such as "&" in urls, or the query parser might get confused.
    {
        name = "Kirby & The Amazing Mirror",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://static.emulatorgames.net/roms/gameboy-advance/Kirby%20%26%20The%20Amazing%20Mirror%20(U).zip", "gba", "KirbyTheAmazingMirror-gba", "4204", "https://phoenixnap.dl.sourceforge.net/project/gameboid/gba_bios907607290.bin"),
    },
}

-- game list for retro machine
Config.RetroMachine = {
    {
        name = "Ants",
        link = "http://ants.robinko.eu/fullscreen.html",
    },
    {
        name = "Pacman",
        link = "http://xogos.robinko.eu/PACMAN/",
    },
    {
        name = "Tetris",
        link = "http://xogos.robinko.eu/TETRIS/",
    },
    {
        name = "Ping Pong",
        link = "http://xogos.robinko.eu/PONG/",
    },
    {
        name = "Slide a Lama",
        link = "http://lama.robinko.eu/fullscreen.html",
    },
    {
        name = "Uno",
        link = "https://duowfriends.eu/",
    },
    {
        name = "FlappyParrot",
        link = "http://xogos.robinko.eu/FlappyParrot/",
    },
    {
        name = "Zoopaloola",
        link = "http://zoopaloola.robinko.eu/Embed/fullscreen.html"
    }
}

-- game list for super console
Config.SuperMachine = {
    {
        name = "Contra III",
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s", "https://static.emulatorgames.net/roms/super-nintendo/Contra%20III%20-%20The%20Alien%20Wars%20(U)%20[!].zip", "snes", "Contraiii-snes", "4205"),
    },
    {
        name = "Harvest Moon", -- BIG GAME! will take a while to download/boot up
        link = string.format("nui://bostra-fameboy/html/ejs.html?url=%s&params=%s&name=%s&id=%s&bios=%s", "https://server.emulatorgames.net/server2/roms/playstation/Harvest%20Moon%20-%20Back%20to%20Nature%20[NTSC-U]%20[SLUS-01115].rar", "psx", "HarvestMoon-psx", "4206", "https://securityhope.com/attachments/scph5501-bin.56/"),
    },
}

for i = 1, #Config.RetroMachine do
    table.insert(Config.SuperMachine, Config.RetroMachine[i])
end

for i = 1, #Config.GamingMachine do
    table.insert(Config.SuperMachine, Config.GamingMachine[i])
end

