if GetResourceState('qb-core') == 'missing' then
    return
end

local QBCore = exports['qb-core']:GetCoreObject()

function GetAccount(id, account)
    local xPlayer = QBCore.Functions.GetPlayer(id)
    local accBal = xPlayer.PlayerData.money[account]
    return accBal
end

function RemoveMoney(id, account, amount)
    local xPlayer = QBCore.Functions.GetPlayer(id)
    xPlayer.Functions.RemoveMoney(account, amount)
end

function GiveKeys(id, plate)
    local plate = QBCore.Shared.Trim(plate)
    TriggerClientEvent('qb-vehiclekeys:client:AddKeys', id, plate)
end