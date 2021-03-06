$(document).ready(function () {
    loadCart();

    $('#addedToCartModal').on('hidden.bs.modal', function () {
        loadCart();
    });

    // Cattura l'invio del form di ordine e ne verifica la validità
    $('#OrderCOform').submit(function (e) {
        e.preventDefault();
        if ($('#OrderCOform')[0].checkValidity()) {
            Order();
        }
    });

    $('#orderMessageModal').on('shown', function () {
        $('#page-top').addClass("modal-open");
    });
});

// Carica il carrello dal server
function loadCart(){
    $.ajax({
        url: './user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'CartManage'
        },
        success: function (data) {
            $('#productsRow').html("");
            $('#cart-message-alert').html("");
            setCart(data);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
    updateCart();
}

// Imposta i dati del carrello nella tabella
function setCart(data) {
    if (data.CART == null) {
        //Messaggio carrello vuoto
        let text = '<div class="row" style="justify-content: center">' +
            '<div class="alert alert-info alert-dismissible" role="alert">' +
            '<button type="button" class="close" data-dismiss="alert">&times;</button>Il tuo carello è vuoto, aggiungi prodotti da <a href="#" data-toggle="modal" data-target="#productsModal" onclick="$(\'#allGroup button\').click();">qui</a></div></div>';
        $('#cart-message-alert').append(text);
        $('#subTotal').html("");
        $('#payOrder').html("");
    } else {
        $('#subTotal').html('<p>Numero prodotti: '+parseInt(data.PRODUCTNUMBER)+'</p>' +
            '<h2>Totale:     '+ parseInt(data.TOTAL).toFixed(2) + '€</h2>');
        let onclickaction=data.INSITE===true?"initializeOrderCheckout()":"notInSite()";
        $('#payOrder').html("<input type=\"button\" class=\"btn-lg btn-primary\" id=\"orderCheckout\" onclick=\""+onclickaction+"\" value=\"Conferma e ordina\">");
        $.each(data.CART, function(key, val){
            let note=val.note==="null"?"":val.note;
            text='<tr>'+
                '<th scope="row">'+zeropadInt(val.barcode,3)+'</th>' +
                '<td>'+val.name+'</td>'+
                '<td>'+val.category+'</td>'+
                '<td><div id=\'productQtyForm'+val.barcode+'\'>\n' +
                '       <input id="productQtyMinus'+val.barcode+'" onclick=\"quantityMinus('+val.barcode+')\" type=\'button\' value=\'-\' class=\'qtyminus btn btn-danger\' field=\'quantity\' style="border-radius: 0.5rem"/>\n' +
                '       <input id="productQty'+val.barcode+'" type=\'text\' name=\'quantity\' value=\''+val.quantity+'\' class=\'qty text-center align-middle\' style="max-width: 25%" readonly/>\n' +
                '       <input id="productQtyPlus'+val.barcode+'" onclick=\"quantityPlus('+val.barcode+')\" type=\'button\' value=\'+\' class=\'qtyplus btn btn-success\' field=\'quantity\' style="border-radius: 0.5rem"/>\n' +
                '    </div></td>'+
                '<td>'+parseInt(val.price).toFixed(2)+'€</td>'+
                '<td>'+note+'</td>'+
                '</tr>';
            $('#productsRow').append(text);
        });
    }
}

// Mostra il modal per la compilazione dei dati ulteriori per il piazzamento dell'ordine
function initializeOrderCheckout(){
    $.ajax({
        url: './user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'CartManage'
        },
        success: function (data) {
            if(data.CART!=null) {
                $('#orderCheckoutModal').modal('show');
                resetOrderCheckout();

                $('#product-number').html(parseInt(data.PRODUCTNUMBER));
                $.each(data.CART, function (key, val) {
                    let text = '<li class="list-group-item d-flex justify-content-between lh-condensed"><div class="mr-3">' +
                        '<h6 class="my-0">' + val.name + '</h6><small class="text-muted">Quantità ' + val.quantity + ' </small>' +
                        '</div><span class="text-muted">€ ' + (parseFloat(val.price) * parseInt(val.quantity)).toFixed(2) + '</span></li>';
                    $('#cartProducts').append(text);
                });
                let text = '<li class="list-group-item d-flex justify-content-between"><span>Totale </span>' +
                    '<strong id="total-price">€ ' + parseFloat(data.TOTAL).toFixed(2) + '</strong></li>';
                $('#cartProducts').append(text);
            }
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Prende i dati inseriti dall'utente e invia la prenotazione al server
function Order(){
    let method;
    if($('#creditOrderCO')[0].checked)
        method="CreditCard";
    else if($('#cashOrderCO')[0].checked)
        method="Cassa";
    else
        method="Paypal";

    let delivery=$('#onPostationDeliberyOrderCO')[0].checked?"Umbrella":"Bar";

    let name = capitalletters($('#nameOrderCO').val());
    let surname = capitalletters($('#surnameOrderCO').val());
    let email = $('#emailOrderCO').val();
    let fiscal = $('#fiscalcodeOrderCO').val().toUpperCase();
    let address = $('#addressOrderCO').val() + " " + $('#address2OrderCO').val();
    let region = capitalletters($('#regionOrderCO').val());
    let province = $('#provinceOrderCO').val().toUpperCase();
    let city = capitalletters($('#cityOrderCO').val());
    let cap = $('#capOrderCO').val();
    let cardno =method=="CreditCard"?$('#regionOrderCO').val():null;

    $.ajax({
        url: './user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'PlaceOrder',
            'PaymentMethod': method,
            'DeliveryMethod': delivery,
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
            $('#orderCheckoutModal').modal('hide');
            $('#orderMessageLabel').html(data.RESPONSE == 'Confirm'?"Conferma":"Errore");
            $('#orderMessageText').html(data.MESSAGE);
            $('#orderMessageModal').modal('show');
            setTimeout(function(){ $('#orderMessageModal').modal('hide'); }, 1500);
            loadCart();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

// Mostra un errore nel caso in cui si voglia fare un ordine mentre non si è attualmente al lido
function notInSite(){
    let text='<div class="row" style="justify-content: center">' +
        '<div class="alert alert-danger alert-dismissible" role="alert">' +
        '<button type="button" class="close" data-dismiss="alert">&times;</button>Non si può effettuare un ordine se non sei all\'interno del lido! </div> </div>';
    $('#cart-message-alert').html(text);
}

// Abilita o disabilita alcuni campi in base al metodo di pagamento inserito
function updateOrderPaymentMethod(){
    if($('#creditOrderCO')[0].checked){
        $('#invoiceDateOrderCO').removeClass("d-none");
        $('#invoiceDateOrderCO input').attr("required", "");
        $('#credit-card-methodOrderCO').removeClass("d-none");
        $('#credit-card-methodOrderCO input').attr("required", "");
    }else if($('#cashOrderCO')[0].checked){
        $('#invoiceDateOrderCO').addClass("d-none");
        $('#invoiceDateOrderCO input').removeAttr("required");
        $('#credit-card-methodOrderCO').addClass("d-none");
        $('#credit-card-methodOrderCO input').removeAttr("required");
    }else{
        $('#invoiceDateOrderCO').removeClass("d-none");
        $('#invoiceDateOrderCO input').attr("required", "");
        $('#credit-card-methodOrderCO').addClass("d-none");
        $('#credit-card-methodOrderCO input').removeAttr("required");
    }
    checkOrderValidation();
}

// Controlla se il form è valido e abilita il tasto di pagamento
function checkOrderValidation(){
    if($('#OrderCOform')[0].checkValidity()){
        $('#payBtnOrderCO').removeClass("disabled").addClass("active");
    }else{
        $('#payBtnOrderCO').removeClass("active").addClass("disabled");
    }
}

// Ripristina tutti i campi
function resetOrderCheckout(){
    $('#cartProducts').html("");
    $('#payBtnOrderCO').removeClass("active").addClass("disabled");
}

// Aumenta la quantità di un prodotto nel carrello
function quantityPlus(id){
    if($('#productQty'+id).val()<10) {
        updateQuantityCart(id, (parseInt($('#productQty'+id).val()) + 1));
    }
}

// Diminuisce la quantità di un prodotto nel carrello
function quantityMinus(id){
    if($('#productQty'+id).val()>0) {
        updateQuantityCart(id, (parseInt($('#productQty'+id).val()) - 1));
    }
}

// Invia una richiesta al server per variare la quantità di un oggetto nel carrello
function updateQuantityCart(id, quantity){
    $.ajax({
        url: './user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'UpdateQuantity',
            'Barcode': id,
            'Quantity': quantity
        },
        success: function (data) {
            if(data.RESPONSE=="Confirm")
                loadCart();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}