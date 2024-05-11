if GetResourceState('es_extended') == 'missing' then
    return
end

local ESX = exports['es_extended']:getSharedObject()

function GetAccount(id, account)
    local xPlayer = ESX.GetPlayerFromId(id)
    local accBal = xPlayer.getAccount(account).money
    return accBal
end

function RemoveMoney(id, account, amount)
    local xPlayer = ESX.GetPlayerFromId(id)
    xPlayer.removeAccountMoney(account, amount)
end

function GiveKeys(plate)
    local plate = ESX.Math.Trim(plate)
end