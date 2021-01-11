$(document).ready(function () {
    $('#categoryBtn button').on('click', function() {
        $('#categoryBtn button').removeClass('active');
        $(this).addClass('active');
        loadProduct();
    });

    $('#productQtyPlus').click(function(){
        if($('#productQty').val()<(10)) {
            $('#productQty').val(parseInt($('#productQty').val()) + 1);
        }
    });

    $('#productQtyMinus').click(function(){
        if($('#productQty').val()>0) {
            $('#productQty').val(parseInt($('#productQty').val()) - 1);
        }
    });

    $('#addToCartModal').on('hidden.bs.modal', function () {
        $('#page-top').addClass("modal-open");
    });

    $('#addedToCartModal').on('hidden.bs.modal', function () {
        $('#page-top').addClass("modal-open");
    });
});

var dati;

function loadProduct(){
    let cat = $('#categoryBtn .active').val();
    $.ajax({
        url: '/Zanzibar/productList',
        dataType: 'json',
        type: 'post',
        data: {
            'Category': cat
        },
        success: function (data) {
            dati=data.PRODUCTS;
            setProducts(dati.slice(0,15));
            setPages();
            if(dati.length>15){
                $('#pageNGroup button').first().addClass("active");
            }
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setProducts(data){
    $('#productRowList').html("");
    $.each(data, function(key, val){
        text='<div class="col-md-4 mb-4">'
            +'<div class="">'
                +'<div class="view zoom overlay z-depth-2 rounded">'
                    +'<a><img class="img-fluid w-100" src="/Zanzibar/image/Product/'+val.category.replace(/\s/g, '%20')+'.png" alt="Sample"></a> </div>'
                +'<div class="text-center pt-4">'
                    +'<h5>'+val.name+'</h5>'
                    +'<p class="mb-2 text-muted text-uppercase small">'+val.category+'</p><hr>'
                        +'<h6 class="mb-3">' +
                            '<span class="text-grey">€'+parseInt(val.price).toFixed(2)+'</span></h6>'
                        +'<button type="button" class="btn btn-primary btn-sm mr-1 mb-2" onclick="setQuantity('+val.barcode+')"><i class="fas fa-cart-plus pr-2"></i>Aggiungi al carello</button>'
                        +'<button type="button" class="btn btn-light btn-sm mr-1 mb-2" data-toggle="collapse" data-target="#collapseDetail'+val.barcode+'"><i class="fas fa-info-circle pr-2"></i>Dettagli</button>'
                        +'<div class="collapse" id="collapseDetail'+val.barcode+'">'
                        +'  <div class="card card-body text-capitalize">'+ val.description+'</div></div></div></div></div>';
        $('#productRowList').append(text);
    });
}

function addToCart(barcode){
    let prod = productByID(barcode);
    $.ajax({
        url: '/Zanzibar/user/cartManage',
        type: 'post',
        data: {
            'Type': 'AddProduct',
            'Barcode': prod.barcode,
            'Quantity': $('#productQty').val(),
            'Description': $('#productNote').val()
        },
        success: function () {
            $('#addToCartModal').modal('hide');
            $('#addedToCartMessage').html($('#productQty').val()>1?"I prodotti sono stati aggiunti":"Il prodotto è stato aggiunto"+" al carrello!");
            $('#addedToCartModal').modal('show');
            updateCart();
            setTimeout(function(){ $('#addedToCartModal').modal('hide'); }, 1000);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function updateCart(){
    $.ajax({
        url: '/Zanzibar/user/cartManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': "CartSize"
        },
        success: function (data) {
            if(data.RESPONSE=="Confirm")
                $('#spanCart').html(parseInt(data.SIZE)>0?parseInt(data.SIZE):"");
            else
                console.log("Errore!");
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setPages(){
    if(dati.length>15){
        $('#pageNGroup').html("");
        for(let i=1; i<((dati.length/15)+1); i++){
            $('#pageDivGroup').addClass("pt-4");
            text='<button id="pageN'+i+'" type="button" onclick="updatePageN('+i+')" class="btn btn-primary" value="'+i+'">'+i+'</button>'
            $('#pageNGroup').append(text);
        }
    }else{
        $('#pageNGroup').html("");
        $('#pageDivGroup').removeClass("pt-4");
    }
}

function updatePageN(n){
    let btn=$('#pageN'+n);
    $('#pageNGroup button').removeClass('active');
    btn.addClass('active');
    setProducts(dati.slice(15*(btn.val()-1),15*(btn.val())));
}

function setQuantity(barcode){
    let prod = productByID(barcode);
    $('#addToCartName').html(prod.name);
    $('#productNote').val("");
    $('#productQty').val(1);
    $('#addToCartDescription').html("<b>"+ prod.category +"</b>" + prod.description);
    $('#addToCartBtn').attr('onclick','addToCart('+barcode+')');
    $('#addToCartModal').modal('show');
}

function productByID(barcode){
    let i=0;
    $.each(dati, function(key, val){
       if(val.barcode==barcode) {
           return false;
       }
       i++;
    });
    return dati[i];
}