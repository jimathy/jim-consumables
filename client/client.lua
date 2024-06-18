local QBCore = exports[Config.Core]:GetCoreObject()

local alcoholCount, drugCount, consuming, cancelled = 0, 0, false, false
local Consumables, Emotes = {}, {}

local function propConvert() --Convert Prop Model Names to Model HashKeys now to be more optimized when loading later
    for k in pairs(Emotes) do
        if Emotes[k].AnimationOptions.Prop then
            Emotes[k].AnimationOptions.Prop = GetHashKey(Emotes[k].AnimationOptions.Prop)
            if Emotes[k].AnimationOptions.SecondProp then
                Emotes[k].AnimationOptions.SecondProp = GetHashKey(Emotes[k].AnimationOptions.SecondProp)
            end
        end
    end
end

local function syncConsumables()
	local p = promise.new() QBCore.Functions.TriggerCallback('jim-consumables:server:syncConsumables', function(cb) p:resolve(cb) end) Consumables = Citizen.Await(p)
	local p2 = promise.new() QBCore.Functions.TriggerCallback('jim-consumables:server:syncEmotes', function(cb) p2:resolve(cb) end) Emotes = Citizen.Await(p2)
    if Config.Debug then print("^5Debug^7: ^2Retrieved ^6"..countTable(Consumables).." ^2Items and ^6"..countTable(Emotes).." ^2Emotes^7") end
    propConvert()
end

RegisterNetEvent("jim-consumables:client:syncConsumables", function(NewConsumables)
    if Config.Debug then for k, v in pairs(NewConsumables) do if not Consumables[k] then print("^5Debug^7: ^2New Item Info added^7: ^6"..k.."^7") end end end
    Consumables = NewConsumables
end)
RegisterNetEvent("jim-consumables:client:syncEmotes", function(NewEmotes)
    if Config.Debug then for k, v in pairs(NewEmotes) do if not Emotes[k] then print("^5Debug^7: ^2New Emote Info added^7: ^6"..k.."^7") end end end
    Emotes = NewEmotes
    propConvert()
end)

AddEventHandler('onResourceStart', function(r) if GetCurrentResourceName() ~= r then return end syncConsumables() end)
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() syncConsumables() end)

RegisterNetEvent('jim-consumables:Consume', function(itemName)
    if not HasItem(itemName, 1) then print("^5Debug^7: ^1Error^7: ^2Item not found in inventory^7, ^2stopping^7..") end
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Starting event, locking inventory and grabbing data^7..") end
    LocalPlayer.state:set("inv_busy", true, true) TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
	local Player = PlayerPedId()
	local emote = Emotes[Consumables[itemName].emote] or Emotes["crisps"]
    local returnItem = Consumables[itemName].returnItem or nil
	local animDict, anim = tostring(emote[1]), tostring(emote[2])
	local model, model2, bone, bone2, drugeffect, stress
	local P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12 = table.unpack({0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}) -- Default placement coord cariable
    local RewardItem = Consumables[itemName].rewards or nil
	local time = Consumables[itemName].time or math.random(5000, 6000)
	local type = Consumables[itemName].type or ""
	local stress = Consumables[itemName].stress or 0
	local heal = Consumables[itemName].heal or 0
	local armor = Consumables[itemName].armor or 0
    local stats = Consumables[itemName].stats or nil
    local string = "Using "
    local canRun = Consumables[itemName].canRun
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
    if type == "drink" or type == "alcohol" then string = "Drinking "
    elseif type == "food" then string = "Eating "
    else string = "Using " end
	if consuming then
		cancelled = true
        if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Event already started^7, ^1Cancelling^7.") end
        LocalPlayer.state:set("inv_busy", false, true)
        if Config.UseProgbar then
            if Config.ProgressBar == "ox" then exports.ox_lib:cancelProgress()
            else TriggerEvent("progressbar:client:cancel") end
        else
            triggerNotify(nil, "Stopped "..string, "error")
        end
		consuming = not consuming
		return
	end
	--Emote Stuff
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Grabbing Emote Animation Options^7...") end
    local InVehicle = IsPedInAnyVehicle(Player, true)
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Checking if player is in a vehicle^7 - ^6"..tostring(InVehicle).."^7") end
	if InVehicle == 1 then MovementType = 51
    elseif emote.AnimationOptions then
		if emote.AnimationOptions.EmoteMoving then MovementType = 51
        elseif emote.AnimationOptions.EmoteLoop then MovementType = 1
		elseif emote.AnimationOptions.EmoteStuck then MovementType = 50
        elseif emote.AnimationOptions.EmoteMoving == false then	MovementType = 0 end
	end
	--Load and Start animation
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Playing Animation^7...") end
	loadAnimDict(animDict)
	TaskPlayAnim(Player, animDict, anim, 1.0, 1.0, -1, MovementType, 0, 0, 0, 0)
	if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Player Movement Type^7 - ^6"..json.encode(MovementType).." ^7") end
    if Config.UseProgbar then
        if Config.ProgressBar == "ox" then
            CreateThread(function() if exports.ox_lib:progressBar({ duration = time, label = string..(Config.Inv == "ox" and exports.ox_inventory:Items(itemName).label or QBCore.Shared.Items[itemName].label).."..", useWhileDead = false, canCancel = false,}) then consuming = false else end end)
        else
            CreateThread(function() QBCore.Functions.Progressbar('jimmy_consume_', string..(Config.Inv == "ox" and exports.ox_inventory:Items(itemName).label or QBCore.Shared.Items[itemName].label).."..", time, false, false, {disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true,}, {}, {}, {}, function() consuming = false end, function() end, itemName) end)
        end
    else
        triggerNotify(nil, string..(Config.Inv == "ox" and exports.ox_inventory:Items(itemName).label or QBCore.Shared.Items[itemName].label).."..", "success")
    end

	consuming = true
    CreateThread(function()
        --Prop Spawning
        if model then
            if IsModelValid(model) == 1 then
                if Config.Debug then print("^5Debug^7: ^3PropSpawn^7: ^2Spawning consumable prop^7.") end
                    attachProp = makeProp({ prop = model, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                    AttachEntityToEntity(attachProp, Player, bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)
                    if model2 then
                        if IsModelValid(model2) == 1 then
                            attachProp2 = makeProp({ prop = model2, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                            AttachEntityToEntity(attachProp2, Player, bone2, P7, P8, P9, P10, P11, P12, true, true, false, true, 1, true)
                        else print("^5Debug^7: ^3PropSpawn^7: ^2Second prop model isn't valid/found^7.") end
                    end
                    while consuming do Wait(50) end
                    if DoesEntityExist(attachProp) then destroyProp(attachProp) attachProp = nil end
                    if DoesEntityExist(attachProp2) then destroyProp(attachProp2) attachProp2 = nil end
            else print("^5Debug^7: ^3PropSpawn^7: ^2Prop model isn't valid/found^7.") end
        end
        end)
	while consuming do
		if time <= 0 then consuming = false end
        if not canRun then
            if IsControlJustPressed(0, 21) then
                consuming = false
                cancelled = true
                LocalPlayer.state:set("inv_busy", false, true)
                if Config.UseProgbar then
                    if Config.ProgressBar == "ox" then exports.ox_lib:cancelProgress()
                    else TriggerEvent("progressbar:client:cancel") end
                else
                    triggerNotify(nil, "Cancelled "..string, "error")
                end
            end
        end
        Wait(9)
        time -= 11
	end
	StopEntityAnim(Player, anim, animDict, 1.0)
    unloadAnimDict(animDict)
	if not cancelled then
        toggleItem(false, itemName, 1)
        if returnItem ~= nil then toggleItem(true, returnItem.item, returnItem.amount) end

        -- Reward Item calculations
        CreateThread(function()
            if RewardItem then
                for i = 1, Consumables[itemName].amounttogive do
                    local rarity = math.random(1, 4) -- rarity calculation
                    while true do
                        local item = math.random(1, countTable(RewardItem)) -- random item in the list to pick
                        if RewardItem[item].rarity >= rarity then
                            toggleItem(true, RewardItem[item].item, math.random(1, RewardItem[item].max))
                            if Config.Debug then print("^5Debug^7: ^2Given reward prize^7: '^6"..RewardItem[item].item.."^7'") end
                            break
                        end
                        Wait(100)
                    end
                    Wait(1500)
                end
            end
        end)
        if stats then
            if stats.hunger then TriggerServerEvent("jim-consumables:server:addNeed", QBCore.Functions.GetPlayerData().metadata["hunger"] + stats.hunger, "hunger") end
            if stats.thirst then TriggerServerEvent("jim-consumables:server:addNeed", QBCore.Functions.GetPlayerData().metadata["thirst"] + stats.thirst, "thirst") end
        end
        if Config.Debug then print("^5Debug^7: ^2Hunger^7: [^6"..(stats.hunger or 0).."^7] ^2Thrist^7: [^6"..(stats.thirst or 0).."^7]" ) end
        if stress and stress ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Reliving ^6"..stress.." ^2stress^7.") end
            TriggerServerEvent('hud:server:RelieveStress', stress)
        end
		if heal and heal ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Healing player by^7: ^6"..heal) end
            SetEntityHealth(Player, GetEntityHealth(Player) + heal)
        end
		if armor and armor ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Adding ^6"..armor.." ^2armour^7.") end
            TriggerServerEvent('hospital:server:SetArmor', (GetPedArmour(Player) + armor)) SetPedArmour(Player, (GetPedArmour(Player) + armor))
        end
		if type == "alcohol" then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4alcoholCount^7: ^6"..(alcoholCount + 1)) end
			alcoholCount = alcoholCount + 1
			if alcoholCount > 1 and alcoholCount < 4 then
				TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
			elseif alcoholCount >= 4 then
				TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
                CreateThread(function() AlienEffect() end) -- Used as overdosing/too drunk effect
            end
        end
        if stats then
            if stats.screen then -- Screen effect activation
                if stats.screen == "turbo" then CreateThread(function() TurboEffect() end) end
                if stats.screen == "focus" then CreateThread(function() FocusEffect() end) end
                if stats.screen == "rampage" then CreateThread(function() RampageEffect() end) end
                if stats.screen == "weed" then CreateThread(function() WeedEffect() end) end
                if stats.screen == "trevor" then CreateThread(function() TrevorEffect() end) end
                if stats.screen == "nightvision" then CreateThread(function() NightVisionEffect() end) end
                if stats.screen == "thermal" then CreateThread(function() ThermalEffect() end) end
            end
			if stats.canOD then
                if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..(drugCount + 1)) end
				drugCount += 1
				if drugCount >= 4 then
                    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..drugCount.."^7 - ^2 removing health") end
					SetEntityHealth(PlayerPedId(), GetEntityHealth(Player) - math.random(10,15))
					if drugCount >= 7 then
                        CreateThread(function() AlienEffect() end) -- If too many drugs, if not dead will make you stumble
					end
				end
			end
			if stats.effect == "heal" then
                if GetResourceState("ps-buffs") == "started" then
                    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6Health Buff ^2for ^6"..stats.time.."^7ms") end
                    exports["ps-buffs"]:AddHealthBuff((tonumber(stats.time) or 10000), (stats.amount or 6))
                else CreateThread(function() HealEffect({(tonumber(stats.time) or 10000), (stats.amount or 6)}) end) end
            end
			if stats.effect == "stamina" then
                if GetResourceState("ps-buffs") == "started" then
                    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6Stamina Buff ^2for ^6"..stats.time.."^7ms") end
                    exports["ps-buffs"]:StaminaBuffEffect((tonumber(stats.time) or 10000), (stats.amount or 6))
                else CreateThread(function() StaminaEffect({(tonumber(stats.time) or 10000), (stats.amount or 6)}) end) end
			end
            if GetResourceState("ps-buffs") == "started" then   --PS-BUFFS ONLY
                --if Config.Debug then if stats.effect then print("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs and applying ^6"..stats.effect.." Buff ^2for ^6"..(stats.time or "nil").."^7ms") end end
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
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Finished, unlocking inventory^7...") end
    LocalPlayer.state:set("inv_busy", false, true) TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
end)

CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then Wait(1000 * 60 * 15) alcoholCount -= 1 else Wait(1000) end
        if drugCount > 0 then Wait(1000 * 60 * 15) drugCount -= 1 else Wait(1000) end
	end
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
    StopEffects()
end)
