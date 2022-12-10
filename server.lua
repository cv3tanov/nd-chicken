local NDCore = exports['nd-core']:GetCoreObject()

RegisterServerEvent('nd-chickenjob:getNewChicken')
AddEventHandler('nd-chickenjob:getNewChicken', function()
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)
    local pick = ''

      if TriggerClientEvent("NDCore:Notify", src, "Получихте 3 живи пилета!", "Success", 8000) then
          Player.Functions.AddItem('alivechicken', 3) 
          TriggerClientEvent("nd-inventory:client:ItemBox", source, NDCore.Shared.Items['alivechicken'], "add")
      end
end)

RegisterServerEvent('nd-chickenjob:startChicken')
AddEventHandler('nd-chickenjob:startChicken', function()
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)

      if TriggerClientEvent("NDCore:Notify", src, "Да хванем малко пилета!", "Success", 8000) then
        -- Player.Functions.RemoveMoney('cash', 500)        
      end
end)

RegisterServerEvent('nd-chickenjob:getcutChicken')
AddEventHandler('nd-chickenjob:getcutChicken', function()
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)
    local pick = ''

      if TriggerClientEvent("NDCore:Notify", src, "Добре! Ти закла пиле.", "Success", 8000) then
          Player.Functions.RemoveItem('alivechicken', 1)
          Player.Functions.AddItem('slaughteredchicken', 1)
          TriggerClientEvent("nd-inventory:client:ItemBox", source, NDCore.Shared.Items['alivechicken'], "remove")
          TriggerClientEvent("nd-inventory:client:ItemBox", source, NDCore.Shared.Items['slaughteredchicken'], "add")
      end
end)

RegisterServerEvent('nd-chickenjob:getpackedChicken')
AddEventHandler('nd-chickenjob:getpackedChicken', function()
    local src = source
    local Player = NDCore.Functions.GetPlayer(src)
    local pick = ''

      if TriggerClientEvent("NDCore:Notify", src, "Опаковахте заклано пиле.", "Success", 8000) then
          Player.Functions.RemoveItem('slaughteredchicken', 1)
          Player.Functions.AddItem('packagedchicken', 1)
          TriggerClientEvent("nd-inventory:client:ItemBox", source, NDCore.Shared.Items['slaughteredchicken'], "remove")
          TriggerClientEvent("nd-inventory:client:ItemBox", source, NDCore.Shared.Items['packagedchicken'], "add")
      end
end)


local ItemList = {
    --["packagedchicken"] = math.random(50, 100),
    ["packagedchicken"] = (25),
}

RegisterServerEvent('nd-chickenjob:sell')
AddEventHandler('nd-chickenjob:sell', function()
    local src = source
    local price = 0
    local Player = NDCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        Player.Functions.AddMoney("cash", price, "sold-items")
        TriggerClientEvent('NDCore:Notify', src, 'Продадохте своите артикули за '..price..'$')
    else
        TriggerClientEvent('NDCore:Notify', src, "Няма какво да продадете")
    end
end)


