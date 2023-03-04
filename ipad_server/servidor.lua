RebornCore = nil
TriggerEvent('RebornCore:GetObject', function(obj) RebornCore = obj end)

RebornCore.Functions.CreateUseableItem("ipad", function(source, item)
    local Player = RebornCore.Functions.GetPlayer(source)
    TriggerClientEvent('RebornCore:OpeniPad:Client', source)
end)

RebornCore.Functions.CreateCallback('Reborn:PainelPolicia:CheckLogin', function(source,cb, login, senha)
    local src = source
    local Player = RebornCore.Functions.GetPlayer(src)
    local rg = Player.PlayerData.citizenid
    RebornCore.Functions.ExecuteSql(false, "SELECT * FROM `policia_usuarios` WHERE `identidade` LIKE '"..rg.."'", function(resultado)
        if resultado[1] ~= nil then
            if resultado[1].Login == login and resultado[1].senha == senha then
                print('login e senha certa')
                cb(true)
            else
                print('login e senha errada')
                cb(false)
            end
        end
    end)
end)