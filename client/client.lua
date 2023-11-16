local Config = require("shared/config")
local PlayingGame = false

local function AnimHandler()
	if not DoesEntityExist(Fameboy) then
		lib.requestAnimDict("amb@code_human_wander_texting_fat@male@base")
		lib.requestModel("fameboy")
		Fameboy = CreateObject("fameboy", GetEntityCoords(cache.ped), true, true, false)
		AttachEntityToEntity(Fameboy, cache.ped, 90, 0, 0, -0.05, 0, 0, 0, true, true, false, true, 1, true)
		TaskPlayAnim(cache.ped, "amb@code_human_wander_texting_fat@male@base", "static", 8.0, 8.0, -1, 1, 0, false, false, false)
	end
	CreateThread(function()
		while true do
			Wait(2000)
			if not lib.getOpenContextMenu() and not PlayingGame then
				DetachEntity(Fameboy, true, true)
				DeleteEntity(Fameboy)
				StopAnimTask(cache.ped, "amb@code_human_wander_texting_fat@male@base", "static", 1.0)
				break
			end
		end
	end)
end

local function GenerateInstalledGames(data)
	local Description = ""
	if data.metadata.gamecartridge.installed then
		for _, Games in pairs(data.metadata.gamecartridge.installed) do
			Description = "\n"..Description.."* "..Games.game.."\n"
		end
	end
	return Description ~= "" and Description or "No Games Installed On SD Card!"
end

local function OpenFameboy(item)
	local Fameboy, SDCard, CardItems = {}, item.metadata.gamecartridge, lib.callback("fameboy:server:returncards")
	AnimHandler()
	Fameboy[#Fameboy+1] = {
		title = "Device Status:",
		description = SDCard and "SD Card: Installed \n Installed Games: "..(SDCard.installed ~= nil and #SDCard.installed or 0) or "SD Card: Not Found",
		disabled = true
	}
	if not SDCard then
		Fameboy[#Fameboy+1] = {
			title = #CardItems > 0 and "Insert SD Card" or "No SD Cards available to insert",
			disabled = not (#CardItems > 0),
			onSelect = #CardItems > 0 and function()
				local Insert = {}
				if #CardItems > 0 then
					for _, Card in pairs(CardItems) do
						if #Card.metadata.gamecartridge.installed then
							Insert[#Insert+1] = {
								title = "Insert SD Card:",
								description = GenerateInstalledGames(Card),
								onSelect = function()
									OpenFameboy(lib.callback.await("fameboy:server:InsertSDCard", false, {Cartridge = Card, Fameboy = item}))
								end,
							}
						else
							Insert[#Insert+1] = {
								title = "Insert SD Card:",
								description = "No games installed on SD Card",
								serverEvent = "fameboy:server:InsertSDCard",
								args = {
									Cartridge = Card,
									Fameboy = item
								}
							}
						end
					end
					lib.registerContext({id = "insert_card", title = "Insert SD Card", menu = "fameboy_main", options = Insert})
					lib.showContext("insert_card")
				end
			end,
		}
	else
		Fameboy[#Fameboy+1] = {
			title = "Play Games",
			onSelect = function()
				local Games = {}
				if #SDCard.installed > 0 then
					for _, Game in pairs(SDCard.installed) do
						if Game.gamedurability > 0 then
							Games[#Games+1] = {
								title = Game.game,
								onSelect = function()
									PlayingGame = true
									SendNUIMessage({type = "on", game = Config[Game.game].link, gpu = Config[Game.game].console.GPU, cpu = Config[Game.game].console.CPU})
									lib.callback.await("fameboy:server:updategamedurability", false, item, Game.game)
									SetNuiFocus(true, true)
								end
							}
						else
							lib.notify({
								title = "Fameboy Game Corrupted",
								description = Game.game.." was corrupted and removed from the device",
								type = "error"
							})
							OpenFameboy(lib.callback.await("fameboy:server:removecorruptedgame", false, item, Game.game))
							return
						end
					end
				end
				lib.registerContext({id = "play_game", title = "Start a Game", menu = "fameboy_main", options = Games})
				lib.showContext("play_game")
			end
		}
		Fameboy[#Fameboy+1] = {
			title = "Game Manager", 
			onSelect = function()
				local Games = {}
				local GameItems = lib.callback("fameboy:server:returngames")
				local InstalledGames = lib.callback.await("fameboy:server:updatefameboy", false, item.slot)

				if #GameItems > 0 then
					local AlreadyInstalled = false
					Games[#Games+1] = {title = "Install Games to SD Card:", disabled = true}
					if InstalledGames.installed then
						for _, Game in pairs(GameItems) do
							for i = 1, #InstalledGames do
								if InstalledGames.game == Game.metadata.game then
									AlreadyInstalled = true
									break
								end
							end
							if not AlreadyInstalled then
								Games[#GameMenu+1] = {
									title = Game.metadata.game,
									onSelect = function()
										OpenFameboy(lib.callback.await("fameboy:server:InstallGame", false, {Fameboy = InstalledGames, Cartridge = Game}))
									end
								}
							end
						end
					else
						for _, Game in pairs(GameItems) do
							Games[#Games+1] = {
								title = Game.metadata.game,
								onSelect = function()
									OpenFameboy(lib.callback.await("fameboy:server:InstallGame", false, {Fameboy = InstalledGames, Cartridge = Game}))
								end
							}
						end
					end
				else
					Games[#Games+1] = {
						title = "No games to install found!",
						disabled = true
					}
				end
				Games[#Games+1] = {title = "Uninstall Games to SD Card:", disabled = true}
				for ID, Game in pairs(SDCard.installed) do
					Games[#Games+1] = {
						title = Game.game,
						onSelect = function()
							OpenFameboy(lib.callback.await("fameboy:server:UninstallGame", false, {Fameboy = item, Uninstall = Game}))
						end
					}
				end

				lib.registerContext({id = "game_management", title = "Game Management", menu = "fameboy_main", options = Games})
				lib.showContext("game_management")
			end
		}
		Fameboy[#Fameboy+1] = {
			title = "SD Card Manager",
			onSelect = function()
				local Management = {}
				local CardItems = lib.callback("fameboy:server:returncards")
				Management[#Management+1] = {
					title = "Remove SD Card",
					onSelect = function()
						OpenFameboy(lib.callback.await("fameboy:server:UninstallSDCard", false, {Fameboy = item}))
					end
				}
				Management[#Management+1] = {
					title = #CardItems > 0 and "Swap SD Card" or "No SD Cards available to swap",
					disabled = not (#CardItems > 0),
					onSelect = #CardItems > 0 and function()
						local Swap = {}
						if #CardItems > 0 then
							for ID, Card in pairs(CardItems) do
								if Card.metadata.gamecartridge.installed then
									Swap[#Swap+1] = {
										title = "Insert SD Card:",
										description = GenerateInstalledGames(Card),
										onSelect = function()
											OpenFameboy(lib.callback.await("fameboy:server:SwapSDCards", false, {Fameboy = item, Cartridge = Card}))
										end
									}
								else
									Swap[#Swap+1] = {
										title = "Insert SD Card:",
										description = "No data on SD Card",
										onSelect = function()
											OpenFameboy(lib.callback.await("fameboy:server:SwapSDCards", false, {Fameboy = item, Cartridge = Card}))
										end
									}
								end
							end
							lib.registerContext({id = "swap_card", title = "Swap SD Card", menu = "sd_management", options = Swap})
							lib.showContext("swap_card")
						end
					end,
				}
				lib.registerContext({id = "sd_management", title = "SD Card Management", menu = "fameboy_main", options = Management})
				lib.showContext("sd_management")
			end
		}
	end

	lib.registerContext({id = "fameboy_main", title = "Fameboy", options = Fameboy})
	lib.showContext("fameboy_main")
end

RegisterNetEvent("fameboy:open:console", OpenFameboy)

RegisterNUICallback("exit", function()
	PlayingGame = false
    SendNUIMessage({type = "off", game = ""})
    SetNuiFocus(false, false)
end)

AddEventHandler("onResourceStop", function(resource)
	if GetCurrentResourceName() ~= resource then return end
	DetachEntity(Fameboy, true, true)
	DeleteEntity(Fameboy)
	StopAnimTask(cache.ped, "amb@code_human_wander_texting_fat@male@base", "static", 1.0)
end)