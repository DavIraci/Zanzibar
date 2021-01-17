$(document).ready(function () {
    load();
});

var orders;
var users;

function load(){
    $('#kitchen-message-alert').html("");
    $.ajax({
        url: './kitchen',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'GetOrders'
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm'){ //Dati ok
                orders=data.ORDERS;
                users=data.USERS;
                if (orders.length==0){
                    //Messaggio nessun ordine
                    let text = '<div class="row" style="justify-content: center">' +
                        '<div class="alert alert-info alert-dismissible" role="alert">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>Al momento non sono stati effettuati ordini</div></div>';
                    $('#kitchen-message-alert').append(text);
                }else
                    setOrders();
            }
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
    setInterval(function(){
        load();
    }, 60000);
}

function setOrders(){
    $('#kitchenOrdersRow').html("");

    $.each(orders, function(key, val){
        var status;
        var buttons, buttonvalue='';
        switch (val.status){
            case "A": {
                status = "Ricevuto";
                buttonvalue="In lavorazione";
                val.nextStatus=buttonvalue;
                break;
            }
            case "W": {
                status = "In lavorazione";
                buttonvalue="Pronto";
                val.nextStatus=buttonvalue;
                if (val.deliveryMethod!=="Bar")
                    val.nextStatus="In consegna";
                break;
            }
            case "T": {
                status = "In consegna";
                break;
            }
            case "R": {
                status = "Pronto";
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

        if(buttonvalue!=='')
            buttons = '<input type="button" class="btn btn-info active" id="changeStatusBtn" value="' + buttonvalue + '" onclick="changeStatusConfirm(' + val.orderID + ')">';
        else
            buttons='';

        let quantity=0;
        $.each(val.products, function(key2, val2){
            quantity+=parseInt(val2.quantity);
        });

        var selUser=userByID(val.userID);
        text='<tr>'+
                '<th scope="row">'+zeropadInt(val.orderID,6)+'</th>' +
                '<td>'+ selUser.nome + " " + selUser.cognome+'</td>'+
                '<td>'+zeropadInt(val.date.hour,2) + ':' + zeropadInt(val.date.minute, 2) +'</td>'+
                '<td class="text-center">'+quantity+'</td>'+
                '<td>'+status+'</td>'+ // LISTA STATI
                '<td class="text-center">'+buttons+'</td>'+ // BOTTONE CAMBIO STATO
                '<td class="text-center"><input type="button" class="btn btn-info active" id="orderDetailBtn" value="Dettagli" onclick="orderDetails('+val.orderID+')"></td>'+ // BOTTONE DETTAGLI
            '</tr>';
        $('#kitchenOrdersRow').append(text);
    });
}

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

function changeStatusConfirm(id){
    $('#kitchenResponseMessageLabel').html("Conferma cambio stato");
    let order=orderByID(id);
    text = 'Confermi di voler cambiare lo stato dell\'ordine in <br><b>'+order.nextStatus+'</b>?';
    $('#kitchenResponseMessageText').html(text);
    text='<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
         +'<button type="button" class="btn btn-primary" id="changeStatusBtn" onclick="changeStatus('+id+')">Conferma</button>';

    $('#changeStatusConfirm').removeClass('d-none').html(text);
    $('#kitchenResponseMessageModal').modal('show');
}

function changeStatus(id){
    $('#changeStatusConfirm').addClass('d-none');
    $.ajax({
        url: './kitchen',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'ChangeStatus',
            'OrderID': id
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#kitchenResponseMessageLabel').html("Conferma");
            else
                $('#kitchenResponseMessageLabel').html("Errore");
            $('#kitchenResponseMessageText').html(data.MESSAGE);
            $('#changeStatusConfirm').addClass('d-none');
            $('#kitchenResponseMessageModal').modal('show');
            setTimeout(function(){ $('#kitchenResponseMessageModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

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