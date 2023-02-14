local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(Config.Consumables) do
	QBCore.Functions.CreateUseableItem(k, function(source, item) TriggerClientEvent('jim-consumables:Consume', source, item.name) end)
	if not QBCore.Shared.Items[k] then print("^1Debug^7: ^2Item check ^7- '^1"..k.."^7' ^2not found in the shared lua^7") end
	if not Config.Emotes[v.emote] then print("^1Debug^7: ^2Emote check ^7- '^1"..k.."^7' ^2requested emote ^7'^6"..v.emote.."^7' - ^2not found in config^7.^2lua^7") end
end

RegisterNetEvent('jim-consumables:server:toggleItem', function(give, item, amount)
	local src = source
	if give == 0 or give == false then
		if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount or 1)
		end
	else
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount or 1) then
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount or 1)
		end
	end
end)

RegisterNetEvent('jim-consumables:server:addThirst', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.SetMetaData('thirst', amount)
    TriggerClientEvent('hud:client:UpdateNeeds', source, Player.PlayerData.metadata.hunger, amount)
end)

RegisterNetEvent('jim-consumables:server:addHunger', function(amount)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    Player.Functions.SetMetaData('hunger', amount)
    TriggerClientEvent('hud:client:UpdateNeeds', source, amount, Player.PlayerData.metadata.thirst)
end)

--Export Import System--
RegisterNetEvent("jim-consumables:getSync", function() local src = source TriggerClientEvent("jim-consumables:syncItems", source, Config.Consumables, Config.Emotes) end)
local function importEmote(emoteName, eInfo)
	if Config.Debug then print("^5Debug^7: ^2Importing Item ^7'^6"..emoteName.."^7'") end
	Config.Emotes[emoteName] = eInfo
	TriggerClientEvent("jim-consumables:syncItems", -1, nil, Config.Emotes)
end

local function importConsumable(itemName, conInfo)
	if Config.Debug then print("^5Debug^7: ^2Importing Item ^7'^6"..itemName.."^7'") end
	if not QBCore.Shared.Items[itemName] then print("^1Debug^7: ^2Item check ^7- '^1"..k.."^7' ^2not found in the shared lua^7") end
	Config.Consumables[itemName] = conInfo
	QBCore.Functions.CreateUseableItem(itemName, function(source, item) TriggerClientEvent('jim-consumables:Consume', source, itemName) end)
	TriggerClientEvent("jim-consumables:syncItems", -1, Config.Consumables, nil)
end

exports("importEmote", importEmote)
exports("importConsumable", importConsumable)
