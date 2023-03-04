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
AddEventHandler("RebornCore:Receive:UpdatedClima", function(xclima)
    if xclima == "EXTRASUNNY" or xclima == "CLEAR" then
        clima = "Clima limpo"
    elseif xclima == "NEUTRAL" then
        clima = "Poucas nuvens"
    elseif xclima == "SMOG" then
        clima = "Nublado"
    elseif xclima == "FOGGY" then
        clima = "Extremamente nublado"
    elseif xclima == "OVERCAST" then
        clima = "Tempo fechado"
    elseif xclima == "CLOUDS" then
        clima = "Clima ameno"
    elseif xclima == "CLEARING" or xclima == "RAIN" then
        clima = "Chuva moderada"
    elseif xclima == "THUNDER" then
        clima = "Tempestade"
    elseif xclima == "SNOW" then
        clima = "Geada"
    elseif xclima == "BLIZZARD" then
        clima = "Nevasca"
    elseif xclima == "SNOWLIGHT" then
        clima = "Geada moderada"
    elseif xclima == "XMAS" then
        clima = "Neve consistente"
    else
        clima = "Desastre natural"
    end
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

Citizen.CreateThread(function ()
    while true do
	   Citizen.Wait(1350)
		local playerPed = GetPlayerPed(-1)

		month = GetClockMonth()
		dayOfMonth = GetClockDayOfMonth()
		if month == 0 then
			month = "Janeiro"
		elseif month == 1 then
			month = "Janeiro"
		elseif month == 2 then
			month = "Fevereiro"
		elseif month == 3 then
			month = "Março"
		elseif month == 4 then
			month = "Abril"
		elseif month == 5 then
			month = "Maio"
		elseif month == 6 then
			month = "Junho"
		elseif month == 7 then
			month = "Julho"
		elseif month == 8 then
			month = "Agosto"
		elseif month == 9 then
			month = "Setembro"
		elseif month == 10 then
			month = "Outubro"
		elseif month == 11 then
			month = "Novembro"
		elseif month == 12 then
			month = "Dezembro"
		end

		hour = GetClockHours()
		minute = GetClockMinutes()
		
		procurado = procurado
		if hour <= 9 then
			hour = "0" .. hour
		end
		if minute <= 9 then
			minute = "0" .. minute
		end

		datacidade = dayOfMonth.." de "..month
		horario = hour..":"..minute
        temperatura = exports.reborn_tmp.getCurrentTemperature()
		SendNUIMessage({
            action = "updateInfo",
			horario = horario,
			datacidade = datacidade,
			temperatura = temperatura,
            tempmin = temperatura*0.89,
            tempmax = temperatura*1.12,
			clima = clima,
		})
    end
end)