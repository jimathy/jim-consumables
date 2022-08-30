local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local alcoholCount = 0
local drugCount = 0

--Convert Prop Model Names to Model HashKeys now to be more optimized when loading later
for k in pairs(Config.Emotes) do
    if Config.Emotes[k].AnimationOptions.Prop then
        Config.Emotes[k].AnimationOptions.Prop = GetHashKey(Config.Emotes[k].AnimationOptions.Prop)
    end
end

local consuming = false
local cancelled = false

RegisterNetEvent('jim-consumables:Consume', function(itemName)
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Starting event, locking inventory and grabbing data^7..") end
    LocalPlayer.state:set("inv_busy", true, true) TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
	local Player = PlayerPedId()
	local emote = Config.Emotes[Config.Consumables[itemName].emote]
	local animDict = tostring(emote[1])
	local anim = tostring(emote[2])
	local model, bone, drugeffect, stress
	local P1, P2, P3, P4, P5, P6 = table.unpack({0.0, 0.0, 0.0, 0.0, 0.0, 0.0})
	if emote.AnimationOptions.Prop then
		model = emote.AnimationOptions.Prop
		bone = GetPedBoneIndex(PlayerPedId(), emote.AnimationOptions.PropBone)
		P1, P2, P3, P4, P5, P6 = table.unpack(emote.AnimationOptions.PropPlacement)
	end
	local time = Config.Consumables[itemName].time or math.random(5000, 6000)
	local type = Config.Consumables[itemName].type or "food"
	local stress = Config.Consumables[itemName].stress or 0
	local heal = Config.Consumables[itemName].heal or 0
	local armor = Config.Consumables[itemName].armor or 0
	if type == "drink" or type == "alcohol" then string = "Drinking " end
	if type == "food" then string = "Eating " end
	if type == "drug" then string = "Using " end
	if consuming then
		cancelled = true
        if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Event already started^7, ^1Cancelling^7.") end
        LocalPlayer.state:set("inv_busy", false, true)
        if Config.UseProgbar then
            TriggerEvent("progressbar:client:cancel")
        else
            triggerNotify(nil, "Stopped "..string, "error")
        end
		consuming = not consuming
		return
	end
	--Emote Stuff
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Grabbing Emote Animation Options^7...") end
	if emote.AnimationOptions then
		if emote.AnimationOptions.EmoteLoop then MovementType = 1
		if emote.AnimationOptions.EmoteMoving then MovementType = 51
	end
		elseif emote.AnimationOptions.EmoteMoving then MovementType = 51
		elseif emote.AnimationOptions.EmoteMoving == false then	MovementType = 0
		elseif emote.AnimationOptions.EmoteStuck then MovementType = 50
	end
	else MovementType = 0 end
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Checking if player is in a vehicle^7...") end
	local InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	if InVehicle == 1 then MovementType = 51 end
	--Load and Start animation
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Playing Animation^7...") end
	loadAnimDict(animDict)
	TaskPlayAnim(PlayerPedId(), animDict, anim, 1.0, 1.0, -1, MovementType, 0, 0, 0, 0)
    if Config.UseProgbar then
        QBCore.Functions.Progressbar('jimmy_consume_', string..QBCore.Shared.Items[itemName].label.."..", time, false, false, {disableMovement = false,disableCarMovement = false,disableMouse = false,disableCombat = true,}, {}, {}, {}, function()end) 
    else
        triggerNotify(nil, string..QBCore.Shared.Items[itemName].label.."..", "success")
    end
	consuming = true
    CreateThread(function()
        --Prop Spawning
        if model then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Spawning consumable prop^7.") end
            local attachProp = makeProp({ prop = model, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
            AttachEntityToEntity(attachProp, PlayerPedId(), bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)
            while consuming do Wait(100) end
            destroyProp(attachProp)
        end
    end)
	while consuming do
		if time <= 0 then consuming = false end
        if not Config.Consumables[itemName].canRun then
            if IsControlJustPressed(0, 21) then
                consuming = false
                cancelled = true
                LocalPlayer.state:set("inv_busy", false, true)
                if Config.UseProgbar then
                    Wait(10)
                    TriggerEvent("progressbar:client:cancel")
                else
                    triggerNotify(nil, "Cancelled "..string, "error")
                end
            end
        end
        Wait(10)
        time = time - 10
	end
	StopEntityAnim(PlayerPedId(), anim, animDict, 1.0)
    unloadAnimDict(animDict)
	if not cancelled then
        toggleItem(false, itemName, 1)
        if QBCore.Shared.Items[itemName].thirst then TriggerServerEvent("jim-consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
        if QBCore.Shared.Items[itemName].hunger then TriggerServerEvent("jim-consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end
		if not QBCore.Shared.Items[itemName].thirst and not QBCore.Shared.Items[itemName].hunger then
			local hunger = 0
			local thirst = 0
            if Config.Consumables[itemName].stats then
                if Config.Consumables[itemName].stats.hunger then hunger = Config.Consumables[itemName].stats.hunger end
                TriggerServerEvent("jim-consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + hunger)
                if Config.Consumables[itemName].stats.thirst then thirst = Config.Consumables[itemName].stats.thirst end
                TriggerServerEvent("jim-consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
            end
		end
        if stress and stress ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Reliving ^6"..stress.." ^2stress^7.") end
            TriggerServerEvent('hud:server:RelieveStress', stress)
        end
		if heal and heal ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Healing player by^7: ^6"..heal) end
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + heal)
        end
		if armor and armor ~= 0 then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Adding ^6"..armor.." ^2armour^7.") end
            TriggerServerEvent('hospital:server:SetArmor', (GetPedArmour(PlayerPedId()) + armor)) SetPedArmour(PlayerPedId(), (GetPedArmour(PlayerPedId()) + armor))
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
        stats = Config.Consumables[itemName].stats or nil
        if Config.Consumables[itemName].stats then
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
				drugCount = drugCount + 1
				if drugCount >= 4 then
                    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..drugCount.."^7 - ^2 removing health") end
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - math.random(10,15))
					if drugCount >= 7 then
                        CreateThread(function() AlienEffect() end) -- If too many drugs, if not dead will make you stumble
					end
				end
			end
			if stats.effect == "heal" then
                if GetResourceState("ps-buffs") == "started" then exports["ps-buffs"]:AddHealthBuff((stats.time or 10000), (stats.amount or 6))
                else CreateThread(function() HealEffect({(stats.time or 10000), (stats.amount or 6)}) end) end
            end
			if stats.effect == "stamina" then
                if GetResourceState("ps-buffs") == "started" then exports["ps-buffs"]:StaminaBuffEffect((stats.time or 10000), (stats.amount or 6))
                else CreateThread(function() StaminaEffect({(stats.time or 10000), (stats.amount or 6)}) end) end
			end
            if GetResourceState("ps-buffs") == "started" then   --PS-BUFFS ONLY
                if Config.Debug then print("^5Debug^7: ^3Consume^7: ^4PS^7-^4Buffs ^2found^7, ^2hooking in to get buffs") end
                if stats.effect == "armor" then exports["ps-buffs"]:AddArmorBuff((stats.time or 10000), (stats.amount or 6)) end
                if stats.effect == "stress" then exports["ps-buffs"]:AddStressBuff((stats.time or 10000), (stats.amount or 6)) end
                if stats.effect == "swimming" then exports["ps-buffs"]:SwimmingBuffEffect((stats.time or 10000), (stats.amount or 6)) end
                if stats.effect == "hacking" then exports["ps-buffs"]:AddBuff("hacking", (stats.time or 10000)) end
                if stats.effect == "intelligence" then exports["ps-buffs"]:AddBuff("intelligence", (stats.time or 10000)) end
                if stats.effect == "luck" then exports["ps-buffs"]:AddBuff("luck", (stats.time or 10000)) end
                if stats.effect == "strength" then exports["ps-buffs"]:AddBuff("strength", (stats.time or 10000)) end
            end
            if stats.widepupils then TriggerEvent("evidence:client:SetStatus", "widepupils", 200) end
		end
	end
	cancelled = false
	consuming = false
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Finished, unlocking inventory^7...") end
    LocalPlayer.state:set("inv_busy", false, true) TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
end)

CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Wait(1000)
        end
        if drugCount > 0 then
            Wait(1000 * 60 * 15)
            drugCount = drugCount - 1
        else
            Wait(1000)
        end
	end
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
    StopEffects()
end)
