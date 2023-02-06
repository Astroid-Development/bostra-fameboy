QBCore = exports['qb-core']:GetCoreObject()

local retroconsole = {
    consoleType = Config.RetroMachine,
    consoleGPU = Config.GPUList[1],
    consoleCPU = Config.CPUList[1],
}

local gamingconsole = {
    consoleType = Config.GamingMachine,
    consoleGPU = Config.GPUList[1],
    consoleCPU = Config.CPUList[1],
}

local superconsole = {
    consoleType = Config.SuperMachine,
    consoleGPU = Config.GPUList[1],
    consoleCPU = Config.CPUList[1],
}

--/command to test all games as the fameboy advanced console
QBCore.Commands.Add('testgames', 'Test Fameboy', {}, false, function(source)
    local src = source
    TriggerClientEvent('bostra-fameboy:open:console', src, superconsole)
end, 'admin')

--Creates 3 types of fameboy consoles
QBCore.Functions.CreateUseableItem("retrofameboy", function(src,item)
    TriggerClientEvent('bostra-fameboy:open:console', src, retroconsole)
end)

QBCore.Functions.CreateUseableItem("fameboy", function(src,item)
    TriggerClientEvent('bostra-fameboy:open:console', src, gamingconsole)
end)

QBCore.Functions.CreateUseableItem("fameboyadvanced", function(src,item)
    TriggerClientEvent('bostra-fameboy:open:console', src, superconsole)
end)

