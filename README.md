Uses item metadata/memory cards to store games, after a certain amount of uses, the game will degrade an no longer be playable

# Dependencies

ox_inventory: https://github.com/overextended/ox_inventory

ox_lib: https://github.com/overextended/ox_lib

# Preview

[![Preview](https://img.youtube.com/vi/c0vZLp0ZtrI/0.jpg)](https://www.youtube.com/watch?v=c0vZLp0ZtrI)

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
````


Place the fameboy-bostra folder in [Props], inside of the stream folder for Scully EmoteMenu.

Add the emote in animations/prop_emotes.lua
````
    {
        Label = 'Fameboy',
        Command = 'fameboy',
        Animation = 'static',
        Dictionary = 'amb@code_human_wander_texting_fat@male@base',
        Options = {
            Flags = {
                Loop = true,
                Move = true,
            },
            Props = {
                {
                    Bone = 28422,
                    Name = 'fameboy',
                    Placement = {
                        vector3(0.000000, 0.000000, -0.050000),
                        vector3(0.000000, 0.000000,  0.000000),
                    },
                },
            },
        },
    }
````

# Credits

* For the original code [Link](https://github.com/Xogy/rcore_arcade) (Xogy)
* Fork/improvements [Link](https://github.com/d3st1nyh4x/d3-arcade) (d3st1nyh4x)
* Fork/improvements :) [Link](https://github.com/B0STRA/bostra-fameboy) (B0STRA)

TODO: 
* Finish swapping cartridges?
* GPU/CPU Handling
