RegisterNetEvent('cy_craftableitem:closeinv', function()
    exports.ox_inventory:closeInventory()
end)

lib.callback.register('cy_craftableitem:begincrafting', function(itemName)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
        label = 'Laver ' .. itemName .. '...',
        anim = {
            dict = 'amb@prop_human_parking_meter@male@idle_a',
            clip = 'idle_a'
        },
    }) then
        return true
    else
        return false
    end
end)
