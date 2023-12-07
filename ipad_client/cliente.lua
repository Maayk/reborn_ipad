RebornCore = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if RebornCore == nil then
            TriggerEvent('RebornCore:GetObject', function(obj) RebornCore = obj end)
            Citizen.Wait(200)
        end
    end
end)

local clima = ''

RegisterCommand('tablet',function(source,args,rawCommand)
	local jogador1 = PlayerPedId()
	if jogador1 then
        TriggerEvent('RebornCore:OpeniPad:Client')
	end	
end)


RegisterNetEvent("RebornCore:OpeniPad:Client")
AddEventHandler("RebornCore:OpeniPad:Client", function()
    SendNUIMessage({
        action = "abrir",
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent("RebornCore:Receive:UpdatedClima")

local climaDescriptions = {
    ["EXTRASUNNY"] = "Clima limpo",
    ["CLEAR"] = "Clima limpo",
    ["NEUTRAL"] = "Poucas nuvens",
    ["SMOG"] = "Nublado",
    ["FOGGY"] = "Extremamente nublado",
    ["OVERCAST"] = "Tempo fechado",
    ["CLOUDS"] = "Clima ameno",
    ["CLEARING"] = "Chuva moderada",
    ["RAIN"] = "Chuva moderada",
    ["THUNDER"] = "Tempestade",
    ["SNOW"] = "Geada",
    ["BLIZZARD"] = "Nevasca",
    ["SNOWLIGHT"] = "Geada moderada",
    ["XMAS"] = "Neve consistente",
}

AddEventHandler("RebornCore:Receive:UpdatedClima", function(xclima)
    local clima = climaDescriptions[xclima] or "Desastre natural"
    print(clima)
end)

RegisterNUICallback("FechariPad", function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("Policia:Login", function(data, cb)
    RebornCore.Functions.TriggerCallback('Reborn:PainelPolicia:CheckLogin', function(result)
        SendNUIMessage({
            action = "LoginResult",
			resultadologin = result,
        })
    end, data.login,data.senha)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1350)

        local playerPed = GetPlayerPed(-1)

        local monthNames = {
            "Janeiro", "Fevereiro", "Março", "Abril",
            "Maio", "Junho", "Julho", "Agosto",
            "Setembro", "Outubro", "Novembro", "Dezembro"
        }

        local month = monthNames[GetClockMonth() + 1] or "Mês Desconhecido"
        local dayOfMonth = GetClockDayOfMonth()

        local hour = GetClockHours()
        local minute = GetClockMinutes()

        hour = (hour <= 9) and "0" .. hour or hour
        minute = (minute <= 9) and "0" .. minute or minute

        local datacidade = string.format("%d de %s", dayOfMonth, month)
        local horario = string.format("%s:%s", hour, minute)

        local temperatura = exports.reborn_tmp.getCurrentTemperature()

        SendNUIMessage({
            action = "updateInfo",
            horario = horario,
            datacidade = datacidade,
            temperatura = temperatura,
            tempmin = temperatura * 0.89,
            tempmax = temperatura * 1.12,
            clima = clima,
        })
    end
end)