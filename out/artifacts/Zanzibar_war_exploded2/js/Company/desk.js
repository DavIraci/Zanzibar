$(document).ready(function () {
    load();
});

//Variabili globali per il salvataggio degli ordini inviati dal server
var orders;
var users;

// Carica gli ordini effettuati per quel giorno
function load(){
    $('#desk-message-alert').html("");
    $.ajax({
        url: './desk',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'GetOrders'
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm'){ //Dati ok
                orders=data.ORDERS;
                users=data.USERS;
                if (orders.length===0){
                    //Messaggio nessun ordine
                    let text = '<div class="row" style="justify-content: center">' +
                        '<div class="alert alert-info alert-dismissible" role="alert">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>Al momento non sono stati effettuati ordini</div></div>';
                    $('#desk-message-alert').append(text);
                }else
                    setOrders();
            }
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
    //Ricarica le risorse ogni 60 secondi per mostrarne i nuovi
    setInterval(function(){
        load();
    }, 60000);
}

//Per ogni ordine presente inserisce una riga popolandola con i dati dell'ordine
function setOrders(){
    $('#deskOrdersRow').html("");

    $.each(orders, function(key, val){
        let status;
        let buttons, buttonvalue='';

        // Verifica lo stato attuale e calcola il prossimo
        switch (val.status){
            case "A": {
                status = "Ricevuto";
                break;
            }
            case "W": {
                status = "In lavorazione";
                break;
            }
            case "T": {
                status = "In consegna";
                if (val.payed==="true")
                    buttonvalue="Consegnato";
                else
                    buttonvalue="Pagato e consegnato";
                break;
            }
            case "R": {
                status = "Pronto";
                if (val.deliveryMethod==="Bar"){
                    if (val.payed==="true")
                        buttonvalue="Ritirato";
                    else
                        buttonvalue="Pagato e ritirato";
               }else
                    buttonvalue="In consegna";
                break;
            }
            case "D": {
                status = "Consegnato";
                break;
            }
            default:{
                status = "errore";
                break;
            }
        }

        if(buttonvalue!=='') {
            buttons = '<input type="button" class="btn btn-info active" id="changeStatusBtn" value="' + buttonvalue + '" onclick="changeStatusConfirm(' + val.orderID + ')">';
            val.nextStatus=buttonvalue;
        }else
            buttons='';

        let quantity=0;
        $.each(val.products, function(key2, val2){
            quantity+=parseInt(val2.quantity);
        });

        let selUser=userByID(val.userID);
        text='<tr>'+
                '<th scope="row">'+zeropadInt(val.orderID,6)+'</th>' +
                '<td>'+ selUser.nome + " " + selUser.cognome+'</td>'+
                '<td>'+zeropadInt(val.date.hour,2) + ':' + zeropadInt(val.date.minute, 2) +'</td>'+
                '<td class="text-center">'+quantity+'</td>'+
                '<td>'+status+'</td>'+ // LISTA STATI
                '<td>'+(val.payed==="true"?"Si":"No")+'</td>'+
                '<td class="text-center">'+buttons+'</td>'+ // BOTTONE CAMBIO STATO
                '<td class="text-center"><input type="button" class="btn btn-info active" id="orderDetailBtn" value="Dettagli" onclick="orderDetails('+val.orderID+')"></td>'+ // BOTTONE DETTAGLI
            '</tr>';
        $('#deskOrdersRow').append(text);
    });
}

//Dato un ID ritorna l'ordine corrispondente contenuto nella variabile globale
function orderByID(id){
    let i=0;
    $.each(orders, function(key, val){
        if(val.orderID===id) {
            return false;
        }
        i++;
    });
    return orders[i];
}

//Dato un ID ritorna l'user corrispondente contenuto nella variabile globale
function userByID(id){
    let i=0;
    $.each(users, function(key, val){
        if(val.idUtente===id) {
            return false;
        }
        i++;
    });
    return users[i];
}

//Mostra un modal per la conferma del cambiamento di stato dell'ordine
function changeStatusConfirm(id){
    $('#deskResponseMessageLabel').html("Conferma cambio stato");
    let order=orderByID(id);
    text = 'Confermi di voler cambiare lo stato dell\'ordine in <br><b>'+order.nextStatus+'</b>?';
    $('#deskResponseMessageText').html(text);
    text='<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
         +'<button type="button" class="btn btn-primary" id="changeStatusBtn" onclick="changeStatus('+id+')">Conferma</button>';

    $('#changeStatusConfirm').removeClass('d-none').html(text);
    $('#deskResponseMessageModal').modal('show');
}

//Invia al server la richiesta per cambiare lo stato dell'ordine
function changeStatus(id){
    $('#changeStatusConfirm').addClass('d-none');
    $.ajax({
        url: './desk',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'ChangeStatus',
            'OrderID': id
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#deskResponseMessageLabel').html("Conferma");
            else
                $('#deskResponseMessageLabel').html("Errore");
            $('#deskResponseMessageText').html(data.MESSAGE);
            $('#changeStatusConfirm').addClass('d-none');
            $('#deskResponseMessageModal').modal('show');
            setTimeout(function(){ $('#deskResponseMessageModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

//Mostra un modal contenente i dettagli dell'ordine scelto
function orderDetails(id){
    let order=orderByID(id);
    let quantity=0;
    $('#orderProductsList').html("");
    $.each(order.products, function(key, val){
        let text='<li class="list-group-item d-flex justify-content-between lh-condensed"><div class="mr-3">' +
            '<h6 class="my-0">'+val.name+'</h6><small class="text-muted">'+(val.note==="null"?"":val.note) +' </small>' +
            '</div><span class="text-muted">x'+parseInt(val.quantity)+'</span></li>';
        $('#orderProductsList').append(text);
        quantity+=parseInt(val.quantity);
    });
    $('#orderProductsNumber').html(quantity);
    $('#orderDetailModal').modal('show');
}