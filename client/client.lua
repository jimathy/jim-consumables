local alcoholCount, drugCount, consuming, cancelled = 0, 0, false, false
Consumables, Emotes = {}, {}

local function syncConsumables()
    Consumables = triggerCallback(getScript()..":server:syncConsumables")
    Emotes = triggerCallback(getScript()..":server:syncEmotes")
    debugPrint("^5Debug^7: ^2Retrieved ^6"..countTable(Consumables).." ^2Items and ^6"..countTable(Emotes).." ^2Emotes^7")
end

RegisterNetEvent(getScript()..":client:syncConsumables", function(NewConsumables)
    if debugMode then
        for k, v in pairs(NewConsumables) do
            if not Consumables[k] then
                print("^5Debug^7: ^2New Item Info added^7: ^6"..k.."^7")
            end
        end
    end
    Consumables = NewConsumables
end)
RegisterNetEvent(getScript()..":client:syncEmotes", function(NewEmotes)
    if debugMode then
        for k, v in pairs(NewEmotes) do
            if not Emotes[k] then
                print("^5Debug^7: ^2New Emote Info added^7: ^6"..k.."^7")
            end
        end
    end
    Emotes = NewEmotes
end)

onPlayerLoaded(function()
    syncConsumables()
end, true)


RegisterNetEvent(getScript()..':Consume', function(itemName)
    if not hasItem(itemName, 1) then
        print("^5Debug^7: ^1Error^7: ^2Item not found in inventory^7, ^2stopping^7..")
    end
    local requiredItem = Consumables[itemName].requiredItem or nil

    if requiredItem then
        if not hasItem(requiredItem, 1) then
            triggerNotify(nil, "You need a "..Items[requiredItem].label, "error")
            return
        else
        --    if requiredItem == "lighter" then breakTool({ item = "lighter", damage = math.random(0, 1) }) end
        end
    end

    debugPrint("^5Debug^7: ^3Consume^7: ^2Starting event, locking inventory and grabbing data^7..")
    tempLockInv(true)
    local Player = PlayerPedId()
	local emote = Emotes[Consumables[itemName].emote] or Emotes["crisps"]
    if isAnimal then        --- Animal ped adjustments
        local presets = {
            ["default"] = {
                propPlacement = { 0.0, 0.25, -0.04, 0.0, 0.0, 0.0, },
                propPlacement2 = { 0.0, 0.25, -0.02, 0.0, 0.0, 0.0, }
            },
            [`a_c_rabbit_01`] = {
                propPlacement = { 0.0, 0.37, -0.15, 0.0, 0.0, 0.0, },
                propPlacement2 = { 0.0, 0.37, -0.13, 0.0, 0.0, 0.0, }
            },
            [`a_c_rat`] = {
                propPlacement = { 0.0, 0.25, -0.04, 0.0, 0.0, 0.0, },
                propPlacement2 = { 0.0, 0.25, -0.02, 0.0, 0.0, 0.0, }
            },
            [`a_c_crow`] = {
                propPlacement = { 0.0, 0.25, 0.02, 0.0, 0.0, 0.0, },
                propPlacement2 = { 0.0, 0.25, 0.04, 0.0, 0.0, 0.0, }
            },
        }

        local model = GetEntityModel(Player)
        local isCat = (isCat() or model == `ft-raccoon`) and (model ~= `ft-sphynx`)
        local isDog, bigDog = isDog()
        if isDog and model == `a_c_coyote` then isDog = false end
        local isCoyote = (model == `ft-sphynx` or model == `a_c_coyote`)
        if model == `ft-capmonkey2` then isDog = true end

        local propPlacement, propPlacement2 = { 0.0, 0.37, -0.19, 0.0, 0.0, 0.0, }, { 0.0, 0.37, -0.17, 0.0, 0.0, 0.0, }
        if isDog then
            if bigDog or isCoyote then
                propPlacement = { 0.0, 0.53, -0.39, 0.0, 0.0, 0.0, } propPlacement2 = { 0.0, 0.53, -0.37, 0.0, 0.0, 0.0, }
            else
                propPlacement = { 0.0, 0.33, -0.28, 0.0, 0.0, 0.0, } propPlacement2 = { 0.0, 0.33, -0.26, 0.0, 0.0, 0.0, }
            end
        end
        if not isCat and not isDog then
            propPlacement = presets[model] and presets[model].propPlacement or presets["default"].propPlacement
            propPlacement2 = presets[model] and presets[model].propPlacement2 or  presets["default"].propPlacement
        end

        emote = {
            "creatures@pug@move", "nill", "",
            AnimationOptions = {
                EmoteLoop = true,
                Prop = "v_res_tt_bowl",
                PropBone = 64081,
                PropPlacement = propPlacement,
                SecondProp = Emotes[Consumables[itemName].emote].AnimationOptions.Prop or nil,
                SecondPropBone = Emotes[Consumables[itemName].emote].AnimationOptions.Prop and 64081 or nil,
                SecondPropPlacement = Emotes[Consumables[itemName].emote].AnimationOptions.Prop and propPlacement2 or nil,
            },
        }
    end

    local returnItem = Consumables[itemName].returnItem or nil
	local animDict, anim = tostring(emote[1]), tostring(emote[2])
	local model, model2, bone, bone2, drugeffect, stress
	local P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12 = table.unpack({0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}) -- Default placement coord cariable
    local RewardItem = Consumables[itemName].rewards or nil
	local type = Consumables[itemName].type or ""
    local pack = Consumables[itemName].pack or nil
    local string = "Using "
    local notifType = ""
    local canRun = Consumables[itemName].canRun

    local time, stress, heal, armor, stats = GenerateRandomValues({
        time = Consumables[itemName].time or { 5000, 6000 },
        stress = Consumables[itemName].stress or 0,
        heal = Consumables[itemName].heal or 0,
        armor = Consumables[itemName].armor or 0,
        hunger = Consumables[itemName].stats and Consumables[itemName].stats.hunger or 0,
        thirst = Consumables[itemName].stats and Consumables[itemName].stats.thirst or 0,
    })
    if emote.AnimationOptions.Prop then
		model = emote.AnimationOptions.Prop
		bone = GetPedBoneIndex(Player, emote.AnimationOptions.PropBone)
		P1, P2, P3, P4, P5, P6 = table.unpack(emote.AnimationOptions.PropPlacement)
        if emote.AnimationOptions.SecondProp then
            model2 = emote.AnimationOptions.SecondProp
            bone2 = GetPedBoneIndex(Player, emote.AnimationOptions.SecondPropBone)
            P7, P8, P9, P10, P11, P12 = table.unpack(emote.AnimationOptions.SecondPropPlacement)
        end
	end
    if type == "drink" or type == "alcohol" then
        string = "Drinking "
        notifType = "drinking"
    elseif type == "food" then
        string = "Eating "
        notifType = "eating"
    elseif type == "smoke" then
        string = "Smoking "
        notifType = "smoking"
    elseif type == "pack" then
        string = "Opening "
        notifType = "package"
    else string = "Using "
        notifType = "using"
    end
	if consuming then
		cancelled = true
        debugPrint("^5Debug^7: ^3Consume^7: ^2Event already started^7, ^1Cancelling^7.")
        tempLockInv(false)
        if Config.UseProgbar then
            stopPropgressBar()
        else
            triggerNotify(nil, "Stopped "..string, "error")
        end
		consuming = not consuming
		return
	end
	--Emote Stuff
    debugPrint("^5Debug^7: ^3Consume^7: ^2Grabbing Emote Animation Options^7...")
    local InVehicle = IsPedInAnyVehicle(Player, true)
    debugPrint("^5Debug^7: ^3Consume^7: ^2Checking if player is in a vehicle^7 - ^6"..tostring(InVehicle).."^7")

    MovementType = 0 -- Default movement type

    if InVehicle == 1 then
        MovementType = 51
    elseif emote.AnimationOptions then
        if emote.AnimationOptions.EmoteMoving then
            MovementType = 51
        elseif emote.AnimationOptions.EmoteLoop then
            MovementType = 1
        elseif emote.AnimationOptions.EmoteStuck then
            MovementType = emote.AnimationOptions.EmoteMoving and 50 or 2
        elseif emote.AnimationOptions.EmoteMoving == false then
            MovementType = 0
        end

    end
	--Load and Start animation
    debugPrint("^5Debug^7: ^3Consume^7: ^2Playing Animation^7...")
	if not (GetPedType(Player) == 28)then
        playAnim(animDict, anim, -1, MovementType)
    end
    debugPrint("^5Debug^7: ^3Consume^7: ^2Player Movement Flag^7 - ^6"..json.encode(MovementType).." ^7")
    if Config.Main.UseProgbar then
        CreateThread(function()
            if progressBar({ time = time, label = string..Items[itemName].label.."..", dead = false, cancel = false}) then
                consuming = false
            else
            end
        end)
    else
        triggerNotify(nil, string..Items[itemName].label.."..",  notifType)
    end

	consuming = true
    CreateThread(function()
        --Prop Spawning
        if model then
            if IsModelValid(model) == 1 then
                debugPrint("^5Debug^7: ^3PropSpawn^7: ^2Spawning consumable prop^7...")
                attachProp = makeProp({ prop = model, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                AttachEntityToEntity(attachProp, Player, bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)
                if model2 then
                    if IsModelValid(model2) == 1 then
                        attachProp2 = makeProp({ prop = model2, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                        AttachEntityToEntity(attachProp2, Player, bone2, P7, P8, P9, P10, P11, P12, true, true, false, true, 1, true)
                    else print("^5Debug^7: ^3PropSpawn^7: ^2Second prop model isn't valid/found^7.") end
                end
                while consuming do Wait(50) end
                if DoesEntityExist(attachProp) then
                    destroyProp(attachProp)
                    attachProp = nil
                end
                if DoesEntityExist(attachProp2) then
                    destroyProp(attachProp2)
                    attachProp2 = nil
                 end
            else
                print("^5Debug^7: ^3PropSpawn^7: ^2Prop model isn't valid/found^7.")
            end
        end
    end)
	while consuming do
        local drawTable = debugMode and
        {   "[BackSpace] Stop Consuming",
            "Time: "..tostring(time),
            "Type: "..(type or ""),
            "Hunger: "..(stats.hunger or 0).."%",
            "Thirst: "..(stats.thirst or 0).."%",
            "Stress: "..(stress or 0).."%",
            "Heal: "..(heal or 0).."%",
            "Armour: "..(armor or 0).."%",
        } or
        { "[BackSpace] Stop Consuming", }
        drawText(nil, drawTable, nil, nil)
        if time <= 0 then
            consuming = false
        end
        if (IsControlJustPressed(0, 21) and not canRun) or IsPedRagdoll(Player) or IsControlJustPressed(0, 177) then
            consuming = false
            cancelled = true
            tempLockInv(false)
            hideText()
            if Config.Main.UseProgbar then
                stopPropgressBar()
            else
                triggerNotify(nil, "Cancelled "..string, "error")
            end
        end
        Wait(0)
        time -= 12
	end
	StopEntityAnim(Player, anim, animDict, 1.0)
    unloadAnimDict(animDict)
	if not cancelled then
        hideText()
        removeItem(itemName, 1)
        if returnItem ~= nil then
            currentToken = triggerCallback(AuthEvent)
            addItem(returnItem.item, returnItem.amount)
        end

        -- Reward Item calculations
        CreateThread(function()
            if RewardItem then
                for i = 1, Consumables[itemName].amounttogive do
                    local rarity = math.random(1, 4) -- rarity calculation
                    while true do
                        local item = math.random(1, countTable(RewardItem)) -- random item in the list to pick
                        if RewardItem[item].rarity >= rarity then
                            currentToken = triggerCallback(AuthEvent)
                            addItem(RewardItem[item].item, math.random(1, RewardItem[item].max or 1))
                            debugPrint("^5Debug^7: ^2Given reward prize^7: '^6"..RewardItem[item].item.."^7'")
                            break
                        end
                        Wait(100)
                    end
                    Wait(1500)
                end
            end
        end)
        if stats then
            if stats.hunger then
                --stats.hunger = math.random(stats.hunger - 5, stats.hunger + 5)
                TriggerServerEvent(getScript()..":server:addNeed", Core.Functions.GetPlayerData().metadata["hunger"] + stats.hunger, "hunger")
            end
            if stats.thirst then
                --stats.thirst = math.random(stats.thirst - 5, stats.thirst + 5)
                TriggerServerEvent(getScript()..":server:addNeed", Core.Functions.GetPlayerData().metadata["thirst"] + stats.thirst, "thirst")
            end
        end
        debugPrint("^5Debug^7: ^2Hunger^7: [^6"..(stats.hunger or 0).."^7] ^2Thrist^7: [^6"..(stats.thirst or 0).."^7]" )
        if stress and stress ~= 0 then
            debugPrint("^5Debug^7: ^3Consume^7: ^2Relieving ^6"..stress.." ^2stress^7.")
            TriggerServerEvent('hud:server:RelieveStress', stress)
        end
		if heal and heal ~= 0 then
            debugPrint("^5Debug^7: ^3Consume^7: ^2Healing player by^7: ^6"..heal)
            SetEntityHealth(Player, GetEntityHealth(Player) + heal)
        end
		if armor and armor ~= 0 then
            debugPrint("^5Debug^7: ^3Consume^7: ^2Adding ^6"..armor.." ^2armour^7.")
            TriggerServerEvent('hospital:server:SetArmor', (GetPedArmour(Player) + armor)) SetPedArmour(Player, (GetPedArmour(Player) + armor))
        end
		if type == "alcohol" then
			alcoholCount += 1
            debugPrint("^5Debug^7: ^3Consume^7: ^2Current ^4alcoholCount^7: ^6"..alcoholCount)
			if alcoholCount > 1 and alcoholCount < 4 then
				TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
			elseif alcoholCount >= 4 then
				TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
                CreateThread(function() AlienEffect() end) -- Used as overdosing/too drunk effect
            end
        end
        if pack then
            currentToken = triggerCallback(AuthEvent)
            addItem(pack.item, pack.amount)
        end
        if stats then
            if stats.screen then -- Screen effect activation
                if stats.screen == "turbo" then
                    CreateThread(function() TurboEffect() end)
                end
                if stats.screen == "focus" then
                    CreateThread(function() FocusEffect() end)
                end
                if stats.screen == "rampage" then
                    CreateThread(function() RampageEffect() end)
                end
                if stats.screen == "weed" then
                    CreateThread(function() WeedEffect() end)
                end
                if stats.screen == "trevor" then
                    CreateThread(function() TrevorEffect() end)
                end
                if stats.screen == "nightvision" then
                    CreateThread(function() NightVisionEffect() end)
                end
                if stats.screen == "thermal" then
                    CreateThread(function() ThermalEffect() end)
                end
            end
			if stats.canOD then
				drugCount += 1
                debugPrint("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..drugCount)
				if drugCount >= 4 then
                    debugPrint("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..drugCount.."^7 - ^2 removing health")
					SetEntityHealth(PlayerPedId(), GetEntityHealth(Player) - math.random(10, 15))
					if drugCount >= 7 then
                        CreateThread(function() AlienEffect() end) -- If too many drugs, if not dead will make you stumble
					end
				end
			end
			if stats.effect == "heal" then
                if isStarted("ps-buffs") then
                    debugPrint("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6Health Buff ^2for ^6"..stats.time.."^7ms")
                    exports["ps-buffs"]:AddHealthBuff((tonumber(stats.time) or 10000), (stats.amount or 6))
                else
                    CreateThread(function()
                        HealEffect({(tonumber(stats.time) or 10000), (stats.amount or 6)})
                    end)
                end
            end
			if stats.effect == "stamina" then
                if isStarted("ps-buffs") then
                    debugPrint("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6Stamina Buff ^2for ^6"..stats.time.."^7ms")
                    exports["ps-buffs"]:StaminaBuffEffect((tonumber(stats.time) or 10000), (stats.amount or 6))
                else CreateThread(function() StaminaEffect({(tonumber(stats.time) or 10000), (stats.amount or 6)}) end) end
			end
            if isStarted("ps-buffs") then   --PS-BUFFS ONLY
                if stats.effect then debugPrint("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6"..stats.effect.." Buff ^2for ^6"..(stats.time or "nil").."^7ms") end
                if stats.effect == "armor" then exports["ps-buffs"]:AddArmorBuff((tonumber(stats.time) or 10000), (stats.amount or 6)) end
                if stats.effect == "stress" then exports["ps-buffs"]:AddStressBuff((tonumber(stats.time) or 10000), (stats.amount or 6)) end
                if stats.effect == "swimming" then exports["ps-buffs"]:SwimmingBuffEffect((tonumber(stats.time) or 10000), (stats.amount or 6)) end
                if stats.effect == "hacking" then exports["ps-buffs"]:AddBuff("hacking", (tonumber(stats.time) or 10000)) end
                if stats.effect == "intelligence" then exports["ps-buffs"]:AddBuff("intelligence", (tonumber(stats.time) or 10000)) end
                if stats.effect == "luck" then exports["ps-buffs"]:AddBuff("luck", (tonumber(stats.time) or 10000)) end
                if stats.effect == "strength" then exports["ps-buffs"]:AddBuff("strength", (tonumber(stats.time) or 10000)) end
            end
            if stats.widepupils then TriggerEvent("evidence:client:SetStatus", "widepupils", 200) end
		end
	end
	cancelled = false
	consuming = false
    debugPrint("^5Debug^7: ^3Consume^7: ^2Finished, unlocking inventory^7...")
    tempLockInv(false)
end)

CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then Wait(1000 * 60 * 15) alcoholCount -= 1 else Wait(1000) end
        if drugCount > 0 then Wait(1000 * 60 * 15) drugCount -= 1 else Wait(1000) end
	end
end)

onResourceStop(function()
    lockInv(false)

    StopEffects()
end, true)