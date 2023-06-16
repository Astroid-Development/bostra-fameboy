local QBCore = exports["qb-core"]:GetCoreObject()

function CancelEmote()
	exports.scully_emotemenu:CancelAnimation(forceCancel)
end

function OpenFameboy(listGames, console_, item)
	local Fameboy = {}
	exports.scully_emotemenu:PlayByCommand("fameboy")
	if item.metadata.gamecartridge then
		if item.metadata.gamecartridge.installed and #item.metadata.gamecartridge.installed > 0 then 
			Fameboy[#Fameboy+1] = {
				title = "Games Installed On Device: "..string.format(#item.metadata.gamecartridge.installed),
				disabled = true
			}
			Fameboy[#Fameboy+1] = {
				title = "Select Games",
				icon = "fa-solid fa-gamepad",
				onSelect = function()
					GameMenu(console_, item)
				end
			}
		else
			Fameboy[#Fameboy+1] = {
				title = "Empty Game Cartridge", 
				description = "Your game cartridge doesn't have any games installed!",
				icon = "fa-regular fa-folder-open",
				disabled = true
			}
		end
		Fameboy[#Fameboy+1] = {
			title = "Game Management:",
			disabled = true
		}
		Fameboy[#Fameboy+1] = {
			title = "Install Games",
			icon = "fa-solid fa-gamepad",
			onSelect = function()
				InstallGames(item)
			end
		}
		if item.metadata.gamecartridge.installed and #item.metadata.gamecartridge.installed > 0 then 
			Fameboy[#Fameboy+1] = {
				title = "Uninstall Games",
				icon = "fa-solid fa-gamepad",
				onSelect = function()
					UninstallGames(item)
				end
			}
		end
		Fameboy[#Fameboy+1] = {
			title = "Game Cartridge Management:",
			disabled = true
		}
		Fameboy[#Fameboy+1] = {
			title = "Remove Game Cartridge",
			description = "Remove the current cartridge from you device",
			icon = "fa-solid fa-sd-card",
			serverEvent = "fameboy:server:UninstallCartridge",
			onSelect = function()
				CancelEmote() 
			end,
			args = {
				Fameboy = item,
			}
		}

		lib.registerContext({id = "fameboy_menu", title = "Fame Boy", icon = "gamepad", onExit = function() CancelEmote() end, options = Fameboy})
		lib.showContext("fameboy_menu")
	else
		Fameboy[#Fameboy+1] = {
			title = "Missing game cartridge",
			description = "Your device is missing a game cartridge please insert one",
			icon = "fa-solid fa-sd-card",
			disabled = true
		}
		Fameboy[#Fameboy+1] = {
			title = "Insert game cartridge",
			icon = "fa-solid fa-sd-card",
			onSelect = function()
				InsertGameCartridge(item)
			end
		}
		lib.registerContext({id = "fameboy_missing_cartridge", title = "Fame Boy", icon = "gamepad", onExit = function() CancelEmote() end, options = Fameboy})
		lib.showContext("fameboy_missing_cartridge")
	end
end

function SwapGameCartridge(Fameboy)
	local SwapGameCartridge = {}
	local CartridgeItems = lib.callback("fameboy:server:cartridgecheck")
	if #CartridgeItems then
		for _, Items in pairs(CartridgeItems) do 
			local Description = ""
			if Items.metadata.gamecartridge.installed then
				for _, Game in pairs(Items.metadata.gamecartridge.installed) do 
					Description = Description..Game.game.."\n"
				end
				SwapGameCartridge[#SwapGameCartridge+1] = {
					title = "Swap Cartridge:",
					description = Description,
					icon = "fa-solid fa-sd-card",
					serverEvent = "fameboy:server:SwapGameCartridge",
					onSelect = function()
						CancelEmote()
					end,
					args = {
						Cartridge = Items, 
						Fameboy = Fameboy
					}
				}
			end
		end
	else
		SwapGameCartridge[#SwapGameCartridge+1] = {
			title = "No cartridges to swap",
			disabled = true
		}
	end

	lib.registerContext({id = "fameboy_swap_cartridge", title = "Insert Game Cartridge", onExit = function() CancelEmote() end, menu = "fameboy_menu", options = SwapGameCartridge})
	lib.showContext("fameboy_swap_cartridge")
end

function InsertGameCartridge(Fameboy)
	local InsertCartridge = {}
	local CartridgeItems = lib.callback("fameboy:server:cartridgecheck")
	if #CartridgeItems then
		for _, Items in pairs(CartridgeItems) do 
			local Description = ""
			if Items.metadata.gamecartridge.installed then
				for _, Game in pairs(Items.metadata.gamecartridge.installed) do 
					Description = Description..Game.game.."\n"
				end
				InsertCartridge[#InsertCartridge+1] = {
					title = "Insert Cartridge:",
					description = Description,
					icon = "fa-solid fa-sd-card",
					serverEvent = "fameboy:server:InsertGameCartridge",
					onSelect = function()
						CancelEmote()
					end,
					args = {
						Cartridge = Items, 
						Fameboy = Fameboy
					}
				}
			else
				InsertCartridge[#InsertCartridge+1] = {
					title = "Insert Cartridge:",
					description = "No data on cartridge",
					icon = "fa-solid fa-sd-card",
					serverEvent = "fameboy:server:InsertGameCartridge",
					onSelect = function()
						CancelEmote()
					end,
					args = {
						Cartridge = Items, 
						Fameboy = Fameboy
					}
				}
			end
		end
	else
		InsertCartridge[#InsertCartridge+1] = {
			title = "No cartridges to insert",
			disabled = true
		}
	end

	lib.registerContext({id = "fameboy_insert_cartridge", title = "Insert Game Cartridge", onExit = function() CancelEmote() end, menu = "fameboy_missing_cartridge", options = InsertCartridge})
	lib.showContext("fameboy_insert_cartridge")
end

function GameMenu(console, Fameboy)
	local GameMenu = {}
	for _, Game in pairs(Fameboy.metadata.gamecartridge.installed) do 
		if Game.gamedurability >= 0 then
			GameMenu[#GameMenu+1] = {
				title = Game.game,
				description = "Play Game",
				onSelect = function()
					StartGame(console, Game.game)
					TriggerServerEvent("fameboy:server:UpdateGameDurability", Fameboy, Game.game)
				end
			}
		else
			QBCore.Functions.Notify(Game.game.." was corrupted, and removed from your device", "error")
			TriggerServerEvent("fameboy:server:RemoveCorruptedGame", Fameboy, Game.game)
		end

	end
	lib.registerContext({id = "fameboy_game_menu", title = "Installed Games", onExit = function() CancelEmote() end, menu = "fameboy_menu", options = GameMenu})
	lib.showContext("fameboy_game_menu")
end

function StartGame(Console, Game)
	for _, Data in pairs(Config.GamingMachine) do 
		if Game == Data.name then
			SendNUIMessage({
				type = "on",
				game = Data.link,
				gpu = GPU,
				cpu = CPU
			})
			SetNuiFocus(true, true)
		end
	end
end

function InstallGames(Fameboy)
    local GameMenu = {}
    local Games = lib.callback("fameboy:Server:checkinventorygames")
    local InstalledGames = Fameboy.metadata.gamecartridge
    
    if #Games then
		local GameInstalled  = false
		if InstalledGames.installed then
			for ID, Items in pairs(Games) do 
				for ID, Game in pairs(InstalledGames) do 
					if Game.game == Items.metadata.game then
						GameInstalled = true
						break
					end
				end
				if not gameAlreadyInstalled then
					GameMenu[#GameMenu+1] = {
						title = Items.metadata.game,
						serverEvent = "fameboy:server:InstallGame",
						args = {
							Fameboy = Fameboy,
							Cartridge = Items
						}
					}
				end
			end
		else
			for ID, Game in pairs(Games) do 
				GameMenu[#GameMenu+1] = {
					title = Game.metadata.game,
					serverEvent = "fameboy:server:InstallGame",
					args = {
						Fameboy = Fameboy,
						Cartridge = Game
					}
				}
			end
		end
    else
        GameMenu[#GameMenu+1] = {
            title = "You don't have any games in your inventory",
            disabled = true
        }
    end
    
    lib.registerContext({id = "fameboy_game_installation", title = "Install Games", onExit = function() CancelEmote() end, menu = "fameboy_menu", options = GameMenu})
    lib.showContext("fameboy_game_installation")
end

function UninstallGames(Fameboy)
	local UninstallMenu = {}
	for _, Games in pairs(Fameboy.metadata.gamecartridge.installed) do 
		UninstallMenu[#UninstallMenu+1] = {
			title = Games.game,
			description = "Uninstall",
			serverEvent = "fameboy:server:UninstallGame",
			onSelect = function()
				CancelEmote()
			end,
			args = {
				Fameboy = Fameboy,
				Uninstall = Games.game
			}
		}
	end
	lib.registerContext({id = "fameboy_uninstall_games", title = "Uninstall Games", onExit = function() CancelEmote() end, menu = "fameboy_menu", options = UninstallMenu})
	lib.showContext("fameboy_uninstall_games")
end

RegisterNetEvent("fameboy:open:console", function(console, item)
    OpenFameboy(console.consoleType, console, item)
end)

function CloseFameboy()
    SendNUIMessage({
        type = "off",
        game = "",
    })
    SetNuiFocus(false, false)
    EnableAllControlActions(0)
    EnableAllControlActions(1)
    EnableAllControlActions(2)
    FreezeEntityPosition(PlayerPedId(), false)
    ClearPedTasks(PlayerPedId())
    exports.scully_emotemenu:CancelAnimation(forceCancel)
end

RegisterNUICallback("exit", function()
    CloseFameboy()
end)