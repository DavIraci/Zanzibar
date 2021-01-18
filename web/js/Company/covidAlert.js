$(document).ready(function () {
    setDate();
    load();

    $('#covidAlertConfirmBtn').click(function() {
        setConfirm();
    });
});

function setDate(){//imposta la data di ieri e la setta come la massima
    let yesterday = new Date();
    yesterday.setDate(new Date().getDate()-1);
    var month = yesterday.getMonth() + 1;
    var day = yesterday.getDate();
    var year = yesterday.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate= year + '-' + month + '-' + day;
    $('#date').val(maxDate);
    $('#date').attr('max', maxDate);
}

function load(){//carica la lista dei clienti presenti nella data iniziata
    let date = $('#date').val();
    $.ajax({
        url: './covidAlert',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'GetCustomers',
            'Date': date
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm'){ //Dati ok
                setCustomers(data.CUSTOMERS);
                $('#covidAlertConfirmBtn').addClass("disabled").attr("disabled");
            }else
                setDate();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setCustomers(CUSTOMERS){
    console.log(CUSTOMERS)
    text='<option value="" selected disabled hidden> --Seleziona il cliente che è risultato positivo-- </option> ';
    $('#customersSelect').html(text);
    $.each(CUSTOMERS, function(key, val) {
        text='<option value="'+val.idUtente+'">' + val.cognome + ' ' + val.nome + '</option>';
        $('#customersSelect').append(text);
    });
}

function setConfirm(){//setta i dati del modal di confirm
    $('#covidAlertResponseMessageLabel').html("Conferma invio avviso");
    text =  'Confermi di voler effettuare la comunicazione a tutti i clienti presenti giorno <b>' + $('#date').val() + '</b>?<br>';
    $('#covidAlertResponseMessageText').html(text);
    text = '<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
        + '<button type="button" class="btn btn-primary disabled" id="covidAlertBtn" onclick="sendAlert()" disabled>Conferma</button>';
    $('#covidAlertStatusConfirm').removeClass('d-none').html(text);
    $('#covidAlertResponseMessageModal').modal('show');

    setTimeout(function(){ $('#covidAlertBtn').removeAttr("disabled").removeClass("disabled"); }, 2500);
}

function sendAlert(){//ajax che invia mail a tutti i clienti informandoli
    let date = $('#date').val();
    let id = $('#customersSelect').val();
    $.ajax({
        url: './covidAlert',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'SendAlert',
            'Date': date,
            'Customer': id
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#covidAlertResponseMessageLabel').html("Conferma");
            else
                $('#covidAlertResponseMessageLabel').html("Errore");
            $('#covidAlertResponseMessageText').html(data.MESSAGE);
            $('#covidAlertStatusConfirm').addClass('d-none');
            $('#covidAlertResponseMessageModal').modal('show');
            setTimeout(function(){ $('#covidAlertResponseMessageModal').modal('hide'); }, 2500);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}