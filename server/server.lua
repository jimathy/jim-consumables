local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(Config.Consumables) do
	QBCore.Functions.CreateUseableItem(k, function(source, item) TriggerClientEvent('jim-consumables:Consume', source, item.name) end)
	if not QBCore.Shared.Items[k] then print("^1Debug^7: ^2Item check ^7- '^1"..k.."^7' ^2not found in the shared lua^7") end
	if not Config.Emotes[v.emote] then print("^1Debug^7: ^2Emote check ^7- '^1"..k.."^7' ^2requested emote ^7'^6"..v.emote.."^7' - ^2not found in config^7.^2lua^7") end
end

RegisterNetEvent("jim-consumables:server:DupeWarn", function(item, newsrc)
	local src = newsrc or source
	local P = QBCore.Functions.GetPlayer(src)
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Tried to remove item ^7('^3"..item.."^7')^2 but it wasn't there^7")
	if not Config.Debug then DropPlayer(src, "Kicked for attempting to duplicate items") end
	print("^5DupeWarn: ^1"..P.PlayerData.charinfo.firstname.." "..P.PlayerData.charinfo.lastname.."^7(^1"..tostring(src).."^7) ^2Dropped from server for item duplicating^7")
end)

RegisterNetEvent('jim-consumables:server:toggleItem', function(give, item, amount, newsrc)
	local src = newsrc or source
	local amount = amount or 1
	local remamount = amount
	if not give then
		if HasItem(src, item, amount) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.GetItemByName(item).unique then -- If unique item, keep removing until gone
				while remamount > 0 do
					QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, 1)
					remamount -= 1
				end
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount) -- Show removal item box when all are removed
				return
			end
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount) then
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
			end
		else TriggerEvent("jim-consumables:server:DupeWarn", item, src) end -- if not boot the player
	elseif give then
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount) then
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
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

function HasItem(source, items, amount)
	local amount = amount or 1
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player then return false end
	local count = 0

	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3"..tostring(items).."^7'") end

	for _, itemData in pairs(Player.PlayerData.items) do
		if itemData and (itemData.name == items) then
			if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Item^7: '^3"..tostring(items).."^7' ^2Slot^7: ^3"..itemData.slot.." ^7x(^3"..tostring(itemData.amount).."^7)") end
			count += itemData.amount
		end
	end
	if count >= amount then
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^5FOUND^7 x^3"..count.."^7") end
		return true
	end
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^1NOT FOUND^7") end
	return false
end

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
