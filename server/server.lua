local Consumables = Config.Consumables
local Emotes = Config.Emotes

onResourceStart(function()
    for k, v in pairs(Config.Consumables) do
        createUseableItem(k, function(source, item) TriggerClientEvent(getScript()..':Consume', source, item.name) end)
        if not Items[k] then print("^1Debug^7: ^2Item check ^7- '^1"..k.."^7' ^2not found in the shared lua^7") end
        if not Config.Emotes[v.emote] then print("^1Debug^7: ^2Emote check ^7- '^1"..k.."^7' ^2requested emote ^7'^6"..v.emote.."^7' - ^2not found in config^7.^2lua^7") end
    end

    --Export Import System--
    GlobalState.jimConsumableItems = Consumables
    GlobalState.jimConsumableEmotes = Emotes
end, true)

onResourceStop(function()
    GlobalState.jimConsumableItems = Consumables
    GlobalState.jimConsumableEmotes = Emotes
end)

RegisterNetEvent(getScript()..':server:addNeed', function(amount, type)
    local src = source

    if Core.Functions and Core.Functions.GetPlayer then -- QBCore/QBox
        local Player = Core.Functions.GetPlayer(src)
        if not Player then return end

        if type == "thirst" then
            Player.Functions.SetMetaData('thirst', amount)
            TriggerClientEvent('hud:client:UpdateNeeds', src, Player.PlayerData.metadata.hunger, amount)
        elseif type == "hunger" then
            Player.Functions.SetMetaData('hunger', amount)
            TriggerClientEvent('hud:client:UpdateNeeds', src, amount, Player.PlayerData.metadata.thirst)
        end

    elseif ESX and ESX.GetPlayerFromId then -- ESX
        local xPlayer = ESX.GetPlayerFromId(src)
        if not xPlayer then return end

        local hunger = xPlayer.get('hunger') or 0
        local thirst = xPlayer.get('thirst') or 0

        if type == "thirst" then
            thirst = amount
            xPlayer.set('thirst', thirst)
        elseif type == "hunger" then
            hunger = amount
            xPlayer.set('hunger', hunger)
        end

        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, thirst)
    end
end)

local syncScheduled = false
function syncConsumables()
	debugPrint("^5Statebag^7: ^2Sending ^6"..countTable(Consumables).." ^3Consumables ^2to all clients^7")
    GlobalState.jimConsumableItems = Consumables
    syncScheduled = false
end

local emoteSyncScheduled = false
function syncEmotes()
	debugPrint("^5Statebag^7: ^2Sending ^6"..countTable(Emotes).." ^3Emotes to all clients^7")
    GlobalState.jimConsumableEmotes = Emotes
    emoteSyncScheduled = false
end

RegisterNetEvent(getScript()..':server:syncAddItem', function(itemName, data)
    if not Consumables[itemName] then
        Consumables[itemName] = data
        createUseableItem(itemName, function(source, item) TriggerClientEvent(getScript()..':Consume', source, itemName) end)
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