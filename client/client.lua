local currentZone = nil
local currentVeh = nil
CreateThread(function()
    local show = false
    while true do
        local inZone = false
        local sleep = 5000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        for k,v in pairs(Config.Rentals.Locations) do
            local dist = #(v.coords - playerCoords)
            if dist < 20.0 then
                sleep = 0
                DrawMarker(Config.MarkerType, v.coords.x, v.coords.y, v.coords.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, false, false, 2, false, false, false, false)
                if dist < 2.0 then
                    inZone = true
                    if not show then
                        show = true
                        lib.showTextUI('[E] - Rent a car')
                    end
                    if IsControlJustPressed(0, 38) then
                        currentZone = k
                        lib.callback('ts-rental:server:CanRent', false, function(canRent)
                            if canRent then
                                SendNUIMessage({
                                    action = 'rent',
                                    data = Config.Vehicles
                                })
                                SetNuiFocus(true, true)
                            else
                                lib.notify({
                                    title = 'Rentals',
                                    description = 'You already have a rented vehicle.',
                                    type = 'error'
                                })
                            end
                        end)
                    end
                end
            end
        end
        if currentVeh then
            for k, v in pairs(Config.Rentals.DropLocations) do
                local dist = #(v - playerCoords)
                if dist < 20.0 then
                    sleep = 0
                    DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, false, false, 2, false, false, false, false)
                    if dist < 2.0 then
                        local veh = GetVehiclePedIsIn(playerPed, false)
                        if veh ~= 0 then
                            inZone = true
                            if not show then
                                show = true
                                lib.showTextUI('[E] - Drop off car')
                            end
                            if IsControlJustPressed(0, 38) then
                                if veh == currentVeh then
                                    currentVeh = nil
                                    TriggerServerEvent('ts-rental:server:DropOffVehicle')
                                    SendNUIMessage({
                                        action = 'hideIndicator'
                                    })
                                else
                                    lib.notify({
                                        title = 'Rentals',
                                        description = 'This is not the vehicle you rented.',
                                        type = 'error'
                                    })
                                end
                            end
                        end
                    end
                end
            end
        end

        if not inZone and show then
            currentZone = nil
            show = false
            lib.hideTextUI()
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('ts-rental:client:StartTimer', function (netID, price)
    local veh = NetworkGetEntityFromNetworkId(netID)
    while not DoesEntityExist(veh) do
        Wait(500)
        veh = NetworkGetEntityFromNetworkId(netID)
    end
    currentVeh = veh
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    local timer = 0
    local vehFare = price
    while currentVeh do
        timer += 1
        if (timer % (60*60)) == 0 then -- every hour
            vehFare += price
            lib.callback('ts-rental:server:ChargePlayer', false, function(hasMoney)
                if not hasMoney then
                    currentVeh = nil
                    lib.notify({
                        title = 'Rentals',
                        description = 'You don\'t have enough money to rent this vehicle anymore.',
                        type = 'error'
                    })
                    SendNUIMessage({
                        action = 'hideIndicator'
                    })
                end
            end)
        end
        local hours = math.floor(timer / 3600)
        local minutes = math.floor(timer / 60)
        local seconds = string.format("%02d", math.floor(timer % 60))
        local timeLapsed = string.format("%02d:%02d", hours, minutes)
        SendNUIMessage({
            action = 'indicator',
            data = {
                timer = timeLapsed,
                seconds = seconds,
                fare = vehFare
            }
        })
        if not DoesEntityExist(currentVeh) then
            currentVeh = nil
            TriggerServerEvent('ts-rental:server:DropOffVehicle')
            SendNUIMessage({
                action = 'hideIndicator'
            })
        end
        Wait(1000)
    end
end)

RegisterNUICallback('selectCar', function(vehModel, cb)
    cb('ok')
    SendNUIMessage({
        action = 'hideRental'
    })
    SetNuiFocus(false, false)
    local vehExists = Config.Vehicles[vehModel]
    if vehExists then
        RequestModel(vehModel)
        TriggerServerEvent('ts-rental:server:RentVehicle', currentZone, vehModel)
    else
        lib.notify({
            title = 'Rentals',
            description = 'This vehicle is not available for rent.',
            type = 'error'
        })
    end
end)

RegisterNUICallback('hideRental', function(_, cb)
    cb('ok')
    SendNUIMessage({
        action = 'hideRental'
    })
    SetNuiFocus(false, false)
end)
