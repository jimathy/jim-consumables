RegisterNetEvent("jim-consumables:client:consumableCreator", function()
    local itemTable, emoteTable = {}, {}
    for k, v in pairsByKeys(Items) do itemTable[#itemTable+1] = { value = tostring(k), label = tostring((v.label or k)) } end
    table.sort(itemTable, function(a, b) return a.label < b.label end)
    for k in pairsByKeys(Emotes) do emoteTable[#emoteTable+1] = { value = k, label = k } end
    local input = lib.inputDialog("Consumable Creator", {
        {   type = "select",
            label = "Item List",
            options = itemTable,
            required = true,
            icon = "fas fa-burger",
            clearable = true,
            searchable = true       -- Doesnt work as i think only ox_lib lua was updated, the web stuff doesn't support this
        },
        {   type = "select",
            label = "Emote",
            options = emoteTable,
            required = true,
            icon = "fas fa-user",
            clearable = true,
            searchable = true,       -- Doesnt work as i think only ox_lib lua was updated, the web stuff doesn't support this
            default = "burger",
        },
        {   type = "select",
            label = "Item Required for consuming",
            options = itemTable,
            required = false,
            icon = "fas fa-utensils",
            clearable = true,
            searchable = true       -- Doesnt work as i think only ox_lib lua was updated, the web stuff doesn't support this
        },
        { type = 'number', label = 'Time', description = "How long it takes in ms to consume item", default = 5000, icon = "fas fa-clock", },
        { type = 'number', label = 'Stress Relief', description = "How much stress to relieve", default = 0, icon = "fas fa-mug-hot", },
        { type = 'number', label = 'Healing Amount', description = "How much to heal after consuming", default = 0, icon = "fas fa-notes-medical", },
        { type = 'number', label = 'Armour', description = "How much armour to give after consuming", default = 0, icon = "fas fa-shield-halved", },
        { type = "select", label = "Type", default = "food", icon = "fas fa-box", options = {
            { value = "food", label = "Food" },
            { value = "drink", label = "Drink" },
            { value = "alcohol", label = "Alcohol" },
            { value = "drug", label = "Drugs" },
            { value = "smoke", label = "Cigar/Cigarette" },
            { value = "pack", label = "Pack (Container Item)" },
        }},
    })
    if not input or not input[1] then return end
    local resultTable = {
        item = input[1],
        emote = input[2],
        requireItem = input[3] or nil,
        time = { input[4], input[4] + 1000 },
        stress = input[5],
        heal = input[6],
        armor = input[7],
        type = input[8],
    }
    if resultTable.type == "food" or resultTable.type == "drink" then foodInput(resultTable)
    elseif resultTable.type == "pack" then packInput(resultTable, itemTable)
    else
        ExtraStatsInput(resultTable)
    end
end, false)

function foodInput(prevInput)
    local resultTable = prevInput
    local input = lib.inputDialog((Items[prevInput.item].label or prevInput.item).." - Food or Drink",{
        { type = 'number', label = 'Hunger %', default = 0, icon = "fas fa-burger", },
        { type = 'number', label = 'Thirst %', default = 0, icon = "fas fa-mug-hot", },
    })
    if not input or not input[1] then return end
    resultTable["stats"] = {
        hunger = input[1] ~= 0 and { input[1], input[1] + 10 } or 0,
        thirst = input[2] ~= 0 and { input[2], input[2] + 10 } or 0,
    }
    ExtraStatsInput(resultTable)
end

function packInput(prevInput, itemTable)
    local resultTable = prevInput
    local input = lib.inputDialog((Items[prevInput.item].label or prevInput.item).." - Pack", {
        {   type = "select",
            label = "Item List",
            options = itemTable,
            required = true,
            icon = "fas fa-burger",
        },
        { type = 'number', label = 'Amount to give of item', default = 1, icon = "fas fa-box", },
    })
    resultTable["pack"] = { item = input[1], amount = input[2], }
    getConsumableResult(resultTable)
end

function ExtraStatsInput(prevInput)
    local resultTable = prevInput
    local input = lib.inputDialog((Items[prevInput.item].label or prevInput.item).." - Extra Stats", {
        { type = "select", label = "Buff Type", description = "These are 'gradual' buff effects", default = "none", options = {
            { value = "none", label = "None" },
            { value = "heal", label = "Healing" },
            { value = "stamina", label = "Stamina" },
            { value = "armor", label = "Armour" },
            { value = "stress", label = "Stress" },
            { value = "swimming", label = "Swimming" },
            { value = "hacking", label = "Hacking" },
            { value = "intelligence", label = "Intelligence" },
            { value = "luck", label = "Luck" },
            { value = "strength", label = "Strength" },
        }},
        { type = "select", label = "Screen Effect", default = "none", options = {
            { value = "none", label = "None" },
            { value = "rampage", label = "Rampage" },
            { value = "turbo", label = "Turbo" },
            { value = "focus", label = "Focus" },
            { value = "weed", label = "Weed" },
            { value = "trevor", label = "Trevor" },
            { value = "nightvision", label = "Night Vision" },
            { value = "thermal", label = "Thermal Vision" },
        }},
        { type = "number", label = "Total Time of 'Buff'", default = 10000, },
        { type = "number", label = "Amount to give per second", default = 6, },
        ((prevInput.type ~= "food" and prevInput.type ~= "drink") and { type = "select", label = "Wide Pupils", default = "false", options = {
            { value = "true", label = "True" },
            { value = "false", label = "False" },
        }} or nil),
        ((prevInput.type ~= "food" and prevInput.type ~= "drink") and { type = "select", label = "Can Over Dose", default = "false", options = {
            { value = "true", label = "True" },
            { value = "false", label = "False" },
        }} or nil),
    })
    if not input or not input[1] then return end
    resultTable["stats"] = {
        hunger = resultTable["stats"] and resultTable["stats"].hunger or 0,
        thirst = resultTable["stats"] and resultTable["stats"].thirst or 0,
        screen = input[2] or nil,
        effect = input[1] or nil,
        time = input[1] ~= "none" and input[3] or nil,
        amount = input[1] ~= "none" and input[4] or nil,
        widepupils = input[5],
        canOD = input[6],
    }
    getConsumableResult(resultTable)
end

function getConsumableResult(data)
    local resultString = '["'..data.item..'"] = { '
    resultString = resultString..'emote = "'..data.emote..'", '
    resultString = resultString.."canRun = true, "
    resultString = resultString.."time = {"..data.time[1]..", "..data.time[2].."}, "
    resultString = (data.stress > 0 and resultString.."stress = "..data.stress..", ") or resultString..""
    resultString = (data.heal > 0 and resultString.."heal = "..data.heal..", ") or resultString..""
    resultString = (data.armor > 0 and resultString.."armor = "..data.armor..", ") or resultString..""
    resultString = resultString..'type = "'..data.type..'", '
    if data.type == "pack" then
        resultString = resultString..'pack = { item = "'..data.pack.item..'", amount = "'..data.pack.amount..'", }, '
    end
    if data.stats then
        resultString = resultString.."stats = { "
        if data.stats.hunger and type(data.stats.hunger) == "table" then
            resultString = resultString..'hunger = { '..data.stats.hunger[1]..', '..data.stats.hunger[2]..' }, '
        end
        if data.stats.thirst and type(data.stats.thirst) == "table" then
            resultString = resultString..'thirst = { '..data.stats.thirst[1]..', '..data.stats.thirst[2]..' }, '
        end
        if data.stats.screen and data.stats.screen ~= "none" then
            resultString = resultString..'screen = "'..data.stats.screen..'", '
        end
        if data.stats.effect and data.stats.effect ~= "none" then
            resultString = resultString..'effect = "'..data.stats.effect..'", '
            resultString = resultString..'time = "'..data.stats.time..'", '
            resultString = resultString..'amount = "'..data.stats.amount..'", '
        end
        if data.stats.widepupils == "true" then
            resultString = resultString..'widepupils = "'..data.stats.widepupils..'", '
        end
        if data.stats.canOD == "true" then
            resultString = resultString..'canOD = "'..data.stats.canOD..'", '
        end
    end
    triggerNotify(nil, "Copied new consumable info to clipboard", "success")
    lib.setClipboard(resultString .. " },")
end

RegisterNetEvent("jim-consumables:client:testEmotes", function()
    local Menu = {}
    for k, v in pairsByKeys(Emotes) do
        Menu[#Menu+1] = {
            header = k,
            onSelect = function()
                testEmote(v, k)
            end
        }
    end
    openMenu(Menu, { header = "Test Consumable Emotes" })
end)

function testEmote(emote, name)
    triggerNotify(nil, "Testing "..name, "warning")
    triggerNotify(nil, "Anim will loop twice then return to menu", "warning")
    local MovementType = nil
    local Player = PlayerPedId()
    local InVehicle = IsPedInAnyVehicle(Player, true)

	local animDict, anim = tostring(emote[1]), tostring(emote[2])
	local model, model2, bone, bone2
	local P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12 = table.unpack({0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}) -- Default placement coord cariable
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
    if InVehicle == 1 then
        MovementType = 51
    elseif emote.AnimationOptions then
        if emote.AnimationOptions.EmoteMoving then MovementType = 51
        elseif emote.AnimationOptions.EmoteLoop then MovementType = 1
        elseif emote.AnimationOptions.EmoteStuck then MovementType = emote.AnimationOptions.EmoteMoving and 50 or 2
        elseif emote.AnimationOptions.EmoteMoving == false then	MovementType = 0 end
    end

    playAnim(animDict, anim, (GetAnimDuration(animDict, anim) * 1000 )*2, MovementType)
    local consuming = true
    --Prop Spawning
    CreateThread(function()
        if model then
            if IsModelValid(model) == 1 then
                triggerNotify(nil, "Debug: Spawning consumable prop")
                attachProp = makeProp({ prop = model, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                AttachEntityToEntity(attachProp, Player, bone, P1, P2, P3, P4, P5, P6, true, true, false, true, 1, true)
                if model2 then
                    triggerNotify(nil, "Debug: Spawning consumable prop 2")
                    if IsModelValid(model2) == 1 then
                        attachProp2 = makeProp({ prop = model2, coords = vector4(0.0,0.0,0.0,0.0)}, 1, 1)
                        AttachEntityToEntity(attachProp2, Player, bone2, P7, P8, P9, P10, P11, P12, true, true, false, true, 1, true)
                    else triggerNotify(nil, "Debug: Second prop model isn't valid", "error") end
                end
                while consuming do Wait(50) end
                if DoesEntityExist(attachProp) then destroyProp(attachProp) attachProp = nil end
                if DoesEntityExist(attachProp2) then destroyProp(attachProp2) attachProp2 = nil end
            else triggerNotify(nil, "Debug: Prop model isn't valid", "error") end
        end
    end)
    Wait((GetAnimDuration(animDict, anim) * 1000)*2)
    consuming = false
    stopAnim(animDict, anim)
    TriggerEvent("jim-consumables:client:testEmotes")
end