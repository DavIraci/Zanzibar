$(document).ready(function () {

    // Cattura l'invio del form di registrazione
    $('#registerForm').submit(function (e) {
        e.preventDefault();
        signIn();
    });

    // Cattura l'invio del form di reset password
    $('#resetPasswordModal').submit(function (e) {
        e.preventDefault();
        resetPassword();
    });
});

// Verifica se le password inserite nei due campi combacino e imposta la validità
function validatePasswordConf() {
    let messaggio = "Le password non corrispondono";

    // Variabili che contengono i dati inseriti dall'utente nel form di registrazione.
    let password = document.getElementById("pwd1");
    let password_conf = document.getElementById("pwd2");

    // Controlli sui pattern richiesti per tutti i campi.
    if (password.value !== password_conf.value) {
        password_conf.setCustomValidity(messaggio);
        return false;
    } else {
        password_conf.setCustomValidity('');
        return true;
    }
}

// Mostra il modal per il reset della password
function showResetPwd() {
    $('#loginModal').modal('hide');
    $('#resetmail').val($('#uname').val());
    $('#resetPasswordModal').modal('show');
}

// Invia la richiesta al server di registrazione utente e mostra la risposta
function signIn(){
    let nome = $('#name').val();
    let cognome = $('#surname').val();
    let cellulare = $('#mobile').val();
    let email = $('#email').val();
    let password = $('#pwd1').val();
    let confPassword = $('#pwd2').val();
    let telefono = $('#telephone').val();
    let nascita = $('#birth').val();

    $.ajax({
        url: './signin',
        dataType: 'json',
        type: 'post',
        data: {
            'username': nome,
            'surname': cognome,
            'mobile': cellulare,
            'email': email,
            'password': password,
            'passwordrep': confPassword,
            'telephone': telefono,
            'birth': nascita
        },
        success: function (data) {
            let alertType=data.RESPONSE==="Confirm"?"success":"danger";
            text='<div class="alert alert-'+alertType+' alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>';
            $('#response').html(text);
            $('#registerModal').animate({scrollTop: $('#response').offset().top},'slow');
            $('#pwd1').val('');
            $('#pwd2').val('');
            if(data.RESPONSE==="Confirm")
                resetFied();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Reimposta i campi
function resetFied(){
    $('#name').val("");
    $('#surname').val("");
    $('#mobile').val("");
    $('#email').val("");
    $('#pwd1').val("");
    $('#pwd2').val("");
    $('#telephone').val("");
    $('#birth').val("");
}

// Invia la richiesta al server per reimpostare la password
function resetPassword(){
    let email = $('#resetmail').val();
    $.ajax({
        url: './resetpwd',
        dataType: 'json',
        type: 'post',
        data: {
            'email': email
        },
        success: function (data) {
            let alertType=data.RESPONSE==="Confirm"?"success":"danger";
            text='<div class="alert alert-'+alertType+' alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>';
            $('#responseResetPwd').html(text);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}