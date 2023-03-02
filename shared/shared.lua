local QBCore = exports[Config.Core]:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports[Config.Core]:GetCoreObject() end)

local time = 1000
function loadModel(model) if not HasModelLoaded(model) then
	if Config.Debug then print("^5Debug^7: ^2Loading Model^7: '^6"..model.."^7'") end
	while not HasModelLoaded(model) do
		if time > 0 then time -= 1 RequestModel(model)
		else time = 1000 print("^5Debug^7: ^3LoadModel^7: ^2Timed out loading model ^7'^6"..model.."^7'") break
		end
		Wait(10)
	end
end end
function unloadModel(model) if Config.Debug then print("^5Debug^7: ^2Removing Model^7: '^6"..model.."^7'") end SetModelAsNoLongerNeeded(model) end
function loadAnimDict(dict) if not HasAnimDictLoaded(dict) then if Config.Debug then print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6"..dict.."^7'") end while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end end end
function unloadAnimDict(dict) if Config.Debug then print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6"..dict.."^7'") end RemoveAnimDict(dict) end
function loadPtfxDict(dict) if not HasNamedPtfxAssetLoaded(dict) then if Config.Debug then print("^5Debug^7: ^2Loading Ptfx Dictionary^7: '^6"..dict.."^7'") end while not HasNamedPtfxAssetLoaded(dict) do RequestNamedPtfxAsset(dict) Wait(5) end end end
function unloadPtfxDict(dict) if Config.Debug then print("^5Debug^7: ^2Removing Ptfx Dictionary^7: '^6"..dict.."^7'") end RemoveNamedPtfxAsset(dict) end

function destroyProp(entity)
	if Config.Debug then print("^5Debug^7: ^2Destroying Prop^7: '^6"..entity.."^7'") end
	SetEntityAsMissionEntity(entity) Wait(5)
	DeleteObject(entity)
end

function makeProp(data, freeze, synced)
    loadModel(data.prop)
    local prop = CreateObject(data.prop, 0.0, 0.0, 0.0, synced or false, synced or false, false)
    SetEntityHeading(prop, data.coords.w+180.0)
    SetEntityCompletelyDisableCollision(prop, true, false)
    DisableCamCollisionForEntity(prop)
    DisableCamCollisionForObject(prop)
    if Config.Debug then print("^5Debug^7: ^6Prop ^2Created ^7: '^6"..prop.."^7'") end
    return prop
end

function triggerNotify(title, message, type, src)
	if Config.Notify == "okok" then
		if not src then	exports['okokNotify']:Alert(title, message, 6000, type)
		else TriggerClientEvent('okokNotify:Alert', src, title, message, 6000, type) end
	elseif Config.Notify == "qb" then
		if not src then	TriggerEvent("QBCore:Notify", message, type)
		else TriggerClientEvent("QBCore:Notify", src, message, type) end
	elseif Config.Notify == "t" then
		if not src then exports['t-notify']:Custom({title = title, style = type, message = message, sound = true})
		else TriggerClientEvent('t-notify:client:Custom', src, { style = type, duration = 6000, title = title, message = message, sound = true, custom = true}) end
	elseif Config.Notify == "infinity" then
		if not src then TriggerEvent('infinity-notify:sendNotify', message, type)
		else TriggerClientEvent('infinity-notify:sendNotify', src, message, type) end
	elseif Config.Notify == "rr" then
		if not src then exports.rr_uilib:Notify({msg = message, type = type, style = "dark", duration = 6000, position = "top-right", })
		else TriggerClientEvent("rr_uilib:Notify", src, {msg = message, type = type, style = "dark", duration = 6000, position = "top-right", }) end
	elseif Config.Notify == "ox" then
		if not src then	exports.ox_lib:notify({title = title, description = message, type = type or "success"})
		else exports.ox_lib:notify({title = title, description = message, type = type or "success"}) end
	end
end

function countTable(table) local i = 0 for keys in pairs(table) do i += 1 end return i end

function toggleItem(give, item, amount) TriggerServerEvent("jim-consumables:server:toggleItem", give, item, amount) end

if Config.Inv == "ox" then
	function HasItem(items, amount)
		local count = exports.ox_inventory:Search('count', items)
        if count >= amount then if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^5FOUND^7 ^3"..count.."^7/^3"..amount.." "..tostring(items)) end return true
        else if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2"..tostring(items).." ^1NOT FOUND^7") end return false end
	end
else
    function HasItem(items, amount)
        local amount = amount or 1
        local count = 0
        for _, itemData in pairs(QBCore.Functions.GetPlayerData().items) do
            if itemData and (itemData.name == items) then
                if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Item^7: '^3"..tostring(items).."^7' ^2Slot^7: ^3"..itemData.slot.." ^7x(^3"..tostring(itemData.amount).."^7)") end
                count += itemData.amount
            end
        end
        if count >= amount then
            if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^5FOUND^7 x^3"..count.."^7") end
            return true
        else
            if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^1NOT FOUND^7") end
            return false
        end
    end
end

--Screen Effects
local alienEffect = false
function AlienEffect()
    if alienEffect then return else alienEffect = true end
    if Config.Debug then print("^5Debug^7: ^3AlienEffect^7() ^2activated") end
    AnimpostfxPlay("DrugsMichaelAliensFightIn", 3.0, 0)
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
    AnimpostfxPlay("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))
    AnimpostfxPlay("DrugsMichaelAliensFightOut", 3.0, 0)
    AnimpostfxStop("DrugsMichaelAliensFightIn")
    AnimpostfxStop("DrugsMichaelAliensFight")
    AnimpostfxStop("DrugsMichaelAliensFightOut")
    alienEffect = false
    if Config.Debug then print("^5Debug^7: ^3AlienEffect^7() ^2stopped") end
end
local weedEffect = false
function WeedEffect()
    if weedEffect then return else weedEffect = true end
    if Config.Debug then print("^5Debug^7: ^3WeedEffect^7() ^2activated") end
    AnimpostfxPlay("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(3000, 20000))
    AnimpostfxPlay("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(15000, 20000))
    AnimpostfxPlay("DrugsMichaelAliensFightOut", 3.0, 0)
    AnimpostfxStop("DrugsMichaelAliensFightIn")
    AnimpostfxStop("DrugsMichaelAliensFight")
    AnimpostfxStop("DrugsMichaelAliensFightOut")
    weedEffect = false
    if Config.Debug then print("^5Debug^7: ^3WeedEffect^7() ^2stopped") end
end
local trevorEffect = false
function TrevorEffect()
    if trevorEffect then return else trevorEffect = true end
    if Config.Debug then print("^5Debug^7: ^3TrevorEffect^7() ^2activated") end
    AnimpostfxPlay("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    AnimpostfxPlay("DrugsTrevorClownsFight", 3.0, 0)
    Wait(30000)
	AnimpostfxPlay("DrugsTrevorClownsFightOut", 3.0, 0)
	AnimpostfxStop("DrugsTrevorClownsFight")
	AnimpostfxStop("DrugsTrevorClownsFightIn")
	AnimpostfxStop("DrugsTrevorClownsFightOut")
    trevorEffect = false
    if Config.Debug then print("^5Debug^7: ^3TrevorEffect^7() ^2stopped") end
end
local turboEffect = false
function TurboEffect()
    if turboEffect then return else turboEffect = true end
    if Config.Debug then print("^5Debug^7: ^3TurboEffect^7() ^2activated") end
    AnimpostfxPlay('RaceTurbo', 0, true)
    SetTimecycleModifier('rply_motionblur')
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
    Wait(30000)
    StopGameplayCamShaking(true)
    SetTransitionTimecycleModifier('default', 0.35)
    Wait(1000)
    ClearTimecycleModifier()
    AnimpostfxStop('RaceTurbo')
    turboEffect = false
    if Config.Debug then print("^5Debug^7: ^3TurboEffect^7() ^2stopped") end
end
local rampageEffect = false
function RampageEffect()
    if rampageEffect then return else rampageEffect = true end
    if Config.Debug then print("^5Debug^7: ^3RampageEffect^7() ^2activated") end
    AnimpostfxPlay('Rampage', 0, true)
    SetTimecycleModifier('rply_motionblur')
    ShakeGameplayCam('SKY_DIVING_SHAKE', 0.25)
    Wait(30000)
    StopGameplayCamShaking(true)
    SetTransitionTimecycleModifier('default', 0.35)
    Wait(1000)
    ClearTimecycleModifier()
    AnimpostfxStop('Rampage')
    rampageEffect = false
    if Config.Debug then print("^5Debug^7: ^3RampageEffect^7() ^2stopped") end
end
local focusEffect = false
function FocusEffect()
    if focusEffect then return else focusEffect = true end
    if Config.Debug then print("^5Debug^7: ^3FocusEffect^7() ^2activated") end
    Wait(1000)
    AnimpostfxPlay('FocusIn', 0, true)
    Wait(30000)
    AnimpostfxStop('FocusIn')
    focusEffect = false
    if Config.Debug then print("^5Debug^7: ^3FocusEffect^7() ^2stopped") end
end
local NightVisionEffect = false
function NightVisionEffect()
    if NightVisionEffect then return else NightVisionEffect = true end
    if Config.Debug then print("^5Debug^7: ^3NightVisionEffect^7() ^2activated") end
    SetNightvision(true)
    Wait(math.random(3000, 4000))  -- FEEL FREE TO CHANGE THIS
    SetNightvision(false)
    SetSeethrough(false)
    NightVisionEffect = false
    if Config.Debug then print("^5Debug^7: ^3NightVisionEffect^7() ^2stopped") end
end
local thermalEffect = false
function ThermalEffect()
    if thermalEffect then return else thermalEffect = true end
    if Config.Debug then print("^5Debug^7: ^3ThermalEffect^7() ^2activated") end
    SetNightvision(true)
    SetSeethrough(true)
    Wait(math.random(2000, 3000))  -- FEEL FREE TO CHANGE THIS
    SetNightvision(false)
    SetSeethrough(false)
    thermalEffect = false
    if Config.Debug then print("^5Debug^7: ^3ThermalEffect^7() ^2stopped") end
end

--Built-in Buff effects
local healEffect = false
function HealEffect(data)
    if healEffect then return end
    if Config.Debug then print("^5Debug^7: ^3HealEffect^7() ^2activated") end
    healEffect = true
    local count = (data[1] / 1000)
    while count > 0 do
        Wait(1000)
        count -= 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + data[2])
    end
    healEffect = false
    if Config.Debug then print("^5Debug^7: ^3HealEffect^7() ^2stopped") end
end

local staminaEffect = false
function StaminaEffect(data)
    if staminaEffect then return end
    if Config.Debug then print("^5Debug^7: ^3StaminaEffect^7() ^2activated") end
    staminaEffect = true
    local startStamina = (data[1] / 1000)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then RestorePlayerStamina(PlayerId(), data[2]) end
        startStamina -= 1
        if math.random(5, 100) < 51 then end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    staminaEffect = false
    if Config.Debug then print("^5Debug^7: ^3StaminaEffect^7() ^2stopped") end
end

function StopEffects() -- Used to clear up any effects stuck on screen
    if Config.Debug then print("^5Debug^7: ^2All screen effects stopped") end
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    SetPedToRagdoll(PlayerPedId(), 5000, 1000, 1, 0, 0, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(PlayerPedId(), 0)
    SetPedIsDrunk(PlayerPedId(), false)
    SetPedMotionBlur(PlayerPedId(), false)
    SetNightvision(false)
    SetSeethrough(false)
    AnimpostfxStop("DrugsMichaelAliensFightIn")
    AnimpostfxStop("DrugsMichaelAliensFight")
    AnimpostfxStop("DrugsMichaelAliensFightOut")
	AnimpostfxStop("DrugsTrevorClownsFight")
	AnimpostfxStop("DrugsTrevorClownsFightIn")
	AnimpostfxStop("DrugsTrevorClownsFightOut")
    AnimpostfxStop('RaceTurbo')
    AnimpostfxStop('FocusIn')
    AnimpostfxStop('Rampage')
end