-------------------
-- Exports
-------------------
MenuAPI = exports.MenuAPI

function openConsoleMenu(listGames, console_)
    local console = console_
    local index = 0
    local gameMenu = MenuAPI:CreateMenu("gamelist")

    gameMenu.SetMenuTitle(_U("console_menu"))

    gameMenu.SetProperties({
        float = "right",
        position = "middle",
    })

    for key, value in pairs(listGames) do
        index = index + 1
        print(index, value.name)
        gameMenu.AddItem(index, value.name, function()
            gameMenu.Close()
            usingConsole = true
            SendNUIMessage({
                type = "on",
                game = value.link,
                gpu = console.consoleGPU,
                cpu = console.consoleCPU
            })
            SetNuiFocus(true, true)
        end)
    end

    gameMenu.Open()
end

RegisterNetEvent('bostra-fameboy:open:console', function(console)
    openConsoleMenu(console.consoleType, console)
end)

RegisterNetEvent('bostra-fameboy:close:console', function()
    if usingConsole then
        SendNUIMessage({
            type = "off",
            game = "",
        })
        SetNuiFocus(false, false)
        local ped = PlayerPedId()
        EnableAllControlActions(0)
        EnableAllControlActions(1)
        EnableAllControlActions(2)
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        usingConsole = false
    end
end)

RegisterNUICallback('exit', function()
    TriggerEvent('bostra-fameboy:close:console')
end)
