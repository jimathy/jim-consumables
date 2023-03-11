# Jim-Consumables
Consumables script for QBCore

# What is this?
This script is designed as a replacement/override for food and drink consumables in `qb-smallresources`

It's main purpose was to make it so players did not stand up while sitting with my scripts due to lazy events such as ClearPedTasks in progressbar and dpemotes, this one is designed to cancel the animation you have chosen, not all animations.

It's recommended to set `Config.UseProgBar` to `false` to get this effect.

# THIS DOESN'T USE DPEMOTES OR RPEMOTES 
# YOU **NEED** TO PUT THE EMOTES IN THE BOTTOM OF THE CONFIG.LUA

## v1.5 Update Information
	I've added a export system that allows scripts to easily add new foods and drinks to be usable and then sync them between players
	This should work but may have issues.

	But because of the export system being used, Jim-Consumables **NEEDS** to start before any scripts that use it.

	This will be built into my scripts that use consumables to make it more plug and play

# Installation

- I always recommend starting my scripts **AFTER** `[qb]` not inside it as it can mess with any dependancies on server load
- I have a separate folder called `[jimextras]` (that is also in the resources folder) that starts before any scripts would use it.
- This ensure's it has everything it requires before trying to load
- Example of my load order:
```CSS
# QBCore & Extra stuff
ensure qb-core
ensure [qb]
ensure [standalone]
ensure [voice]
ensure [defaultmaps]
ensure [vehicles]

# Extra Jim Stuff
ensure [jimextras]
ensure [jim]
```

## QB-SmallResources

- It should already take control of default qbcore food, drink and drugs.
- If it fails to do this and attempts to use qb-smallresources still you will need to:
- `[qb]` > `qb-smallresources` > `server` > `consumables.lua`
- Remove or comment out the `CreateUseableItem` events for *alcohol*, *eat*, *drink* and *drug* in this file
- Not all of them! (such as armour related items)
- This ***should*** stop `qb-smallresources` taking control and confusing `jim-consumables`

## New Items
To add an item, you only need to add a new item table in the Config.Consumables like this:
```lua
["heartstopper"] = {
	emote = "burger",			-- Select an emote from below, it has to be in here
	time = math.random(5000, 6000),		-- Amount of time it takes to consume the item
	stress = math.random(1, 2),		-- Amount of stress relief, can be 0
	heal = 0,				-- Set amount to heal by after consuming
	armor = 5,				-- Amount of armor to add
	type = "food",				-- Type: "alcohol" / "drink" / "food"
	returnItem = {						-- Item that will be given when the item is used
		item = "plastic",				-- eg. Plastic bottles can give "plastic"
		amount = 1,
	},
	stats = {
		screen = "rampage",		-- The screen effect to be played when after consuming the item
		effect = "heal", 		-- The status effect given by the item, "heal" / "stamina"
		time = 10000,			-- How long the effect should last (if not added it will default to 10000)
		amount = 2,			-- How much the value is changed by per second
		hunger = math.random(10,20),	-- The hunger/thirst stats of the item, if not found in the items.lua
		thirst = math.random(10,20),	-- The hunger/thirst stats of the item, if not found in the items.lua
	},
},
```
Consuming an item can also manually activate screen effects

The example above uses `rampage` as this is what the effect is named after, you can use it for any item you think best
```lua
--The current list of screen effects are:
	"turbo"
	"focus"
	"rampage"
	"weed"
	"trevor"
	"nightvision"
	"thermal"
```

## PS-Buffs Support
This scripts can be expanded with ps-buffs (https://github.com/Project-Sloth/ps-buffs)

If this script is enabled it will automatically try to use their system to apply buffs:

```lua
--The extra buffs that can be set include:
	"heal"			-- Health recovery buff
	"stamina"		-- Stamina recovery buff
	"swimming"		-- Swimming speed buff
	"stress"		-- Stress recovery buff
	"armor"			-- Armour recovery buff
	"hacking"		-- Hacking effect
	"intelligence"		-- Intelligence effect
	"luck"			-- Luck effect
	"strength"		-- Strength effect
```

This script supports dpemotes style emotes, so if you have some that you want to be triggered when eating or drinking drop it in the Config.Emotes section.


## Add consumables from external scripts

A small example of a server-sided snippet for this imports the item and the emote, then syncs it to players before and after they connect.

```lua
local foodTable = {
	["shotfries"] = { emote = "bsfries", canRun = false, time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(55,65), }},
}

local emoteTable = {
	["bsfries"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Fries", AnimationOptions = { Prop = "prop_food_bs_chips", PropBone = 18905, PropPlacement = {0.09, -0.06, 0.05, 300.0, 150.0}, EmoteMoving = true, EmoteLoop = true, }},
}

for k, v in pairs(foodTable) do TriggerEvent("jim-consumables:server:syncAddItem", k, v) end
for k, v in pairs(emoteTable) do TriggerEvent("jim-consumables:server:syncAddEmote", k, v) end
```
This will grab the `shotfries` item info and add it to the `Config.Consumables` while the servers running and the same with the built-in emote system
