Config = Config or {}

Config.Emotes = {
    drink = { "mp_player_intdrink", "loop_bottle", "Drink",                                     AnimationOptions = { Prop = "prop_ld_flow_bottle",      PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true, }},
    milk = {"mp_player_intdrink", "loop_bottle", "Glass of milk",                               AnimationOptions = { Prop = 'bzzz_farmprops_milk_a',    PropBone = 18905, PropPlacement = {-0.02, -0.04, 0.1, 34.0, 140.0, 224.0}, EmoteLoop = true, EmoteMoving = true, }},
    coffee = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee",                AnimationOptions = { Prop = 'p_amb_coffeecup_01',       PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0}, EmoteLoop = true, EmoteMoving = true }},
    burger = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger",	                AnimationOptions = { Prop = 'prop_cs_burger_01',        PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    beer = {"amb@world_human_drinking@beer@male@idle_a", "idle_c", "Beer",                      AnimationOptions = { Prop = 'prop_amb_beer_bottle',     PropBone = 28422, PropPlacement = {0.0,0.0,0.06,0.0,15.0,0.0}, EmoteLoop = true, EmoteMoving = true }},
    egobar = {"mp_player_inteat@burger", "mp_player_int_eat_burger","Ego Bar",                  AnimationOptions = { Prop = 'prop_choc_ego',            PropBone = 60309, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0}, EmoteMoving = true }},
    sandwich = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich",              AnimationOptions = { Prop = 'prop_sandwich_01',         PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    apple = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Apple",                    AnimationOptions = { Prop = 'idrp_apple_solo',          PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    avacado = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Avacado",                AnimationOptions = { Prop = 'idrp_avo_solo',            PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    banana = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Banana",                  AnimationOptions = { Prop = 'idrp_bana_solo',           PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    carrot = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Carrot",                  AnimationOptions = { Prop = 'idrp_carrot_single',       PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    orange = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Orange",                  AnimationOptions = { Prop = 'idrp_bana_solo',           PropBone = 18905, PropPlacement = {0.13,0.05,0.02,-50.0,16.0,60.0}, EmoteMoving = true }},
    smoke3 = { "amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3",                     AnimationOptions = { Prop = 'prop_cs_ciggy_01',         PropBone = 28422, PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0}, EmoteLoop = true, EmoteMoving = true }},
    whiskey = { "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey",             AnimationOptions = { Prop = 'prop_drink_whisky',        PropBone = 28422, PropPlacement = {0.01,-0.01,-0.06,0.0,0.0,0.0}, EmoteLoop = true, EmoteMoving = true } },
    vodkab = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",                  AnimationOptions = { Prop = 'prop_vodka_bottle',        PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    cherenkov1 = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",              AnimationOptions = { Prop = 'prop_cherenkov_01',        PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    cherenkov2 = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",              AnimationOptions = { Prop = 'prop_cherenkov_04',        PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    cherenkov3 = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",              AnimationOptions = { Prop = 'prop_cherenkov_03',        PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    cherenkov4 = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",              AnimationOptions = { Prop = 'prop_cherenkov_02',        PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    bleuturd = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",                AnimationOptions = { Prop = 'prop_champ_01b',           PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    bourgeoix = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",               AnimationOptions = { Prop = 'prop_bottle_cognac',       PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    cardiaque = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",               AnimationOptions = { Prop = 'prop_bottle_brandy',       PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    raggae = {"mp_player_intdrink", "loop_bottle", "(Don't Use) Vodka Bottle",                  AnimationOptions = { Prop = 'prop_rum_bottle',          PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true }},
    ecola = {"mp_player_intdrink", "loop_bottle", "E-cola",                                     AnimationOptions = { Prop = "prop_ecola_can",           PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true, }},
    crisps = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps",               AnimationOptions = { Prop = 'v_ret_ml_chips2',          PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0}, EmoteLoop = true, EmoteMoving = true, }},
    sprunk = {"mp_player_intdrink", "loop_bottle", "Sprunk",                                    AnimationOptions = { Prop = "v_res_tt_can03",           PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0}, EmoteMoving = true, EmoteLoop = true, }},
    wine = { "anim@heists@humane_labs@finale@keycards",	"ped_a_enter_loop",	"Wine",             AnimationOptions = { Prop = 'prop_drink_redwine',       PropBone = 18905, PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0}, EmoteMoving = true, EmoteLoop = true }},
    champagne = { "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne",   AnimationOptions = { Prop = 'prop_drink_champ',         PropBone = 18905, PropPlacement = { 0.10, -0.03, 0.03, -100.0, 0.0, -10.0 }, EmoteMoving = true, EmoteLoop = true }},
    croissant = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Croissant",           AnimationOptions = { Prop = 'bzzz_foodpack_croissant001', PropBone = 60309, PropPlacement = { 0.00, 0.0, -0.01, 0.0, 0.0, 90.0 }, EmoteMoving = true }},
    cup = { "amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup",                     AnimationOptions = { Prop = 'prop_plastic_cup_02',      PropBone = 28422, PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    desert = { "mp_player_inteat@burger", "mp_player_int_eat_burger","Eat dessert",             AnimationOptions = { Prop = 'bzzz_food_dessert_a',      PropBone = 18905, PropPlacement = { 0.15, 0.03, 0.03, -42.0, -36.0, 0.0 }, EmoteMoving = true}},
    dinner = { "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Dinner", AnimationOptions = { Prop = "prop_cs_plate_01", PropBone = 60309, PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0 }, SecondProp = 'h4_prop_h4_caviar_spoon_01a', SecondPropBone = 28422, SecondPropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    flute = { "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute",           AnimationOptions = { Prop = 'prop_champ_flute',         PropBone = 18905, PropPlacement = { 0.10, -0.03, 0.03, -100.0, 0.0, -10.0 }, EmoteMoving = true, EmoteLoop = true }},
    frappe = { "amb@code_human_wander_drinking@male@base", "static", "Frappe",                  AnimationOptions = { Prop = 'brum_heartfrappe',         PropBone = 28422, PropPlacement = { 0.0, -0.0150, -0.0100, 0.0, -3.9999, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    frappe2 = { "amb@code_human_wander_drinking@female@base", "static", "Frappe 2",             AnimationOptions = { Prop = 'beanmachine_cup',          PropBone = 28422, PropPlacement = { 0.0110, 0.0, 0.0300, 0.0, 0.0, -140.0 }, EmoteLoop = true, EmoteMoving = true }},
    frappe3 = { "amb@code_human_wander_drinking@female@base", "static", "Frappe 3",             AnimationOptions = { Prop = 'beanmachine_cup2',         PropBone = 28422, PropPlacement = { 0.0, 0.0, -0.0600, 0.0, 0.0, -178.0 }, EmoteLoop = true, EmoteMoving = true }},
    frappe4 = { "amb@code_human_wander_drinking@female@base", "static", "Frappe 4",             AnimationOptions = { Prop = 'beanmachine_cup3',         PropBone = 28422, PropPlacement = { 0.0, 0.0, -0.0600, 0.0, 0.0, -178.0 }, EmoteLoop = true, EmoteMoving = true }},
    hotdog = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Hotdog",                 AnimationOptions = { Prop = 'prop_cs_hotdog_02',        PropBone = 60309, PropPlacement = { -0.0300, 0.0100, -0.0100, 95.1071, 94.7001, -66.9179 }, EmoteMoving = true }},
    icecreama = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Cherry",    AnimationOptions = { Prop = 'bzzz_icecream_cherry',     PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamb = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Chocolate", AnimationOptions = { Prop = 'bzzz_icecream_chocolate',  PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamc = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Lemon",     AnimationOptions = { Prop = 'bzzz_icecream_lemon',      PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamd = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Pistachio", AnimationOptions = { Prop = 'bzzz_icecream_pistachio',  PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreame = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Raspberry", AnimationOptions = { Prop = 'bzzz_icecream_raspberry',  PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamf = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Stracciatella", AnimationOptions = { Prop = 'bzzz_icecream_stracciatella', PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamg = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Strawberry", AnimationOptions = { Prop = 'bzzz_icecream_strawberry', PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    icecreamh = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Ice cream Walnut",    AnimationOptions = { Prop = 'bzzz_icecream_walnut',     PropBone = 18905, PropPlacement = { 0.14, 0.03, 0.01, 85.0, 70.0, -203.0 }, EmoteMoving = true }},
    macaroon = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Macaroon",             AnimationOptions = { Prop = 'bzzz_food_xmas_macaroon_a', PropBone = 18905, PropPlacement = { 0.15, 0.07, 0.00, 38.0, 7.0, 7.0 }, EmoteMoving = true }},
    sipshake = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Bubblegum",      AnimationOptions = { Prop = 'brum_cherryshake_raspberry', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakeb = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Cherry",        AnimationOptions = { Prop = 'brum_cherryshake_cherry',  PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakec = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Chocolate",     AnimationOptions = { Prop = 'brum_cherryshake_chocolate', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshaked = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Coffee",        AnimationOptions = { Prop = 'brum_cherryshake_coffee',  PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakee = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Double Chocolate", AnimationOptions = { Prop = 'brum_cherryshake_doublechocolate', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakef = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Frappe",        AnimationOptions = { Prop = 'brum_cherryshake_frappe', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakeg = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Lemon",         AnimationOptions = { Prop = 'brum_cherryshake_lemon', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakeh = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Mint",          AnimationOptions = { Prop = 'brum_cherryshake_mint', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakei = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Strawberry",    AnimationOptions = { Prop = 'brum_cherryshake_strawberry', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakej = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Raspberry",     AnimationOptions = { Prop = 'brum_cherryshake_raspberry', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakek = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Salted",        AnimationOptions = { Prop = 'brum_cherryshake_salted', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    sipshakel = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Milkshake - Vanilla",       AnimationOptions = { Prop = 'brum_cherryshake_vanilla', PropBone = 28422, PropPlacement = { 0.0850, 0.0670, -0.0350, -115.0862, -165.7841, 24.1318 }, EmoteLoop = true, EmoteMoving = true }},
    pizzaslice = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Jalapeño And Peperoni", AnimationOptions = { Prop = 'knjgh_pizzaslice1', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    pizzas = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Jalapeño And Peperoni", AnimationOptions = { Prop = 'knjgh_pizzaslice1', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    pizzas2 = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Tomato And Pesto", AnimationOptions = { Prop = 'knjgh_pizzaslice2', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    pizzas3 = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Mushroom", AnimationOptions = { Prop = 'knjgh_pizzaslice3', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    pizzas4 = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Margherita", AnimationOptions = { Prop = 'knjgh_pizzaslice4', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    pizzas5 = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Pizza Slice - Double Peperoni", AnimationOptions = { Prop = 'knjgh_pizzaslice5', PropBone = 60309, PropPlacement = { 0.0500, -0.0200, -0.0200, 73.6928, -66.7427, 68.3677 }, EmoteMoving = true }},
    popcorn = { "amb@code_human_wander_drinking@female@base", "static", "Popcorn",              AnimationOptions = { Prop = 'prop_taymckenzienz_popcorn', PropBone = 28422, PropPlacement = { -0.0200, -0.0100, -0.0700, -179.3626, 176.9331, 11.9833 }, EmoteLoop = true, EmoteMoving = true }},
    sipsoda = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Soda Cup - Sprunk",           AnimationOptions = { Prop = 'prop_rpemotes_soda01', PropBone = 28422, PropPlacement = { 0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898 }, EmoteLoop = true, EmoteMoving = true }},
    sipsodab = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Soda Cup - Sprunk Light",    AnimationOptions = { Prop = 'prop_rpemotes_soda02', PropBone = 28422, PropPlacement = { 0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898 }, EmoteLoop = true, EmoteMoving = true }},
    sipsodac = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Soda Cup - eCola",           AnimationOptions = { Prop = 'prop_rpemotes_soda03', PropBone = 28422, PropPlacement = { 0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898 }, EmoteLoop = true, EmoteMoving = true }},
    sipsodad = { "smo@milkshake_idle", "milkshake_idle_clip", "Sip Soda Cup - eCola Light",     AnimationOptions = { Prop = 'prop_rpemotes_soda04', PropBone = 28422, PropPlacement = { 0.0470, 0.0040, -0.0600, -88.0263, -25.0367, -27.3898 }, EmoteLoop = true, EmoteMoving = true }},
    taco = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Taco",                     AnimationOptions = { Prop = 'prop_taco_01', PropBone = 60309, PropPlacement = { -0.0170, 0.0070, -0.0210, 107.9846, -105.0251, 55.7779 }, EmoteMoving = true }},
    xmascc = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Xmas Cupcake",           AnimationOptions = { Prop = 'pata_christmasfood6', PropBone = 60309, PropPlacement = { 0.0100, 0.0200, -0.0100, -170.1788, 87.6716, 30.0540 }, EmoteMoving = true }},
    xmascc2 = { "mp_player_inteat@burger", "mp_player_int_eat_burger", "Xmas Cupcake 2",        AnimationOptions = { Prop = 'pata_christmasfood8', PropBone = 60309, PropPlacement = { 0.0200, 0.0, -0.0100, 9.3608, -90.1809, 66.3689 }, EmoteMoving = true }},
    xmasic = { "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", "base_idle", "Xmas Ice Cream", AnimationOptions = { Prop = "pata_christmasfood7", PropBone = 60309, PropPlacement = { -0.0460, 0.0000, -0.0300, 0.0, 0.0, -50.0000 }, SecondProp = 'h4_prop_h4_coke_spoon_01', SecondPropBone = 28422, SecondPropPlacement = { 0.0, 0.0, 0.0, 0.0, 20.0, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    xmaswine = { "mp_player_intdrink", "loop_bottle", "Xmas Mulled Wine",                       AnimationOptions = { Prop = 'bzzz_food_xmas_mulled_wine_a', PropBone = 18905, PropPlacement = { 0.13, 0.03, 0.05, -110.0, -47.0, 7.0 }, EmoteMoving = true }},
    cocoa = { "amb@world_human_aa_coffee@base", "base", "Xmas Cocoa",                           AnimationOptions = { Prop = 'pata_christmasfood1', PropBone = 28422, PropPlacement = { 0.0100, -0.1100, -0.1300, 0.0, 0.0, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    coke = { "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", "Coke",               AnimationOptions = { EmoteLoop = true, EmoteMoving = true }},
    oxy = { "mp_suicide", "pill", "Oxy",                                                        AnimationOptions = { EmoteLoop = true, EmoteMoving = true }},
    cigar = { "amb@world_human_smoking@male@male_a@enter", "enter", "Cigar",                    AnimationOptions = { Prop = 'prop_cigar_02', PropBone = 47419, PropPlacement = { 0.010, 0.0, 0.0, 50.0, 0.0, -80.0 }, EmoteMoving = true, EmoteDuration = 2600 }},
    cigar2 = { "amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2",                 AnimationOptions = { Prop = 'prop_cigar_01', PropBone = 47419, PropPlacement = { 0.010, 0.0, 0.0, 50.0, 0.0, -80.0 }, EmoteMoving = true, EmoteDuration = 2600 }},
    joint = { "amb@world_human_smoking@male@male_a@enter", "enter", "Joint",                    AnimationOptions = { Prop = 'p_cs_joint_02', PropBone = 47419, PropPlacement = { 0.015, -0.009, 0.003, 55.0, 0.0, 110.0 }, EmoteMoving = true, EmoteDuration = 2600 }},
    cig = { "amb@world_human_smoking@male@male_a@enter", "enter", "Cig",                        AnimationOptions = { Prop = 'prop_amb_ciggy_01', PropBone = 47419, PropPlacement = { 0.015, -0.009, 0.003, 55.0, 0.0, 110.0 }, EmoteMoving = true, EmoteDuration = 2600 }},
    smoke2 = { "amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2",                     AnimationOptions = { Prop = 'prop_cs_ciggy_01', PropBone = 28422, PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 }, EmoteLoop = true, EmoteMoving = true }},
    smokecigar = { "amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke Cigar",             AnimationOptions = { Prop = 'prop_cigar_01', PropBone = 28422, PropPlacement = { 0.0, 0.0, 0.0, 0.0, 0.0, 180.0 }, EmoteLoop = true, EmoteMoving = true }},
    uncuff = { "mp_arresting", "a_uncuff", "Uncuff",                                            AnimationOptions = { EmoteLoop = true, EmoteMoving = true }},
}