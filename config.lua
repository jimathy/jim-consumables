print("Jim-Consumables v1.0 - Consumables Script by Jimathy")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/xKgQZ6wZvS

Config = {}

Config.Debug = false  -- false to remove green boxes

Config.Consumables = {
	--Normal Drinks
	["cranberry"] = { 		emote = "wine", 	stress = true, type = "drink", },
	["pinejuice"] = { 		emote = "coffee", 	stress = true, type = "drink", },
	
	-- Default QB food item override
	["vodka"] = { 			emote = "vodkab", 	stress = true, type = "alcohol", },
	["beer"] = { 			emote = "beer", 	stress = true, type = "alcohol", },
	["whiskey"] = { 		emote = "whiskey", 	stress = true, type = "alcohol", },
	
	["sandwich"] = { 		emote = "sandwich", stress = true, type = "food", },
	["twerks_candy"] = { 	emote = "egobar", 	stress = true, type = "food", },
	["snikkel_candy"] = { 	emote = "egobar", 	stress = true, type = "food", },
	["tosti"] = { 			emote = "sandwich", stress = true, type = "food", },
	
	["coffee"] = { 			emote = "coffee", 	stress = true, type = "drink", },
	["water_bottle"] = { 	emote = "drink", 	stress = true, type = "drink", },
	["kurkakola"] = { 		emote = "ecola", 	stress = true, type = "drink", },
	
--[[ Not working yet
	--Drugs
	["cokebaggy"] = {		emote = "coke", 	stress = true, type = "drug", effect = { armor = false, health = false, stamina = false, widepupils = false, canOD = true, screen = 1 } },
	["crackbaggy"] = {		emote = "coke", 	stress = true, type = "drug", effect = { armor = false, health = false, stamina = false, widepupils = false, canOD = true, screen = 1  } },
	["xtcbaggy"] = {		emote = "oxy", 		stress = true, type = "drug", effect = { armor = false, health = false, stamina = true, widepupils = false, canOD = true, screen = 1  } },
	["oxy"] = {				emote = "oxy", 		stress = true, type = "drug", effect = { armor = false, health = true,  stamina = false, widepupils = false, canOD = false, screen = 1  } },
	["meth"] = {			emote = "coke", 	stress = true, type = "drug", effect = { armor = false, health = false, stamina = true, widepupils = false, canOD = true, screen = 1  } },
	["joint"] = {			emote = "joint", 	stress = true, type = "drug", effect = { armor = true, health = false, stamina = false, widepupils = false, canOD = true, screen = 1  } },
]]
}

Config.Emotes = {
   ["whiskeyb"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Whiskey Bottle", AnimationOptions =
   {    Prop = "prop_cs_whiskey_bottle", PropBone = 60309, PropPlacement = {0.08, 0.0, 0.05, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["rumb"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Rum Bottle", AnimationOptions =
   {    Prop = "prop_rum_bottle", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["icream"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Irish Cream Bottle", AnimationOptions =
   {    Prop = "prop_bottle_brandy", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["ginb"] =  {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Gin Bottle", AnimationOptions =
   {    Prop = "prop_tequila_bottle", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["vodkab"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Vodka Bottle", AnimationOptions =
   {   Prop = 'prop_vodka_bottle', PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }},      
   ["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Chrisps", AnimationOptions =
   {   Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
       EmoteLoop = true, EmoteMoving = true, }}, 
   ["beer1"] = {"mp_player_intdrink", "loop_bottle", "Dusche", AnimationOptions =
   {    Prop = "prop_beerdusche", PropBone = 18905, PropPlacement = {0.04, -0.14, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer2"] = {"mp_player_intdrink", "loop_bottle", "Logger", AnimationOptions =
   {    Prop = "prop_beer_logopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["beer3"] = {"mp_player_intdrink", "loop_bottle", "AM Beer", AnimationOptions =
   {    Prop = "prop_beer_amopen", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["beer4"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser1", AnimationOptions =
   {    Prop = "prop_beer_pissh", PropBone = 18905, PropPlacement = {0.03, -0.18, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
   ["beer5"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser2", AnimationOptions =
   {    Prop = "prop_amb_beer_bottle", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},  
   ["beer6"] = {"mp_player_intdrink", "loop_bottle", "Pisswasser3", AnimationOptions =
   {    Prop = "prop_cs_beer_bot_02", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["ecola"] = {"mp_player_intdrink", "loop_bottle", "E-cola", AnimationOptions =
   {    Prop = "prop_ecola_can", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["sprunk"] = {"mp_player_intdrink", "loop_bottle", "Sprunk", AnimationOptions =
   {    Prop = "v_res_tt_can03", PropBone = 18905, PropPlacement = {0.12, 0.008, 0.03, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},
	
	--Jim-BeanMachine
	["bmcoffee1"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee2", AnimationOptions =
	{ Prop = 'prop_fib_coffee', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
	   EmoteLoop = true, EmoteMoving = true, }},   
	   
	["bmcoffee2"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee3", AnimationOptions =
	{ Prop = 'ng_proc_coffee_01a', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.06, 0.0, 0.0, 0.0},
	   EmoteLoop = true, EmoteMoving = true, }},
	   	
	["bmcoffee3"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee3", AnimationOptions =
	{ Prop = 'v_club_vu_coffeecup', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.06, 0.0, 0.0, 0.0},
	   EmoteLoop = true, EmoteMoving = true, }},
	   
	--Jim-PizzaThis
   ["redwine"] = {"mp_player_intdrink", "loop_bottle", "Red Wine Bottle", AnimationOptions =
   {    Prop = "prop_wine_rose", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["whitewine"] = {"mp_player_intdrink", "loop_bottle", "White Wine Bottle", AnimationOptions =
   {    Prop = "prop_wine_white", PropBone = 18905, PropPlacement = {0.00, -0.26, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},  
   ["pizza"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Pizza", AnimationOptions =
   {    Prop = "v_res_tt_pizzaplate", PropBone = 18905, PropPlacement = {0.20, 0.038, 0.051, 15.0, 155.0},
        EmoteMoving = true, EmoteLoop = true, }},      
   ["bowl"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "bowl", AnimationOptions =
   {    Prop = "h4_prop_h4_coke_plasticbowl_01", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
        EmoteMoving = true, EmoteLoop = true, }},     
   ["pineapple"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Pizza", AnimationOptions =
   {    Prop = "prop_pineapple", PropBone = 18905, PropPlacement = {0.10, 0.038, 0.03, 15.0, 50.0},
        EmoteMoving = true, EmoteLoop = true, }},     
   ["foodbowl"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "bowl", AnimationOptions =
   {    Prop = "prop_cs_bowl_01", PropBone = 28422, PropPlacement = {0.0, 0.0, 0.050, 0.0, 0.0, 0.0},
        EmoteMoving = true, EmoteLoop = true, }},   

	--Jim-BurgerShot
   ["milk"] = {"mp_player_intdrink", "loop_bottle", "Milk", AnimationOptions =
   {    Prop = "v_res_tt_milk", PropBone = 18905, PropPlacement = {0.10, 0.008, 0.07, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["bscoke"] = {"mp_player_intdrink", "loop_bottle", "BS Coke", AnimationOptions =
   {    Prop = "prop_food_bs_juice01", PropBone = 18905, PropPlacement = {0.04, -0.10, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["bscoffee"] = {"mp_player_intdrink", "loop_bottle", "BS Coffee", AnimationOptions =
   {    Prop = "prop_food_bs_coffee", PropBone = 18905, PropPlacement = {0.08, -0.10, 0.10, 240.0, -60.0},
        EmoteMoving = true, EmoteLoop = true, }},   
   ["glass"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Tall Glass", AnimationOptions =
   {   Prop = 'prop_wheat_grass_glass', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }}, 
		
   ["torpedo"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Torpedo", AnimationOptions =
   {    Prop = "prop_food_bs_burger2", PropBone = 18905, PropPlacement = {0.10, -0.07, 0.091, 15.0, 135.0},
        EmoteMoving = true, EmoteLoop = true, }},     
   ["bsfries"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", "Fries", AnimationOptions =
   {    Prop = "prop_food_bs_chips", PropBone = 18905, PropPlacement = {0.09, -0.06, 0.05, 300.0, 150.0},
        EmoteMoving = true, EmoteLoop = true, }},      		
   ["donut2"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut2", AnimationOptions =
   {   Prop = 'prop_donut_02', PropBone = 18905, PropPlacement = {0.13, 0.05, 0.02, -50.0, 100.0, 270.0},
       EmoteMoving = true, EmoteLoop = true, }},	
	   
	--Jim-CatCafe
   ["boba1"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Boba 1", AnimationOptions =
   {   Prop = 'denis3d_catcafe_boobaA', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},  
   ["boba2"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Boba 2", AnimationOptions =
   {   Prop = 'denis3d_catcafe_boobaB', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["boba3"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Boba 3", AnimationOptions =
   {   Prop = 'denis3d_catcafe_boobaC', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["boba4"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Boba 4", AnimationOptions =
   {   Prop = 'denis3d_catcafe_boobaD', PropBone = 28422, PropPlacement = {0.0, 0.0, -0.1, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }}, 
   ["mochi"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Mochi", AnimationOptions =
   {   Prop = 'denis3d_catcafe_plateD', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},
	   
	--Jim-Tequilala
   ["whiskeyb"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Whiskey Bottle", AnimationOptions =
   {    Prop = "prop_cs_whiskey_bottle", PropBone = 60309, PropPlacement = {0.08, 0.0, 0.05, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["rumb"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Rum Bottle", AnimationOptions =
   {    Prop = "prop_rum_bottle", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["icream"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Irish Cream Bottle", AnimationOptions =
   {    Prop = "prop_bottle_brandy", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["ginb"] =  {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Gin Bottle", AnimationOptions =
   {    Prop = "prop_tequila_bottle", PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }}, 
   ["vodkab"] = {"anim@amb@nightclub@mini@drinking@drinking_shots@ped_b@normal@", "glass_hold", "Vodka Bottle", AnimationOptions =
   {   Prop = 'prop_vodka_bottle', PropBone = 60309, PropPlacement = {-0.04, -0.18, 0.12, 240.0, -60.0}, 
	   EmoteMoving = true, EmoteLoop = true }},      
		
   ["browncup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Brown Cup", AnimationOptions =
   {   Prop = 'v_serv_bs_mug', PropBone = 28422, PropPlacement = {0.03, -0.02, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},
   
   ["crisps"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Crisps", AnimationOptions =
   {   Prop = 'v_ret_ml_chips2', PropBone = 28422, PropPlacement = {0.01, -0.05, -0.1, 0.0, 0.0, 90.0},
       EmoteLoop = true, EmoteMoving = true, }}, 
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", AnimationOptions =
   { Prop = 'prop_cs_ciggy_01', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}, 
   EmoteLoop = true, EmoteMoving = true, }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
   { Prop = 'prop_cs_ciggy_01', PropBone = 28422, PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true, EmoteMoving = true, }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cigar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["joint"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Joint", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["cig"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Cig", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["clean"] = {"timetable@floyd@clean_kitchen@base", "base", "Clean", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clean2"] = {"amb@world_human_maid_clean@", "base", "Clean 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
	["coke"] = { "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", "Coke",
		AnimationOptions = { EmoteLoop = true, EmoteMoving = true, }},
	["oxy"] = { "mp_suicide", "pill", "Oxy",
		AnimationOptions = { EmoteLoop = true, EmoteMoving = true, }},
}