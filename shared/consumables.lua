Config = Config or {}

Config.Consumables = {
    redwood_cigarette = {       emote = "smoke2",       canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },
    debonaire_cigarette = {     emote = "smoke2",       canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },

    estancia_cigar = {          emote = "smokecigar",   canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },

    olivaseriev = {             emote = "smokecigar",   canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },
    montecristo = {             emote = "smokecigar",   canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },
    partagas = {                emote = "smokecigar",   canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },
    hoyodemonterrey = {         emote = "smokecigar",   canRun = false,     time = 11000, stress = math.random(10, 15), heal = 0, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = math.random(10, 15), canOD = false } },

    arturofuente = {            emote = "smokecigar",   canRun = false,     time = 11000, stress = 0, heal = 10, armor = 10, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = 0, canOD = false } },
    cohiba = {                  emote = "smokecigar",   canRun = false,     time = 11000, stress = 0, heal = 0, armor = 10, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = 0, canOD = false } },
    romeoyjulieta = {           emote = "smokecigar",   canRun = false,     time = 11000, stress = 0, heal = 10, armor = 0, type = "smoke", requiredItem = "lighter", stats = { effect = "stress", time = 5000, amount = 0, canOD = false } },

    dusche = { 			        emote = "beer", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    vodka = { 			        emote = "vodkab", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    cherenkov1 = { 		        emote = "cherenkov1", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    cherenkov2 = { 		        emote = "cherenkov2", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    cherenkov3 = { 		        emote = "cherenkov3", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    cherenkov4 = { 		        emote = "cherenkov4", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    bleuterdchampagne = {       emote = "bleuturd", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    bourgeoixcognac = {         emote = "bourgeoix", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    cardiaquecognac = {         emote = "cardiaque", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    red_wine = {                emote = "wine",         canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    white_wine = {              emote = "wine",         canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    raggaerum = {               emote = "raggae", 	    canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "alcohol", stats = { effect = "stress", time = 5000, amount = 2, thirst = math.random(10,20), canOD = true }},
    beer = { 			        emote = "beer", 		canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
    whiskey = { 		        emote = "whiskey",  	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
    godfather = {               emote = "whiskey",      canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
    godmother = {               emote = "whiskey",      canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
    oldfashion = {              emote = "whiskey",      canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},
    nightfall_negroni = {       emote = "whiskey",  	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "alcohol", stats = { thirst = math.random(10,20), canOD = true }},

    sandwich = {                emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = 20, }},
    butter = {                  emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = 20, }},
    bar_nuts = {                emote = "sandwich",     canRun = false,     time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = 20, }},
    slim_johns = {              emote = "sandwich",     canRun = false,     time = math.random(5000, 6000), stress = math.random(5, 10), heal = 0, armor = 0, type = "food", stats = { hunger = 20, }},
    twerks_candy = {            emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    snikkel_candy = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    meteoritebar = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    zebrabar = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    egochaser = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    psandqs = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    lollipop_blue = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    lollipop_yellow = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    lollipop_pink = {           emote = "egobar", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},

    coffee = {                  emote = "coffee", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { time = 10000, thirst = math.random(10,15), }},
    watermelon_slices = {       emote = "orange",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,35), }, },
    pineapple_slices = {        emote = "orange",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,35), }, },
    applejuice = {              emote = "drink",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20),}, },
    orangejuice = {             emote = "drink",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }, },
    peachjuice = {              emote = "drink",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }, },
    -- prisonslushie = {              emote = "drink",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }, },
    water_bottle = {            emote = "drink", 		canRun = false, 	time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "drink", stats = { thirst = 20, }},
    tosti = {                   emote = "sandwich", 	canRun = false, 	time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(10,15), }},
    apple = {                   emote = "apple", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},
    mkecola = {                 emote = "ecola",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }},
    mkecolalight = {            emote = "ecola",        canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }},
    mksprunk = {                emote = "sprunk",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }},
    mksprunklight = {           emote = "sprunk",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(15,20), }},

    munchables_pizza = {        emote = "sandwich", 	canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = 20, }},
    milk = {                    emote = "milk",         canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,15), }},
    chocolate_milk = {          emote = "milk",         canRun = false,     time = math.random(5000, 6000), stress = math.random(4, 6), heal = 0, armor = 0, type = "drink", stats = { thirst = math.random(10,16), }},
    banana = {                  emote = "banana", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},
    avacado = {                 emote = "avacado", 	    canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},
    orange = {                  emote = "orange", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},
    carrot = {                  emote = "carrot", 		canRun = true, 		time = math.random(5000, 6000), stress = 0, heal = 0, armor = 0, type = "food", stats = { hunger = math.random(5,10), }},

    -- Cigarette Packs
    redwood_pack = {            emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "redwood_cigarette", amount = 20 }, },
    debonaire_pack = {          emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "debonaire_cigarette", amount = 20 }, },
    estancia_pack = {           emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "estancia_cigar", amount = 5 }, },

    -- Cigarette Cartons
    redwood_carton = {          emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "redwood_pack", amount = 10 }, },
    debonaire_carton = {        emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "debonaire_pack", amount = 10 }, },
    estancia_carton = {         emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "estancia_pack", amount = 10 }, },

    foodration = {              emote = "egobar",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(15,20), }, },
    mre = {                     emote = "hotdog",       canRun = false,     time = math.random(5000, 6000), stress = math.random(2, 4), heal = 0, armor = 0, type = "food", stats = { hunger = math.random(25,35), }, },

    -- Ammo boxes
    ["9_box"] = {               emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "9_ammo", amount = 20 }, },
    ["12_box"] = {              emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "12_ammo", amount = 10 }, },
    ["380_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "380_ammo", amount = 20 }, },
    ["38_box"] = {              emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "38_ammo", amount = 20 }, },
    ["308_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "308_ammo", amount = 20 }, },
    ["357_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "357_ammo", amount = 20 }, },
    ["45_box"] = {              emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "45_ammo", amount = 20 }, },
    ["545_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "545_ammo", amount = 20 }, },
    ["556_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "556_ammo", amount = 20 }, },
    ["762_box"] = {             emote = "uncuff",       canRun = true,      time = 3500, type = "pack", pack = { item = "762_ammo", amount = 20 }, },

    --[[ --Testing effects & armor with small functionality to drugs - This may be another one left to default scripts
    joint = { 			emote = "smoke3",	time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { screen = "weed", effect = "armor", widepupils = false, canOD = false } },

    cokebaggy = { 		emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { screen = "focus", effect = "stamina", widepupils = false, canOD = true } },
    --crackbaggy = { 		emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { effect = "heal", widepupils = false, canOD = true } },
    xtcbaggy = { 		emote = "oxy",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { effect = "strength", widepupils = true, canOD = true } },
    oxy = { 			emote = "oxy",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 0, type = "drug", stats = { effect = "heal", widepupils = false, canOD = false } },
    meth = { 			emote = "coke",		time = math.random(5000, 6000), stress = math.random(12, 24), heal = 0, armor = 10, type = "drug", stats = { effect = "stamina", widepupils = false, canOD = true } },
    ]]		----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --[[Example item
    heartstopper = {
        emote = "burger", 							-- Select an emote from below, it has to be in here
        time = math.random(5000, 6000),				-- Amount of time it takes to consume the item
        stress = math.random(1,2),					-- Amount of stress relief, can be 0
        heal = 0, 									-- Set amount to heal by after consuming
        armor = 5,									-- Amount of armor to add
        type = "food",								-- Type: "alcohol" / "drink" / "food"

        stats = {
            screen = "thermal",						-- The screen effect to be played when after consuming the item "rampage" "turbo" "focus" "weed" "trevor" "nightvision" "thermal"
            effect = "heal", 						-- The status effect given by the item, "heal" / "stamina"
                                                    -- This supports ps-buffs effects "armor" "stress" "swimming" "hacking" "intelligence" "luck" "strength"
            time = 10000,							-- How long the effect should last (if not added it will default to 10000)
            amount = 6,								-- How much the value is changed by per second
            hunger = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
            thirst = math.random(10, 20),			-- The hunger/thirst stats of the item, if not found in the items.lua
        },
        --Reward Items Variables
                                                    -- These can be the only thing in a consumable table and the item will still work
        amounttogive = 3,							-- Used for "RewardItems", tells the script how many to give
        rewards = {
            [1] = {
                item = "plastic", 					-- prize item name
                max = 10,							-- max amount to give (this is put into math.random(1, max) )
                rarity = 1,							-- the rarity system, 1 being rarest, 4 being most common
            },
        },
    },]]
}