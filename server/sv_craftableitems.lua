function sendLogs(color, name, message, footer, logs)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
  
    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function craftitems()
    for k, v in ipairs(Config.CraftItems) do
        local craftItem = exports.ox_inventory:registerHook('swapItems', function(payload)
            if payload.action == 'swap' then
                local fromItem = payload.fromSlot.name
                local toItem = payload.toSlot.name
                local player = payload.toInventory
                if fromItem == v.first_item and toItem == v.second_item then
                    local removefirst = exports.ox_inventory:RemoveItem(player, v.first_item, v.first_item_amount)
                    local removesecond = exports.ox_inventory:RemoveItem(player, v.second_item, v.second_item_amount)
                    if removefirst and removesecond then
                        lib.callback('cy_craftableitem:begincrafting',player, function(success)
                            if success then
                                exports.ox_inventory:AddItem(player, v.crafted_item, v.crafted_item_amount)
                                TriggerClientEvent('cy_craftableitem:closeinv', player)
                                sendLogs(7730498, "CY CRAFTABLE ITEMS", "Player: ".. player .. "\nItem 1: " ..v.first_item.. "\nItem 2: "..v.second_item.."\nCrafted: "..v.crafted_item.."\n", "Lavet af Notepad", Config.Craftlog)
                            end
                        end, v.crafted_item_progress_name)
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
