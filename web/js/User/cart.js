$(document).ready(function () {
    loadCart();

    $('#addedToCartModal').on('hidden.bs.modal', function () {
        loadCart();
    });
});

function loadCart(){
    $.ajax({
        url: '/Zanzibar/user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'CartManage'
        },
        success: function (data) {
            $('#productsRow').html("");
            $('#cart-message-alert').html("");
            setCart(data.CART);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

var dati1;

function setCart(data) {
    dati1 = data;
    if (data == null) {
        //Messaggio carrello vuoto
        let text = '<div class="row" style="justify-content: center">' +
            '<div class="alert alert-info alert-dismissible" role="alert">' +
            '<button type="button" class="close" data-dismiss="alert">&times;</button>Il tuo carello è vuoto, aggiungi prodotti da <a href="#" data-toggle="modal" data-target="#productsModal" onclick="$(\'#allGroup button\').click();">qui</a></div></div>';
        $('#cart-message-alert').append(text);
        console.log("Carrello Vuoto");
    } else {
        console.log(data);
        $.each(data, function(key, val){
            var note=val.note=="null"?"":val.note;
            text='<tr>'+
                '<th scope="row">'+zeropadInt(val.barcode,3)+'</th>' +
                '<td>'+val.name+'</td>'+
                '<td>'+val.category+'</td>'+
                '<td><div id=\'productQtyForm'+val.barcode+'\'>\n' +
                '       <input id="productQtyMinus'+val.barcode+'" type=\'button\' value=\'-\' class=\'qtyminus btn btn-danger\' field=\'quantity\' style="border-radius: 0.5rem"/>\n' +
                '       <input id="productQty'+val.barcode+'" type=\'text\' name=\'quantity\' value=\''+val.quantity+'\' class=\'qty text-center\' style="max-width: 25%" readonly/>\n' +
                '       <input id="productQtyPlus'+val.barcode+'" type=\'button\' value=\'+\' class=\'qtyplus btn btn-success\' field=\'quantity\' style="border-radius: 0.5rem"/>\n' +
                '    </div></td>'+
                '<td>'+parseInt(val.price).toFixed(2)+'€</td>'+
                '<td>'+note+'</td>'+
                '</tr>';
            //metodo di pagamento, azioni (fattura eliminare)
            $('#productsRow').append(text);
        });
    }

    function zeropadInt(num, padlen) {
        var pad_char = '0';
        var pad = new Array(1 + padlen).join(pad_char);
        return (pad + num).slice(-pad.length);
    }
}