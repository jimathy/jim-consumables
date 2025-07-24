# Jim-Consumables

MultiFrameork Consumables script

## [JixelPatterns GitBook Documentation](https://jixelpatterns.gitbook.io/docs)

## If you need support I have a discord server available, it helps me keep track of issues and give better support.
## [JixelPatterns Discord](https://discord.gg/9pCDHmjYwd)

## If you think I did a good job here, consider donating as it keeps by lights on and my cat round:
## [JixelPatterns Kofi](https://ko-fi.com/jixelpatterns)

# What is this?
This script WAS designed as a replacement/override for food and drink consumables in `qb-smallresources`

It's main purpose was to make it so players did not stand up while sitting with my scripts due to lazy events such as ClearPedTasks in progressbar and dpemotes, this one is designed to cancel the animation you have chosen, not ALL animations.

Users requested I readd the progressbar but it ended up being a config option to enable it

Though if your players are cancelling all animations when consuming, it's recommended to set `Config.UseProgBar` to `false` to get this effect.

# THIS DOESN'T USE DPEMOTES OR RPEMOTES OR SCULLYS EMOTEMENU

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
heartstopper = {
    emote = "burger", 							-- Select an emote from below, it has to be in here
    time = math.random(5000, 6000),				-- Amount of time it takes to consume the item
    stress = math.random(1,2),					-- Amount of stress relief, can be 0
    heal = 0, 									-- Set amount to heal by after consuming
    armor = 5,									-- Amount of armor to add
    type = "food",								-- Type: "alcohol" / "drink" / "food"
    canRun = true,								-- If true player can run while using the item, not to it will cancel the event

    stats = {
        screen = "thermal",						-- The screen effect to be played when after consuming the item "rampage" "turbo" "focus" "weed" "trevor" "nightvision" "thermal"
        effect = "heal",						-- The status effect given by the item, "heal" / "stamina"
												-- This supports ps-buffs effects "armor" "stress" "swimming" "hacking" "intelligence" "luck" "strength"
        time = 10000,							-- How long the effect should last (if not added it will default to 10000)
        amount = 6,								-- How much the value is changed by per second
        hunger = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
        thirst = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
        canOD = true,							-- This creates an OD Effect, killing the user if they have too much
    },
    --Reward Items Variables
                                                -- These can be the only thing in a consumable table and the item will still work
    amounttogive = 3,							-- Used for "RewardItems", tells the script how many to give
    rewards = {
        [1] = {
            item = "plastic", 					-- prize item name
            max = 10,							    -- max amount to give (this is put into math.random(1, max) )
            rarity = 1,							-- the rarity system, 1 being rarest, 4 being most common
        },
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

You can also now create "Box" items, when setting type to "pack", it will act as if you user is opening a box

Examples:
 - Ammo boxes that give clips
 - Packets of cigarretes
 - Crates of beer

How to set up these:
```lua
    -- Example Box Item
["9_box"] = {                                     -- Name of the box item in the shared items
    emote = "uncuff",                             -- The emote than should run when "unboxing"
    canRun = true,                                -- If true player can run while using the item, not to it will cancel the event
    time = 3500,                                  -- How long it takes to use the item
    type = "pack",                                -- Designate it as a "pack" to the script knows what to do
    pack = {
        item = "9_ammo",                          -- The item to give from the box when complete
        amount = 20                               -- How many of the item to give
    },
},
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
