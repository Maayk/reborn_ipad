var DefaultBG = "background.png"
var appativo = ""

$(document).ready(function(){
    console.log('[Reborn-iPad] - Sistema inicializado')
    console.log('[Reborn-iPad] - Default Background: '+ DefaultBG)
    $(".ipad-centerarea").css({ "background-image": "url('./imgs/"+DefaultBG+"')" })
    $(".tempo-info").css({ "backdrop-filter": "blur(4px)" })
});

$(document).on('click', '.app-policia', function(e) {
    e.preventDefault();
    $(".central-policia").fadeIn("fast")
    appativo = "central-policia"
    console.log('[Reborn-iPad] - Aplicativo iniciado: '+appativo)
});

$(document).on('click', '.app-close', function(e) {
    e.preventDefault();
    $("."+appativo).fadeOut("fast")
    console.log('[Reborn-iPad] - Aplicativo Fechado: '+appativo)
    appativo = ""
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $('.ipad-container').fadeOut('fast');
            $.post("https://reborn_ipad/FechariPad", JSON.stringify({}));
            if(appativo != ""){
                $("."+appativo).hide("fast")
            }
            break;
    }
});

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "abrir":
            $('.ipad-container').fadeIn('fast');
            break;
        case "updateInfo":
            $('.horario').html(event.data.horario);
            $('.data').html(event.data.datacidade);
            $('.temp-atual').html(parseInt(event.data.temperatura));
            $('.tipo-tempo').html(event.data.clima);
            $('.temp-minmax').html(parseInt(event.data.tempmin)+' / '+parseInt(event.data.tempmax));
            break;
    }
});
