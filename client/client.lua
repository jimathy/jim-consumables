local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local onDuty = false
local alcoholCount = 0
local drugCount = 0

local function loadAnimDict(dict) while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Wait(5) end end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    local ped = PlayerPedId()
    RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK") 
    while not HasAnimSetLoaded("MOVE_M@DRUNK@VERYDRUNK") do
      Citizen.Wait(0)
    end    
    SetPedCanRagdoll( ped, true )
    ShakeGameplayCam('DRUNK_SHAKE', 2.80)
    SetTimecycleModifier("Drunk")
    SetPedMovementClipset(ped, "MOVE_M@DRUNK@VERYDRUNK", true)
    SetPedMotionBlur(ped, true)
    SetPedIsDrunk(ped, true)
    Wait(1500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(13500)
    SetPedToRagdoll(ped, 5000, 1000, 1, false, false, false )
    Wait(120500)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(ped, 0)
    SetPedIsDrunk(ped, false)
    SetPedMotionBlur(ped, false)
    AnimpostfxStopAll()
    ShakeGameplayCam('DRUNK_SHAKE', 0.0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(45000, 60000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

--[[function HealDrug()
    if not healing then
        healing = true
    else
        return
    end

    local count = 9
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6)
    end
    healing = false
end

function MethBagEffect()
    local startStamina = 8
    --TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            --TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function EcstasyEffect()
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

function JointEffect()
    -- if not onWeed then
    --     local RelieveOdd = math.random(35, 45)
    --     onWeed = true
    --     local weedTime = Config.JointEffectTime
    --     CreateThread(function()
    --         while onWeed do
    --             SetPlayerHealthRechargeMultiplier(PlayerId(), 1.8)
    --             Wait(1000)
    --             weedTime = weedTime - 1
    --             if weedTime == RelieveOdd then
    --                 TriggerServerEvent('hud:Server:RelieveStress', math.random(14, 18))
    --             end
    --             if weedTime <= 0 then
    --                 onWeed = false
    --             end
    --         end
    --     end)
    -- end
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

RegisterNetEvent('jim-consumables:Consume', function(itemName, type)
	local Player = PlayerPedId()
	local emote = Config.Emotes[Config.Consumables[itemName].emote]
	local animDict = tostring(emote[1])
	local anim = tostring(emote[2])
	local model, bone, drugeffect = nil
	local P1, P2, P3, P4, P5, P6 = table.unpack({0.0, 0.0, 0.0, 0.0, 0.0, 0.0})
	if emote.AnimationOptions.Prop then
		model = tostring(emote.AnimationOptions.Prop)
		bone = GetPedBoneIndex(PlayerPedId(), emote.AnimationOptions.PropBone)
		P1, P2, P3, P4, P5, P6 = table.unpack(emote.AnimationOptions.PropPlacement)
	end
	local type = Config.Consumables[itemName].type
	
	if type == "drink" or type == "alcohol" then string = "Drinking " end
	if type == "food" then string = "Eating " end
	if type == "drug" then string = "Using " end
	
	if consuming then
		cancelled = true
		TriggerEvent("QBCore:Notify", "Stopped "..string, "error")
		consuming = not consuming
		return
	end
	
	if emote.AnimationOptions then
		if emote.AnimationOptions.EmoteLoop then MovementType = 1
		if emote.AnimationOptions.EmoteMoving then MovementType = 51
	end
		elseif emote.AnimationOptions.EmoteMoving then MovementType = 51
		elseif emote.AnimationOptions.EmoteMoving == false then	MovementType = 0
		elseif emote.AnimationOptions.EmoteStuck then MovementType = 50
	end

	else MovementType = 0 end
	InVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
	if InVehicle == 1 then MovementType = 51 end

	loadAnimDict(animDict)
	
	TaskPlayAnim(Player, animDict, anim, 1.0, 1.0, -1, MovementType, 0, 0, 0, 0)

	--Prop Spawning
	local attachProp = CreateObject(GetHashKey(model), 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachProp, PlayerPedId(), bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)	
	
	local time = math.random(1000, 2000)
	
	TriggerEvent("QBCore:Notify", string..QBCore.Shared.Items[itemName].label.."..", "success", (time + 1000))
	
	consuming = true
	while consuming do
		if time <= 0 then consuming = false print("complete") end
		if IsControlJustPressed(0, 21) then
			consuming = false
			cancelled = true
		end
		Wait(10)
		time = time - 10
	end
	
	StopEntityAnim(Player, anim, animDict, 1.0)
	DeleteEntity(attachProp)
	
	if not cancelled then
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)

        if QBCore.Shared.Items[itemName].thirst then 
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst) end
        if QBCore.Shared.Items[itemName].hunger then 
			TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger) end

		if not QBCore.Shared.Items[itemName].thirst and not QBCore.Shared.Items[itemName].hunger then
			if type == "food" then TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + math.random(10,20)) end
			if type == "drink" then TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + math.random(10,20)) end
		end
		
        if stress then TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4)) end
		
		if type == "alcohol" then
			alcoholCount = alcoholCount + 1
			if alcoholCount > 1 and alcoholCount < 4 then
				TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
			elseif alcoholCount >= 4 then
				TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
				AlienEffect()
			end
        end
		
		--[[drugeffect = Config.Consumables[itemName].drugeffect

		if drugeffect ~= nil then
			if drugeffect.canOD then
				drugCount = drugCount + 2
				if drugCount >= 4 then
					SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - math.random(20,40))
					if drugCount >= 6 then
						AlienEffect()
					end
				end
			end
			if drugeffect.armour then 
			end
			if drugeffect.health then
				HealDrug()
			end
			if drugeffect.stamina then
				MethBagEffect()
				if drugCount >= 4 then
					TrevorEffect()
				end
			end
			if drugeffect.widepupils then
				TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
				EcstasyEffect()
			end
		end]]

	end
	cancelled = false
	consuming = false
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
--[[CreateThread(function()
	while true do
        Wait(10)
        if drugCount > 0 then
            Wait(1000 * 60 * 15)
            drugCount = drugCount - 1
        else
            Wait(2000)
        end
    end
end)]]