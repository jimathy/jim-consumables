local Consumables = Config.Consumables
local Emotes = Config.Emotes
local isConsuming = {}

local function massMakeUseable()
    for k, v in pairs(Config.Consumables) do
        createUseableItem(k, function(source, item)
            local src = source
            if not isConsuming[src] and hasItem(item.name, 1, src) then

                registerConsume(src, item.name)
                TriggerClientEvent(getScript()..':Consume', src, item.name)

            end
        end)
    end
end

function registerConsume(src, item)
    -- Start building server sided item return table
    local consumable = Consumables[item]
    isConsuming[src] = {
        item = item,
        rewardItem     = checkReward(consumable) or nil,
        returnItem     = checkReturnItem(consumable) or nil,
        packItem       = checkPackItem(consumable) or nil
    }
    debugPrint("^5Debug^7: ^2Player ^3"..src.." ^2started consuming ^7'^2"..item.."^7'")
end

RegisterNetEvent(getScript()..":RegisterConsuming", function(item)
    local src = source
    registerConsume(src, item)
end)

onResourceStart(function()
    for k, v in pairs(Config.Consumables) do
        if not Items[k] then
            print("^1Debug^7: ^2Item check ^7- '^1"..k.."^7' ^2not found in the shared lua^7")
        end
        if not Config.Emotes[v.emote] then
            print("^1Debug^7: ^2Emote check ^7- '^1"..k.."^7' ^2requested emote ^7'^6"..v.emote.."^7' - ^2not found in config^7.^2lua^7")
        end
    end

    massMakeUseable()

    --Export Import System--
    GlobalState.jimConsumableItems = Consumables
    GlobalState.jimConsumableEmotes = Emotes
end, true)

onResourceStop(function()
    GlobalState.jimConsumableItems = Consumables
    GlobalState.jimConsumableEmotes = Emotes
end)

local syncScheduled = false
function syncConsumables()
	debugPrint("^5Statebag^7: ^2Sending ^6"..countTable(Consumables).." ^3Consumables ^2to all clients^7")
    massMakeUseable()
    GlobalState.jimConsumableItems = Consumables
    syncScheduled = false
end

local emoteSyncScheduled = false
function syncEmotes()
	debugPrint("^5Statebag^7: ^2Sending ^6"..countTable(Emotes).." ^3Emotes to all clients^7")
    GlobalState.jimConsumableEmotes = Emotes
    emoteSyncScheduled = false
end

-- Return item
function checkPackItem(consumable)
    local result = nil
    if consumable.pack then
        result = { item = consumable.pack.item, amount = consumable.pack.amount }
    end
    return result
end

-- Return item
function checkReturnItem(consumable)
    local result = nil
    if consumable.returnItem then
        result = { item = consumable.returnItem.item, amount = consumable.returnItem.amount }
    end
    return result
end

-- Reward items
function checkReward(consumable)
    local result = nil
    local rewardItem = consumable.rewards or nil
    if rewardItem then
        debugPrint("Reward Item detected")
        for i = 1, consumable.amounttogive or 1 do
            local rarity = math.random(1, 4) -- rarity calculation
            while true do
                local item = math.random(1, countTable(rewardItem)) -- random item in the list to pick
                if rewardItem[item].rarity >= rarity then
                    result = result or {}
                    result[#result+1] = { item = rewardItem[item].item, amount = math.random(1, rewardItem[item].max or 1) }
                    debugPrint("^5Debug^7: ^2Cachced reward prize^7: '^6"..rewardItem[item].item.."^7'")
                    break
                end
                Wait(10)
                break
            end
        end
    end
    return result
end

RegisterNetEvent(getScript()..":server:finishConsume", function(needTypes)
    local src = source

    if isConsuming[src] ~= nil then

        removeItem(isConsuming[src].item, 1, src)
        if isConsuming[src].rewardItem then
            debugPrint("^5Debug^7: ^2Giving player ^3"..src.." ^2reward items^7")
            local item = isConsuming[src].rewardItem
            addItem(item.item, item.amount, nil, src)
        end
        if isConsuming[src].returnItem then
            debugPrint("^5Debug^7: ^2Giving player ^3"..src.." ^2return item^7")
            for i = 1, #isConsuming[src].returnItem do
                local item = isConsuming[src].returnItem[i]
                addItem(item.item, item.amount, nil, src)
            end
        end
        if isConsuming[src].packItem then
            debugPrint("^5Debug^7: ^2Giving player ^3"..src.." ^2Pack items^7")
            local item = isConsuming[src].packItem
            addItem(item.item, item.amount, nil, src)
        end

        -- Needs
        if needTypes.thirst then
            debugPrint("^5Debug^7: ^2Thrist^7: [^6"..(needTypes.thirst or 0).."^7]")
            setThirst(src, needTypes.thirst)
        end
        if needTypes.hunger then
            debugPrint("^5Debug^7: ^2Hunger^7: [^6"..(needTypes.hunger or 0).."^7]")
            setHunger(src, needTypes.hunger)
        end
        if needTypes.stress then
            debugPrint("^5Debug^7: ^2Stress^7: [^6"..(needTypes.stress or 0).."^7]")
            setStress(src, needTypes.stress)
        end
        isConsuming[src] = nil
    else
        return
    end
end)

RegisterNetEvent(getScript()..":server:stopConsume", function()
    local src = source
    debugPrint("^5Player stopped consuming early^7", src)
    isConsuming[src] = nil
end)

RegisterNetEvent(getScript()..':server:syncAddItem', function(itemName, data)
    if not Consumables[itemName] then
        Consumables[itemName] = data
        --createUseableItem(itemName, function(source, item) TriggerClientEvent(getScript()..':Consume', source, itemName) end)
        debugPrint("^5Debug^7: "..GetInvokingResource().." ^2is sending new ^3Item^7: '"..itemName.."'")
        if not syncScheduled then
            syncScheduled = true
            SetTimeout(5000, syncConsumables)
        end
    else
        debugPrint("^1Debug^7: "..GetInvokingResource().." ^2is sending ^1duplicate ^3Item^7: '"..itemName.."'")
    end
end)

RegisterNetEvent(getScript()..':server:syncAddEmote', function(emoteName, data)
    if not Emotes[emoteName] then
        Emotes[emoteName] = data
        debugPrint("^5Debug^7: "..GetInvokingResource().." ^2is sending new ^3Emote^7: '"..emoteName.."'")
        if not emoteSyncScheduled then
            emoteSyncScheduled = true
            SetTimeout(5000, syncEmotes)
        end
    else
        debugPrint("^1Debug^7: "..GetInvokingResource().." ^2is sending ^1duplicate ^3Emote^7: '"..emoteName.."'")
    end
end)

--[[
Core.Commands.Add('consumableCreator', "Create consumables (admin only)", {}, false, function(source)
    if source > 0 then return TriggerClientEvent(getScript()..":client:consumableCreator", source) end
end, 'admin')

Core.Commands.Add('testConsumableEmotes', "Test consumables Emotes (admin only)", {}, false, function(source)
    if source > 0 then return TriggerClientEvent(getScript()..":client:testEmotes", source) end
end, 'admin')
]]