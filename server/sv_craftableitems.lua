function craftitems()
    for k,v in ipairs(Config.CraftItems) do
        local craftItem = exports.ox_inventory:registerHook('swapItems', function(payload)
            if payload.action == 'swap' then
                local fromItem = payload.fromSlot.name
                local toItem = payload.toSlot.name
                local player = payload.toInventory
                if fromItem == v.first_item and toItem == v.second_item then
                    local removefirst = exports.ox_inventory:RemoveItem(player, v.first_item, v.first_item_amount)
                    local removesecond = exports.ox_inventory:RemoveItem(player, v.second_item, v.second_item_amount)
                    if removefirst and removesecond then
                        exports.ox_inventory:AddItem(player, v.crafted_item, v.crafted_item_amount)
                        TriggerClientEvent('cy_craftableitem:closeinv', -1)
                    end
    
                    return false
                end
            end
            return true
        end, {
            print = false
        })
    end
end
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    craftitems()
end)
