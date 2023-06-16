local QBCore = exports["qb-core"]:GetCoreObject()

local gamingconsole = {GPU = Config.GPUList[1], CPU = Config.CPUList[1]}

QBCore.Functions.CreateUseableItem("fameboy", function(source, item)
    TriggerClientEvent("fameboy:open:console", source, gamingconsole, item)
end)

lib.callback.register("fameboy:server:cartridgecheck", function(source)
	local Inventory = exports.ox_inventory:Search(source, "slots", "fameboy_gamecartridge")
	return Inventory
end)

lib.callback.register("fameboy:Server:checkinventorygames", function(source)
	local Inventory = exports.ox_inventory:Search(source, "slots", "fameboy_game")
	return Inventory
end)

RegisterNetEvent("fameboy:server:InsertGameCartridge", function(data)
	exports.ox_inventory:RemoveItem(source, "fameboy_gamecartridge", 1, nil, data.Cartridge.slot)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, {
		gamecartridge = data.Cartridge.metadata.gamecartridge
	})
end)	

RegisterNetEvent("fameboy:server:UninstallCartridge", function(data)
	exports.ox_inventory:AddItem(source, "fameboy_gamecartridge", 1, {
		gamecartridge = data.Fameboy.metadata.gamecartridge
	})
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, {})
end)

RegisterNetEvent("fameboy:server:InstallGame", function(data)
	local GameData = data.Fameboy.metadata.gamecartridge
	local GameToInstall = { game = data.Cartridge.metadata.game, gamedurability = data.Cartridge.metadata.durability or 100 }

	if not GameData.installed then
		GameData.installed = {}
	end

	table.insert(GameData.installed, GameToInstall)

	exports.ox_inventory:RemoveItem(source, "fameboy_game", 1, nil, data.Cartridge.slot)
	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, {
		gamecartridge = GameData
	})
end)

RegisterNetEvent("fameboy:server:UninstallGame", function(data)
	local GameData = data.Fameboy.metadata.gamecartridge
	local UninstallGame = data.Uninstall

	for ID, Game in pairs(GameData.installed) do 
		if Game.game == UninstallGame then
			local ImageName = string.gsub(Game.game, " ", "_")
			exports.ox_inventory:AddItem(source, "fameboy_game", 1, {
				description = ("Game: %s"):format(UninstallGame),
				image = ImageName,
				durability = Game.gamedurability,
				game = UninstallGame
			})
			table.remove(GameData.installed, ID)
			break
		end
	end

	exports.ox_inventory:SetMetadata(source, data.Fameboy.slot, {
		gamecartridge = GameData
	})
end)

RegisterNetEvent("fameboy:server:UpdateGameDurability", function(Fameboy, UsedGame)
	local GameData = Fameboy.metadata.gamecartridge
	for ID, Game in pairs(GameData.installed) do 
		if Game.game == UsedGame then
			Game.gamedurability = Game.gamedurability - math.random(1, 5)
			exports.ox_inventory:SetMetadata(source, Fameboy.slot, {
				gamecartridge = GameData
			})
		end
	end
end)

RegisterNetEvent("fameboy:server:RemoveCorruptedGame", function(Fameboy, UsedGame)
	local GameData = Fameboy.metadata.gamecartridge 
	local UninstallGame = UsedGame

	for ID, Game in pairs(GameData.installed) do
		if Game.game == UninstallGame then
			table.remove(GameData.installed, ID)
			break
		end
	end
	exports.ox_inventory:SetMetadata(source, Fameboy.slot, {
		gamecartridge = GameData
	})
end)

lib.addCommand('givegames', {
    help = 'Gives an item to a player',
    restricted = 'group.admin'
}, function(source, args, raw)
	for k,v in pairs(Config.GamingMachine) do 
		local GameName = v.name
		local ImageName = string.gsub(GameName, " ", "_")
		exports.ox_inventory:AddItem(source, "fameboy_game", 1, {
			description = ("Game: %s"):format(GameName),
			image = ImageName,
			game = GameName
		})
	end
end)

lib.addCommand('givegamecartridge', {
    help = 'Gives an item to a player',
    restricted = 'group.admin'
}, function(source, args, raw)
	exports.ox_inventory:AddItem(source, "fameboy_gamecartridge", 1, {
		gamecartridge = {}
	})
end)