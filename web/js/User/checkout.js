$(document).ready(function () {

    // Cattura l'invio del form di CheckOut e verifica se i dati immessi sono validi
    $('#COform').submit(function (e) {
        e.preventDefault();
        if($('#COform')[0].checkValidity()){
            payOrder();
        }
    });
});

// Variabile globare dell'ordine
var order;

// Mostra il modal per l'inserimento dei dati ulteriori per la prenotazione
function initializeCheckout(data){
    $('#checkoutModal').modal('show');
    resetCheckout();
    let elnum = parseInt(data.POSTATION.length)+parseInt(data.EXTRA_CHAIR);
    let total = parseFloat(data.TOTAL_PRICE).toFixed(2);
    let price=0;

    $('#element-number').html(elnum);
    $.each(data.POSTATION, function (key, val) {
        let text='<li class="list-group-item d-flex justify-content-between lh-condensed"><div class="mr-3">' +
                '<h6 class="my-0">Ombrellone con due sdraio</h6><small class="text-muted">Fila '+val.row+' Posto '+val.number +' </small>' +
                '</div><span class="text-muted">€ '+parseFloat(val.price).toFixed(2) +'</span></li>';
        $('#selectedProducts').append(text);
        price+=val.price;
    });
    for(i=0; i<data.EXTRA_CHAIR; i++){
        let text='<li class="list-group-item d-flex justify-content-between lh-condensed"><div class="mr-3">' +
            '<h6 class="my-0">Sdraio Extra</h6>' +
            '</div><span class="text-muted">€ '+parseFloat((data.TOTAL_PRICE-price)/data.EXTRA_CHAIR).toFixed(2) +'</span></li>';
        $('#selectedProducts').append(text);
    }
    let text='<li class="list-group-item d-flex justify-content-between"><span>Totale </span>' +
        '<strong id="total-price">€ '+total+'</strong></li>';
    $('#selectedProducts').append(text);
    order=data;
}

// Reimposta i dati
function resetCheckout(){
    order=null;
    $('#selectedProducts').html("");
    $('#payBtn').removeClass("active").addClass("disabled");
}

// Aggiorna il metodo di pagamento abilitando o disabilitando sezioni
function updatePaymentMethod(){
    if($('#credit')[0].checked){
        $('#credit-card-method').removeClass("d-none");
        $('#credit-card-method input').attr("required", "");
    }else{
        $('#credit-card-method').addClass("d-none");
        $('#credit-card-method input').removeAttr("required");
    }
}

// Invia la richiesta di ordine al server prendendo i dati immessi dall'utente
function payOrder(){
    let method = $('#credit')[0].checked?"CreditCard":"Paypal";
    let name = capitalletters($('#nameCO').val());
    let surname = capitalletters($('#surnameCO').val());
    let email = $('#emailCO').val();
    let fiscal = $('#fiscalcodeCO').val().toUpperCase();
    let address = $('#addressCO').val() + " " + $('#address2CO').val();
    let region = capitalletters($('#regionCO').val());
    let province = $('#provinceCO').val().toUpperCase();
    let city = capitalletters($('#cityCO').val());
    let cap = $('#capCO').val();
    let cardno =method=="CreditCard"?$('#regionCO').val():null;

    $.ajax({
        url: './placeBook',
        dataType: 'json',
        type: 'post',
        data: {
            'Order': order,
            'PaymentMethod': method,
            'Name' : name,
            'Surname' : surname,
            'Email' : email,
            'Fiscal' : fiscal,
            'Address' : address,
            'Region' : region,
            'Province' : province,
            'City' : city,
            'CAP' : cap,
            'CardNO' : cardno
        },
        success: function (data) {
            let typemessage = data.RESPONSE == 'Confirm'?"alert-success":"alert-danger";
            // Prenotazione Effettuata o errore con messaggio
            $('#checkoutModal').modal('hide');
            reset();
            load();
            let text='<div class="row" style="justify-content: center">' +
                '<div class="alert '+typemessage+' alert-dismissible" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert">&times;</button>'+ data.MESSAGE +'</div> </div>';
            $('#message-alert').html(text);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Verifica se il form è valido e abilita il bottone di pagamento
function checkValidation(){
    if($('#COform')[0].checkValidity()){
        $('#payBtn').removeClass("disabled").addClass("active");
    }else{
        $('#payBtn').removeClass("active").addClass("disabled");
    }
}