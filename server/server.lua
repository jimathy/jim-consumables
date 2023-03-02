local QBCore = exports[Config.Core]:GetCoreObject()

local Consumables = Config.Consumables
local Emotes = Config.Emotes

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

RegisterNetEvent('jim-consumables:server:addNeed', function(amount, type)
    local Player = QBCore.Functions.GetPlayer(source) if not Player then return end
	if type == "thirst" then
		Player.Functions.SetMetaData('thirst', amount)
		TriggerClientEvent('hud:client:UpdateNeeds', source, Player.PlayerData.metadata.hunger, amount)
	elseif type == "hunger" then
		Player.Functions.SetMetaData('hunger', amount)
		TriggerClientEvent('hud:client:UpdateNeeds', source, amount, Player.PlayerData.metadata.thirst)
	end
end)

if Config.Inv == "ox" then
	function HasItem(src, items, amount)
		local count = exports.ox_inventory:Search(src, 'count', items)
		if exports.ox_inventory:Search(src, 'count', items) >= (amount or 1) then if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^5FOUND^7 x^3"..count.."^7 ^3"..tostring(items)) end return true
        else if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^1NOT FOUND^7") end return false end
	end
else
	function HasItem(source, items, amount)
		local amount, count = amount or 1, 0
		local Player = QBCore.Functions.GetPlayer(source)
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3"..tostring(items).."^7'") end
		for _, itemData in pairs(Player.PlayerData.items) do
			if itemData and (itemData.name == items) then
				if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Item^7: '^3"..tostring(items).."^7' ^2Slot^7: ^3"..itemData.slot.." ^7x(^3"..tostring(itemData.amount).."^7)") end
				count += itemData.amount
			end
		end
		if count >= amount then if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^5FOUND^7 x^3"..count.."^7") end return true end
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^1NOT FOUND^7") end	return false
	end
end

--Export Import System--
QBCore.Functions.CreateCallback('jim-consumables:server:syncConsumables', function(source, cb) cb(Consumables) end)
QBCore.Functions.CreateCallback('jim-consumables:server:syncEmotes', function(source, cb) cb(Emotes) end)

RegisterNetEvent('jim-consumables:server:syncAddItem', function(itemName, data)
	if not Consumables[itemName] then
		QBCore.Functions.CreateUseableItem(itemName, function(source, item) TriggerClientEvent('jim-consumables:Consume', source, itemName) end)
		if Config.Debug then print("^5Debug^7: ^2Adding new ^3Item^7: '^6"..itemName.."^7'") end
		Consumables[itemName] = data
		TriggerClientEvent("jim-consumables:client:syncConsumables", -1, Consumables)
	end
end)

RegisterNetEvent('jim-consumables:server:syncAddEmote', function(emoteName, data)
	if not Emotes[emoteName] then
		if Config.Debug then print("^5Debug^7: ^2Adding new ^3Emote^7: '^6"..emoteName.."^7'") end
		Emotes[emoteName] = data
		TriggerClientEvent("jim-consumables:client:syncEmotes", -1, Emotes)
	end
end)

RegisterNetEvent("jim-consumables:server:syncConsumables", function() TriggerClientEvent('jim-consumables:client:syncConsumables', -1, Consumables) end)
RegisterNetEvent("jim-consumables:server:syncEmotes", function() TriggerClientEvent('jim-consumables:client:syncEmotes', -1, Emotes) end)

local function CheckVersion()
	PerformHttpRequest('https://raw.githubusercontent.com/jimathy/jim-consumables/master/version.txt', function(err, newestVersion, headers)
		local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
		if not newestVersion then print("Currently unable to run a version check.") return end
		local advice = "^1You are currently running an outdated version^7, ^1please update^7"
		if newestVersion:gsub("%s+", "") == currentVersion:gsub("%s+", "") then advice = '^6You are running the latest version.^7'
		else print("^3Version Check^7: ^2Current^7: "..currentVersion.." ^2Latest^7: "..newestVersion) end
		print(advice)
	end)
end
CheckVersion()