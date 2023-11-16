local QBCore = exports["ad-core"]:GetCoreObject()
local GamesList = require("shared/config")

QBCore.Functions.CreateUseableItem("fameboy", function(source, item)
    TriggerClientEvent("fameboy:open:console", source, item)
end)

lib.callback.register("fameboy:server:returncards", function(source)
	return exports.ox_inventory:Search(source, "slots", "fameboy_gamecartridge")
end)

lib.callback.register("fameboy:server:returngames", function(source)
	return exports.ox_inventory:Search(source, "slots", "fameboy_game")
end)

lib.callback.register("fameboy:server:updatefameboy", function(source, slot)
	return exports.ox_inventory:GetSlot(source, slot)
end)

lib.callback.register("fameboy:server:InsertSDCard", function(source, data)
	exports.ox_inventory:RemoveItem(source, "fameboy_gamecartridge", 1, nil, data.Cartridge.slot)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, data.Cartridge.metadata)
	return exports.ox_inventory:GetSlot(source, data.Fameboy.slot)
end)

lib.callback.register("fameboy:server:UninstallSDCard", function(source, data)
	exports.ox_inventory:AddItem(source, "fameboy_gamecartridge", 1, data.Fameboy.metadata)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, {})
	return exports.ox_inventory:GetSlot(source, data.Fameboy.slot)
end)

lib.callback.register("fameboy:server:SwapSDCards", function(source, data)
	exports.ox_inventory:AddItem(source, "fameboy_gamecartridge", 1, data.Fameboy.metadata)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, data.Cartridge.metadata)
	exports.ox_inventory:RemoveItem(source, "fameboy_gamecartridge", 1, data.Cartridge.metadata, data.Cartridge.slot)
	return exports.ox_inventory:GetSlot(source, data.Fameboy.slot)
end)

lib.callback.register("fameboy:server:InstallGame", function(source, data)
	local GameData = data.Fameboy.metadata.gamecartridge
	local GameToInstall = { game = data.Cartridge.metadata.game, gamedurability = data.Cartridge.metadata.durability or 100 }

	if not GameData.installed then
		GameData.installed = {}
	end

	table.insert(GameData.installed, GameToInstall)

	exports.ox_inventory:RemoveItem(source, "fameboy_game", 1, nil, data.Cartridge.slot)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, data.Fameboy.metadata)
	return exports.ox_inventory:GetSlot(source, data.Fameboy.slot)
end)

lib.callback.register("fameboy:server:UninstallGame", function(source, data)
	for ID, Game in pairs(data.Fameboy.metadata.gamecartridge.installed) do 
		if Game.game == data.Uninstall.game then
			exports.ox_inventory:AddItem(source, "fameboy_game", 1, {
				description = ("Game: %s"):format(data.Uninstall.game),
				image = string.gsub(Game.game, " ", "_"),
				game = data.Uninstall.game,
				durability = data.Uninstall.gamedurability
			})
			table.remove(data.Fameboy.metadata.gamecartridge.installed, ID)
			exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, data.Fameboy.metadata)
			break
		end
	end
	return exports.ox_inventory:GetSlot(source, data.Fameboy.slot)
end)

lib.callback.register("fameboy:server:updategamedurability", function(source, Fameboy, UsedGame)
	for ID, Game in pairs(Fameboy.metadata.gamecartridge.installed) do
		if Game.game == UsedGame then
			Game.gamedurability = Game.gamedurability - math.random(1, 5)
			exports.ox_inventory:SetMetadata(source, Fameboy.slot, Fameboy.metadata)
		end
	end
	return true
end)

lib.callback.register("fameboy:server:removecorruptedgame", function(source, Fameboy, UsedGame)
	for ID, Game in pairs(Fameboy.metadata.gamecartridge.installed) do
		if Game.game == UsedGame then
			table.remove(Fameboy.metadata.gamecartridge.installed, ID)
			break
		end
	end
	exports.ox_inventory:SetMetadata(source, Fameboy.slot, Fameboy.metadata)
	return exports.ox_inventory:GetSlot(source, Fameboy.slot)
end)

local ShopItems = {}

CreateThread(function()
	ShopItems[#ShopItems+1] = {
		name = "fameboy",
		price = 500,
	}

	ShopItems[#ShopItems+1] = {
		name = "fameboy_gamecartridge",
		price = 100,
		metadata = {
			gamecartridge = {
				installed = {

				}
			}
		}
	}

	for Game, _ in pairs(GamesList) do
		ShopItems[#ShopItems+1] = {
			name = "fameboy_game",
			price = 500,
			metadata = {
				description = ("Game: %s"):format(Game),
				image = string.gsub(Game, " ", "_"),
				game = Game,
			}
		}
	end

	exports.ox_inventory:RegisterShop("fameboy_shop", {
		name = "Game Store",
		inventory = ShopItems,
	})
end)