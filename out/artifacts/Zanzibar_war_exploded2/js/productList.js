$(document).ready(function () {
    $('#categoryBtn button').on('click', function() {
        $('#categoryBtn button').removeClass('active');
        $(this).addClass('active');
        loadProduct();
    });
});

function loadProduct(){
    $('#productRowList').html("");
    let cat = $('#categoryBtn .active').val();
    console.log("LoadProduct: " + cat);
    $.ajax({
        url: './productList',
        dataType: 'json',
        type: 'post',
        data: {
            'Category': cat
        },
        success: function (data) {
            setProducts(data);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setProducts(data){
    $.each(data.PRODUCTS    , function(key, val){
        text='<div class="col-md-4 mb-4">'
            +'<!-- Card -->'
            +'<div class="">'
                +'<div class="view zoom overlay z-depth-2 rounded">'
                    +'<a href="./prova">'
                        +'<img class="img-fluid w-100" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">'
                    +'</a> </div>'
                +'<div class="text-center pt-4">'
                    +'<h5>'+val.name+'</h5>'
                    +'<p class="mb-2 text-muted text-uppercase small">'+val.category+'</p><hr>'
                        +'<h6 class="mb-3">'
                            +'<span class="text-grey">€'+parseInt(val.price).toFixed(2)+'</span></h6>'
                        +'<button type="button" class="btn btn-primary btn-sm mr-1 mb-2" onclick="addToCart('+val.barcode+')"><i class="fas fa-shopping-cart pr-2"></i>Aggiungi al carello</button>'
                        +'<button type="button" class="btn btn-light btn-sm mr-1 mb-2" onclick="showDetails('+val.barcode+')"><i class="fas fa-info-circle pr-2"></i>Dettagli</button>'
                +'</div></div><!-- Card --></div>';
        $('#productRowList').append(text);
    });
}

