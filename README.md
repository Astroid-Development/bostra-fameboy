Uses item metadata/memory cards to store games, after a certain amount of uses, the game will degrade an no longer be playable

# Dependencies

ox_inventory: https://github.com/overextended/ox_inventory

ox_lib: https://github.com/overextended/ox_lib

# Preview

[![Preview](https://img.youtube.com/vi/xtJCeAv0iy8/0.jpg)](https://www.youtube.com/watch?v=xtJCeAv0iy8)

Add these items to your ox_inventory/data/items.lua-

```	---Fameboy Items
	["fameboy_gamecartridge"] = {
		label = "Fame Boy Game Cartridge",
		weight = 0,
		stack = false,
		close = true,
		description = "You can store all your games on this device",
		client = {
			image = "fameboy_game.png",
		}
	},

	["fameboy_game"] = {
		label = "Fame Boy Game",
		weight = 0,
		stack = false,
		close = true,
		description = "",
		client = {
			image = "fameboy_game.png",
		}
	},

	["fameboy"] = {
		label = "Fameboy",
		weight = 0,
		stack = false,
		close = true,
		description = "Play all your favorite games on this device on the go!",
		client = {
			image = "fameboy.png",
		}
	},
````

# Credits

* For the original code [Link](https://github.com/Xogy/rcore_arcade) (Xogy)
* Fork/improvements [Link](https://github.com/d3st1nyh4x/d3-arcade) (d3st1nyh4x)
* Fork/improvements :) [Link](https://github.com/B0STRA/bostra-fameboy) (B0STRA)