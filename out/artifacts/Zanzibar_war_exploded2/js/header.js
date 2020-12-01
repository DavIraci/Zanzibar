function validatePasswordConf() {
    var messaggio = "Le password non corrispondono";

    // Variabili che contengono i dati inseriti dall'utente nel form di registrazione.
    var password = document.getElementById("pwd1");
    var password_conf = document.getElementById("pwd2");

    // Controlli sui pattern richiesti per tutti i campi.
    if (password.value != password_conf.value) {
        password_conf.setCustomValidity(messaggio);
        return false;
    } else {
        password_conf.setCustomValidity('');
        return true;
    }
}

function showResetPwd() {
    $('#loginModal').modal('hide');
    $('#resetmail').val($('#uname').val());
    $('#resetPasswordModal').modal('show');
}