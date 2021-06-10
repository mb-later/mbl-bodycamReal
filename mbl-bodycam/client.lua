local acik, RLCore, PlayerData, cender = false, nil, nil, nil


Citizen.CreateThread(function ()
    while RLCore == nil do
        Citizen.Wait(0)
        TriggerEvent("RLCore:GetObject", function (obj) RLCore = obj
        end)
        while RLCore.Functions.GetPlayerData() == nil do
            Citizen.Wait(10)
        end
        PlayerData = RLCore.Functions.GetPlayerData()
    end
end)

RegisterNetEvent("RLCore:Client:OnJobUpdate")
AddEventHandler("RLCore:Client:OnJobUpdate", function (meslk)
    PlayerData.job = meslk
end)

local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] = GetLocalTime()

RegisterNetEvent("bodycam:time")
AddEventHandler("bodycam:time", function (h,m,s)
    SendNUIMessage({
        action = "zamanguncelle",
        zaman = day.."/"..month.."/"..year.." ".." - "..h..":"..m..":"..s.." GMT+3",
    })
end)

RegisterNetEvent("mbl-body:openBoy")
AddEventHandler("mbl-body:openBoy", function (item, h,m,s)
    if PlayerData.job.name == "police" then
        if item.info.cinsiyet == "0" then
            cender = "Mr."
        else
            cender = "Mrs."
        end
        if acik then
            acik = false
            SendNUIMessage({
                action = "hidebodycam"
            })
            TriggerServerEvent("booleanuodate", false)

        else
            SendNUIMessage({
                action = "showbodycam",
                player = item.info.grade.. " "..cender.." "..item.info.firstname,
                callsign = "["..item.info.callsign.."]",
                tarih = day.."/"..month.."/"..year.." ".." - "..h..":"..m..":"..s.." GMT+3",
            })
            TriggerServerEvent("booleanuodate", true)
            acik = true
        end
    end
end)