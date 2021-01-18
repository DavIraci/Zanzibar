$(document).ready(function () {
    load();

    // al click del tasto per inserire un nuovo impiegato verifica se il form è valido
    $('#addNewEmployeeBtn').click(function() {
        if($('form#newEmployeeForm')[0].checkValidity())
            registerNewEmployee();
    });
});

// Impiegati restituiti dal server
var employees;

// carica tutti gli impiegati
function load(){
    $('#employees-message-alert').html("");
    $.ajax({
        url: './employeesManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'GetEmployees'
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm'){ //Dati ok
                employees=data.EMPLOYEES;
                if (employees.length==0){
                    //Messaggio nessun ordine
                    let text = '<div class="row" style="justify-content: center">' +
                        '<div class="alert alert-info alert-dismissible" role="alert">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>Non sono ancora stati inseriti impiegati</div></div>';
                    $('#employees-message-alert').append(text);
                }else
                    setEmployees();
            }
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Mette le righe nella tabella per ogni impiegato
function setEmployees(){
    $('#employeesRow').html("");
    $.each(employees, function(key, val){
        text='<tr>'+
                '<th scope="row">'+zeropadInt(val.idUtente,4)+'</th>' +
                '<td>'+ val.nome + '</td>'+
                '<td>'+ val.cognome +'</td>'+
                '<td class="text-center">'+val.ruolo+'</td>'+
                '<td class="text-center"><input type="button" class="btn btn-info active" id="changeRoleBtn" value="Cambia ruolo" onclick="changeRoleConfirm('+val.idUtente+')"></td>'+ // BOTTONE CAMBIO STATO
                '<td class="text-center"><input type="button" class="btn btn-danger active" id="disableUserBtn" value="Disabilita" onclick="disableUserConfirm('+val.idUtente+')"></td>'+ // BOTTONE DETTAGLI
            '</tr>';
        $('#employeesRow').append(text);
    });
}

// Dato l'ID restituisce l'impiegato salvato nella variabile locale
function employeesByID(id){
    let i=0;
    $.each(employees, function(key, val){
        if(val.idUtente===id) {
            return false;
        }
        i++;
    });
    return employees[i];
}

// Mostra il modal per la scelta del ruolo e la conferma
function changeRoleConfirm(id){
    $('#employeesResponseMessageLabel').html("Conferma cambio ruolo");
    let user=employeesByID(id);
    text = 'Cambia il ruolo dell\'impiegato <b>' + user.cognome + '</b> in:<br>' +
            '<select class="form-control" id="newRoleSelect" onchange="checkNewRole()">' +
            '   <option value="" selected disabled hidden> --Seleziona un ruolo-- </option> ' +
            '   <option value="Admin">Amministratore</option>' +
            '   <option value="CashDesk">Cassa/Banco</option>' +
            '   <option value="Lifeguard">Bagnino</option>' +
            '   <option value="Cook">Cucina</option>' +
            '</select>';
    $('#employeesResponseMessageText').html(text);
    text='<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
         +'<button type="button" class="btn btn-primary disabled" id="changeRoleConfirmBtn" onclick="changeRole('+id+')" disabled>Conferma</button>';

    $('#changeRoleConfirm').removeClass('d-none').html(text);
    $('#employeesResponseMessageModal').modal('show');
}

// Abilita il pulsante per il cambio ruolo
function checkNewRole(){
    if($('#newRoleSelect').val()!=null){
        $('#changeRoleConfirmBtn').removeAttr("disabled").removeClass("disabled");
    }else{
        $('#changeRoleConfirmBtn').attr("disabled").addClass("disabled");
    }
}

// Richiesta al server per il cambio del ruolo con messaggio di risultato
function changeRole(id){
    let newRole = $('#newRoleSelect').val();
    $.ajax({
        url: './employeesManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'ChangeRole',
            'EmployeesID': id,
            'Role' : newRole
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#employeesResponseMessageLabel').html("Conferma");
            else
                $('#employeesResponseMessageLabel').html("Errore");
            $('#employeesResponseMessageText').html(data.MESSAGE);
            $('#changeRoleConfirm').addClass('d-none');
            $('#employeesResponseMessageModal').modal('show');
            setTimeout(function(){ $('#employeesResponseMessageModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Mostra il modal per la conferma della cancellazione dell'utenza
function disableUserConfirm(id) {
    $('#employeesResponseMessageLabel').html("Conferma disattivazione impiegato");
    let user = employeesByID(id);
    text = 'Confermi di voler disattivare l\'impiegato <b>' + user.cognome + '</b>?<br>' +
        'La modifica apportata sarà irreversibile, in caso si dovrà creare un nuovo account!';
    $('#employeesResponseMessageText').html(text);
    text = '<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
        + '<button type="button" class="btn btn-primary disabled" id="disableUserConfirmBtn" onclick="disableUser(' + id + ')" disabled>Conferma</button>';
    $('#changeRoleConfirm').removeClass('d-none').html(text);
    $('#employeesResponseMessageModal').modal('show');

    setTimeout(function(){ $('#disableUserConfirmBtn').removeAttr("disabled").removeClass("disabled"); }, 1500);
}

// Richiesta al server di disattivazione utenza con messaggio di risultato
function disableUser(id){
    $.ajax({
        url: './employeesManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'DisableEmployees',
            'EmployeesID': id
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#employeesResponseMessageLabel').html("Conferma");
            else
                $('#employeesResponseMessageLabel').html("Errore");
            $('#employeesResponseMessageText').html(data.MESSAGE);
            $('#changeRoleConfirm').addClass('d-none');
            $('#employeesResponseMessageModal').modal('show');
            setTimeout(function(){ $('#employeesResponseMessageModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Richiesta server per la registrazione di un nuovo impiegato con messaggio di risultato
function registerNewEmployee(){
    $('#registerEmployeeModal').modal('hide');
    let nome = $('#name').val();
    let cognome = $('#surname').val();
    let cellulare = $('#mobile').val();
    let email = $('#email').val();
    let password = $('#pwd1').val();
    let role = $('#role').val();
    let telefono = $('#telephone').val();
    let nascita = $('#birth').val();
    $.ajax({
        url: './employeesManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'NewEmployees',
            'username': nome,
            'surname': cognome,
            'mobile': cellulare,
            'email': email,
            'password': password,
            'role': role,
            'telephone': telefono,
            'birth': nascita
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#employeesResponseMessageLabel').html("Conferma");
            else
                $('#employeesResponseMessageLabel').html("Errore");
            $('#employeesResponseMessageText').html(data.MESSAGE);
            $('#changeRoleConfirm').addClass('d-none');
            $('#employeesResponseMessageModal').modal('show');
            resetNewEmployee();
            setTimeout(function(){ $('#employeesResponseMessageModal').modal('hide'); }, 2500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Svuota i campi input text
function resetNewEmployee(){
    $('#name').val("");
    $('#surname').val("");
    $('#mobile').val("");
    $('#email').val("");
    $('#pwd1').val("");
    $('#role').val("");
    $('#telephone').val("");
    $('#birth').val("");
}