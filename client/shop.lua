local Locations, SpawnedEntities = require("shared/locations"), {} 

local function SetupShops()
    for _, data in pairs(Locations) do
        lib.requestModel(data.model)
        local CreatedPed = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z - 1, data.coords.w, false, true)
        FreezeEntityPosition(CreatedPed, true)
        table.insert(SpawnedEntities, CreatedPed)
        exports.ox_target:addLocalEntity(CreatedPed, {
            {
                label = "Access Game Store",
                icon = "fas fa-gamepad",
                onSelect = function()
                    exports.ox_inventory:openInventory("shop", { type = "fameboy_shop" })
                end
            }
        })
    end
end

local function UnloadShops()
    if #SpawnedEntities == 0 then return end
    for _, Peds in pairs(SpawnedEntities) do
        DeleteEntity(Peds)
    end
end

AddEventHandler("QBCore:Client:OnPlayerLoaded", SetupShops)
RegisterNetEvent("QBCore:Client:OnPlayerUnload", UnloadShops)
AddEventHandler("onResourceStop", function(resource)
    if GetCurrentResourceName() ~= resource then return end
    UnloadShops()
end)
