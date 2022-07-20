# jim-consumables
Consumables script for QBCore

# What is this?
This script is designed as a replacement/override for food and drink consumables in qb-smallresources

It's main purpose was to make it possible to not stand up while sitting due to lazy events such as ClearPedTasks in most scripts, this one is designed to cancel the animation you have chosen, not all animations. This includes progressbar.

# Installation
This script is recommended to be ran last/at the bottom of your server.cfg because this is intended to take control of items, if ran too early the original script may override this one.

It already takes control of default qbcore food and drink, but you would probably want to add more.

To add an item, you only need to add a new item table in the Config.Consumables like this:
```lua
["heartstopper"] = {
	emote = "burger", 							-- Select an emote from below, it has to be in here
	time = math.random(5000, 6000),				-- Amount of time it takes to consume the item
	stress = math.random(1,2),					-- Amount of stress relief, can be 0
	heal = 0, 									-- Set amount to heal by after consuming
	armor = 5,									-- Amount of armor to add
	type = "food",								-- Type: "alcohol" / "drink" / "food"
	effect = { effect = "healdouble", },		-- The status effect given by the item, "heal" / "healdouble" / "stamina"
	stats = { hunger = math.random(10,20), },	-- The stats of the item, if not found in the items.lua
},
```

This script supports dpemotes style emotes, so if you have some that you want to be triggered when eating or drinking drop it in the Config.Emotes
