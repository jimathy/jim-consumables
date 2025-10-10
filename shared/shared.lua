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

    if transData.hunger > 0 then
        transData.hunger = transData.hunger > 100 and 100 or transData.hunger
    end

    if transData.thirst > 0 then
        transData.thirst = transData.thirst > 100 and 100 or transData.thirst
    end

    if transData.stress > 0 then
        transData.stress = transData.stress > 100 and 100 or transData.stress
    end

    return  transData["time"],
            transData["heal"],
            transData["armor"],
            {
                hunger = transData["hunger"] or 0,
                thirst = transData["thirst"] or 0,
                stress = transData["stress"] or 0
            }
end