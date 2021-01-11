$(document).ready(function () {
    $('#COform').submit(function (e) {
        e.preventDefault();
        if($('#COform')[0].checkValidity()){
            payOrder();
        }
    });
});

var order;

function initializeCheckout(data){
    $('#checkoutModal').modal('show');
    resetCheckout();
    var elnum = parseInt(data.POSTATION.length)+parseInt(data.EXTRA_CHAIR);
    var total = parseFloat(data.TOTAL_PRICE).toFixed(2);
    var price=0;

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

function resetCheckout(){
    order=null;
    $('#selectedProducts').html("");
    $('#payBtn').removeClass("active").addClass("disabled");
}

function updatePaymentMethod(){
    if($('#credit')[0].checked){
        $('#credit-card-method').removeClass("d-none");
        $('#credit-card-method input').attr("required", "");
    }else{
        $('#credit-card-method').addClass("d-none");
        $('#credit-card-method input').removeAttr("required");
    }
}

function payOrder(){
    var method = $('#credit')[0].checked?"CreditCard":"Paypal";
    var name = capitalletters($('#nameCO').val());
    var surname = capitalletters($('#surnameCO').val());
    var email = $('#emailCO').val();
    var fiscal = $('#fiscalcodeCO').val().toUpperCase();
    var address = $('#addressCO').val() + " " + $('#address2CO').val();
    var region = capitalletters($('#regionCO').val());
    var province = $('#provinceCO').val().toUpperCase();
    var city = capitalletters($('#cityCO').val());
    var cap = $('#capCO').val();
    var cardno =method=="CreditCard"?$('#regionCO').val():null;

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
            var typemessage = data.RESPONSE == 'Confirm'?"alert-success":"alert-danger";
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

function checkValidation(){
    if($('#COform')[0].checkValidity()){
        $('#payBtn').removeClass("disabled").addClass("active");
    }else{
        $('#payBtn').removeClass("active").addClass("disabled");
    }
}

function capitalletters(string){
    return string[0].toUpperCase()+string.slice(1);
}