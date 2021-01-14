$(document).ready(function () {
    load();
});

var orders;
var users;

function load(){
    $.ajax({
        url: './kitchen',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'GetOrders'
        },
        success: function (data) {
            if(data.RESPONSE == 'Confirm'){ //Dati ok
                orders=data.ORDERS;
                users=data.USERS;
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
        var status, buttons='';
        switch (val.status){
            case "A": {
                status = "Ricevuto";
                button='<input type="button" class="btn btn-info active" id="changeStatusBtn" value="In lavorazione" onclick="changeStatusConfirm('+val.orderID+')">';
                break;
            }
            case "W": {
                status = "In lavorazione";
                button='<input type="button" class="btn btn-info active" id="changeStatusBtn" value="Pronto" onclick="changeStatusConfirm('+val.orderID+')">';
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

        var selUser=userByID(val.userID);
        text='<tr>'+
                '<th scope="row">'+zeropadInt(val.orderID,6)+'</th>' +
                '<td>'+ selUser.nome + " " + selUser.cognome+'</td>'+
                '<td>'+zeropadInt(val.date.dayOfMonth,2) + '-' + zeropadInt(val.date.monthValue, 2) + '-' + val.date.year+'</td>'+
                '<td class="text-center">'+val.products.length+'</td>'+
                '<td>'+status+'</td>'+ // LISTA STATI
                '<td class="text-center">'+button+'</td>'+ // BOTTONE CAMBIO STATO
                '<td class="text-center"><input type="button" class="btn btn-info active" id="orderDetailBtn" value="Dettagli" onclick="orderDetails('+val.book_id+')"></td>'+ // BOTTONE DETTAGLI
            '</tr>';
        $('#kitchenOrdersRow').append(text);
    });
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
    $('#kitchenResponseMessageText').html("Confermi di voler cambiare lo stato dell'ordine?");
    $('#changeStatusConfirm').removeClass('d-none');
    text='<button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>'
         +'<button type="button" class="btn btn-primary" id="changeStatusBtn" onclick="changeStatus('+id+')">Conferma</button>';

    $('#changeStatusConfirm').html(text);
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
