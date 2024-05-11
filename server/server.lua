local RentedVehicles = {}
RegisterNetEvent('ts-rental:server:RentVehicle', function (zone, model)
    local src = source
    local bank = GetAccount(src, 'bank')

    local spawnCoords = Config.Rentals.Locations[zone].spawnCoords
    local vehDetails = Config.Vehicles[model]
    local price = vehDetails.price

    if bank > price then
        RemoveMoney(src, 'bank', price)
        local veh = CreateVehicleServerSetter(joaat(model), 'automobile', spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w)
        while not DoesEntityExist(veh) do Wait(0) end
        local net = NetworkGetNetworkIdFromEntity(veh)
        local currentTime = os.time()
        RentedVehicles[src] = {
            model = model,
            ent = veh,
            netID = net,
            price = price,
            time = currentTime
        }
        SetVehicleDoorsLocked(veh, 1)
        TriggerClientEvent('ts-rental:client:StartTimer', src, net, price)
        Wait(1000)
        GiveKeys(src, GetVehicleNumberPlateText(veh))
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Rentals',
            description = 'You do not have enough money to rent this vehicle',
            type = 'error'
        })
    end
end)

RegisterNetEvent('ts-rental:server:DropOffVehicle', function ()
    local src = source
    if DoesEntityExist(RentedVehicles[src].ent) then
        DeleteEntity(RentedVehicles[src].ent)
    end
    RentedVehicles[src] = nil
end)

lib.callback.register('ts-rental:server:CanRent', function(source)
    return RentedVehicles[source] == nil
end)

lib.callback.register('ts-rental:server:ChargePlayer', function(source)
    local src = source
    local bank = GetAccount(src, 'bank')
    local price = RentedVehicles[src].price
    if bank > price then
        RemoveMoney(src, 'bank', price)
        return true
    else
        DeleteEntity(RentedVehicles[src].ent)
        RentedVehicles[src] = nil
        return false
    end
end)