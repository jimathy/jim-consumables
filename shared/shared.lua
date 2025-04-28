function tempLockInv(toggle)
    LocalPlayer.state:set("inv_busy", toggle, true)
    TriggerEvent('inventory:client:busy:status', toggle)
    TriggerEvent('canUseInventoryAndHotbar:toggle', not toggle)
end

function GenerateRandomValues(data)
    local transData = {}
    for k, v in pairs(data) do
        if type(v) == "table" then
            debugPrint("Converting Table "..json.encode(v).." to math.random")
            transData[k] = math.random(v[1], v[2])
            debugPrint("Translated value: "..k.." - "..transData[k])
        else
            transData[k] = v
        end
    end
    return transData["time"],
           transData["stress"],
           transData["heal"],
           transData["armor"],
           { hunger = transData["hunger"], thirst = transData["thirst"] }
end