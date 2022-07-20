local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local alcoholCount = 0
local drugCount = 0

local time = 40
function loadModel(model) if not HasModelLoaded(model) then if Config.Debug then print("^5Debug^7: ^2Loading Model^7: '^6"..model.."^7'") end while not HasModelLoaded(model) do if time > 0 then time = time - 1 RequestModel(model) else time = 40 break end Wait(10)	end	end end
function unloadModel(model) if Config.Debug then print("^5Debug^7: ^2Removing Model^7: '^6"..model.."^7'") end SetModelAsNoLongerNeeded(model) end
function loadAnimDict(dict)	if Config.Debug then print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6"..dict.."^7'") end while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end end
function unloadAnimDict(dict) if Config.Debug then print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6"..dict.."^7'") end RemoveAnimDict(dict) end
function destroyProp(entity) if Config.Debug then print("^5Debug^7: ^2Destroying Prop^7: '^6"..entity.."^7'") end SetEntityAsMissionEntity(entity) Wait(5) DetachEntity(entity, true, true) Wait(5) DeleteObject(entity) end

--Convert Prop Model Names to Model HashKeys now to be more optimized when loading later
for k in pairs(Config.Emotes) do
    if Config.Emotes[k].AnimationOptions.Prop then
        Config.Emotes[k].AnimationOptions.Prop = GetHashKey(Config.Emotes[k].AnimationOptions.Prop)
    end
end

--Alcohol Effects
local alienEffect = false
function AlienEffect()
    if alienEffect then return end
    alienEffect = true
    if Config.Debug then print("^5Debug^7: ^3AlienEffect^7() ^2activated") end
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local Ped = PlayerPedId()
    local animDict = "MOVE_M@DRUNK@VERYDRUNK"
    loadAnimDict(animDict)
    SetPedCanRagdoll(Ped, true)
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(Ped, animDict, 1)
    SetPedMotionBlur(Ped, true)
    SetPedIsDrunk(Ped, true)
    Wait(1500)
    SetPedToRagdoll(Ped, 5000, 1000, 1, 0, 0, 0)
    Wait(13500)
    SetPedToRagdoll(Ped, 5000, 1000, 1, 0, 0, 0)
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(Ped, 0)
    SetPedIsDrunk(Ped, false)
    SetPedMotionBlur(Ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
    alienEffect = false
    if Config.Debug then print("^5Debug^7: ^3AlienEffect^7() ^2stopped") end
end
--Weed Effects
local weedEffect = false
function WeedEffect()
    if weedEffect then return end
    weedEffect = true
    if Config.Debug then print("^5Debug^7: ^3WeedEffect^7() ^2activated") end
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(3000, 20000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(15000, 20000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
    weedEffect = false
    if Config.Debug then print("^5Debug^7: ^3WeedEffect^7() ^2stopped") end
end
--Other Effects
local trevorEffect = false
function TrevorEffect()
    if trevorEffect then return end
    if Config.Debug then print("^5Debug^7: ^3TrevorEffect^7() ^2activated") end
    trevorEffect = true
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(30000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
    trevorEffect = false
    if Config.Debug then print("^5Debug^7: ^3TrevorEffect^7() ^2stopped") end
end

local healEffectDouble = false
function HealEffectDouble()
    if healEffectDouble then return end
    if Config.Debug then print("^5Debug^7: ^3HealEffectDouble^7() ^2activated") end
    healEffectDouble = true
    local count = 9
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6)
    end
    healEffectDouble = false
    if Config.Debug then print("^5Debug^7: ^3HealEffectDouble^7() ^2stopped") end
end

local healEffect = false
function HealEffect()
    if healEffect then return end
    if Config.Debug then print("^5Debug^7: ^3HealEffect^7() ^2activated") end
    healEffect = true
    local count = 4
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6)
    end
    healEffect = false
    if Config.Debug then print("^5Debug^7: ^3HealEffect^7() ^2stopped") end
end

local staminaEffect = false
function StaminaEffect()
    if staminaEffect then return end
    if Config.Debug then print("^5Debug^7: ^3StaminaEffect^7() ^2activated") end
    staminaEffect = true
    local startStamina = 8
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then RestorePlayerStamina(PlayerId(), 1.0) end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    staminaEffect = false
    if Config.Debug then print("^5Debug^7: ^3StaminaEffect^7() ^2stopped") end
end

function StopEffects()
    if Config.Debug then print("^5Debug^7: ^2All screen effects stopped") end
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    SetPedToRagdoll(PlayerPedId(), 5000, 1000, 1, 0, 0, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(PlayerPedId(), 0)
    SetPedIsDrunk(PlayerPedId(), false)
    SetPedMotionBlur(PlayerPedId(), false)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

--[[function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end

function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    --AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            --AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    --AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            --AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end]]

local consuming = false
local cancelled = false

RegisterNetEvent('jim-consumables:Consume', function(itemName)
    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Starting event, locking inventory and grabbing data^7..") end
    LocalPlayer.state:set("inv_busy", true, true)
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
		TriggerEvent("QBCore:Notify", "Stopped "..string, "error")
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

	TriggerEvent("QBCore:Notify", string..QBCore.Shared.Items[itemName].label.."..", "success", (time + 1000))
	consuming = true

    CreateThread(function()
        --Prop Spawning
        if model then
            if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Spawning consumable prop^7.") end
            loadModel(model)
            local attachProp = CreateObject(model, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(attachProp, PlayerPedId(), bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)
            while consuming do Wait(100) end
            destroyProp(attachProp)
        end
    end)

	while consuming do
		if time <= 0 then consuming = false end
		if IsControlJustPressed(0, 21) then
			consuming = false
			cancelled = true
            LocalPlayer.state:set("inv_busy", false, true)
		end
		Wait(10)
		time = time - 10
	end

	StopEntityAnim(PlayerPedId(), anim, animDict, 1.0)
    unloadAnimDict(animDict)

	if not cancelled then
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)

        if QBCore.Shared.Items[itemName].thirst then
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
        if QBCore.Shared.Items[itemName].hunger then
			TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end

		if not QBCore.Shared.Items[itemName].thirst and not QBCore.Shared.Items[itemName].hunger then
			local hunger = 0
			local thirst = 0
            if Config.Consumables[itemName].stats then
                if Config.Consumables[itemName].stats.hunger then hunger = Config.Consumables[itemName].stats.hunger end
                TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + hunger)
                if Config.Consumables[itemName].stats.thirst then thirst = Config.Consumables[itemName].stats.thirst end
                TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + thirst)
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
                CreateThread(function()
                    AlienEffect()
                end)			
            end
        end

		stats = Config.Consumables[itemName].stats or nil

		if Config.Consumables[itemName].stats then
			if stats.canOD then
                if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..(drugCount + 1)) end
				drugCount = drugCount + 1
				if drugCount >= 4 then
                    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Current ^4drugCount^7: ^6"..drugCount.."^7 - ^2 removing health") end
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - math.random(10,15))
					if drugCount >= 6 then
                        CreateThread(function()
                            AlienEffect()
                        end)
					end
				end
			end
			if stats.effect == "weed" then
				if drugCount >= 2 then
                    CreateThread(function()
                        TrevorEffect()
                    end)
				end
			end
			if stats.effect == "heal" then
                CreateThread(function()
                    HealEffect()
                end)
			end
			if stats.effect == "healdouble" then
                CreateThread(function()
                    HealEffect()
                end)
			end
			if stats.effect == "stamina" then
                CreateThread(function()
                    StaminaEffect()
                end)
				if drugCount >= 4 then                        
                CreateThread(function()
					TrevorEffect()
                end)
				end
			end
			if stats.widepupils then
				TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
				--EcstasyEffect()
			end
		end

	end
	cancelled = false
	consuming = false

    if Config.Debug then print("^5Debug^7: ^3Consume^7: ^2Finished, unlocking inventory^7..") end
    LocalPlayer.state:set("inv_busy", false, true)
end)

CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Wait(2000)
        end
	end
end)
CreateThread(function()
	while true do
        Wait(10)
        if drugCount > 0 then
            Wait(1000 * 60 * 15)
            drugCount = drugCount - 1
        else
            Wait(2000)
        end
    end
end)

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
    StopEffects()
end)