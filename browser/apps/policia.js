var login = false

$(document).ready(function(){
    console.log(login)
   if(login === true){
    $(".pagina-inicial").css({ "display": "none" })
    $(".pagina-2").css({ "display": "block" })
   }else{
    $(".pagina-2").css({ "display": "none" })
    $(".pagina-inicial").css({ "display": "block" })
   }
});

window.addEventListener('message', function(event) {
    switch(event.data.action) {
        case "LoginResult":
            if(event.data.resultadologin === true){
                $(".resultado-login").fadeOut('fast')
                $(".resultado-login").fadeIn('fast')
                $('.resultado-login').html('Sucesso, redirecionando...');
                $(".resultado-login").css({ "background-color": "#bdffba70" })
                console.log(event.data.resultadologin)
                setTimeout(function(){
                    $(".pagina-inicial").css({ "display": "none" })
                    $(".pagina-2").css({ "display": "block" })
                }, 2500);
                login = true
            }else{
                $(".resultado-login").fadeOut('fast')
                $(".resultado-login").fadeIn('fast')
                $('.resultado-login').html('login ou senha incorreta.');
                $(".resultado-login").css({ "background-color": "#ffc1c170" })
                console.log(event.data.resultadologin)
            }
        break;
    }
});


$(document).on("click", ".fazer-login", function(e){
    // console.log(login,senha)
    $.post("https://reborn_ipad/Policia:Login", JSON.stringify({
        login: document.getElementById("login-usuario").value,
        senha: document.getElementById("senha-usuario").value,
    }));
    document.getElementById("login-usuario").value = ""
    document.getElementById("senha-usuario").value = ""
});

$(document).on("click", ".fazer-logoff", function(e){
    console.log(login)
    if(login === true){
        login = false
        $('.resultado-login').html('Conta deslogada com sucesso');
        $(".resultado-login").css({ "background-color": "#bdffba70" })
        $(".pagina-2").css({ "display": "none" })
        $(".pagina-inicial").css({ "display": "block" })
    }
});