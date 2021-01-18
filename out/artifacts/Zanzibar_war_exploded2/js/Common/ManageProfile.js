$(document).ready(function () {
    $('#formManageProfile').submit(function (e) {
        e.preventDefault();
        updateInfoAccount();
    });
});

function updateInfoAccount() {
    let nome = $('#name').val();
    let cognome = $('#surname').val();
    let cellulare = $('#mobile').val();
    let email = $('#email').val();
    let password = $('#pwd1').val();
    let confPassword = $('#pwd2').val();
    let telefono = $('#telephone').val();
    let nascita = $('#birth').val();
    let checkPassword = $('#pwd3').val();

    $.ajax({
        url: './manageprofile',
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
            'birth': nascita,
            'passwordcheck': checkPassword
        },
        success: function (data) {
            if (data.RESPONSE == 'Error' && data.TYPE == 'Data insert error') {
                $('#response').html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>').show();
            } else if (data.RESPONSE == 'Error' && data.TYPE == 'Same data') {
                $('#response').html('<div class="alert alert-warning alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>').show();
            } else if (data.RESPONSE == 'Error' && data.TYPE == 'Incorrect password') {
                $('#response').html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>').show();
            } else if (data.RESPONSE == 'Error' && data.TYPE == 'Database connection') {
                $('#response').html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>').show();
            } else if (data.RESPONSE == 'Success' && data.TYPE == 'Account info updated') {
                $('#response').html('<div class="alert alert-success alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert">&times;</button>' + data.MESSAGE + '</div>').show();
            }
            $('html,body').animate({scrollTop: $('#page-top').offset().top},'slow');
            $('#pwd1').val('');
            $('#pwd2').val('');
            $('#pwd3').val('');
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

