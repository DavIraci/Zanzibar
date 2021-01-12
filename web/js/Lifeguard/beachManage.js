$(document).ready(function () {
    var s = Snap('#map');

    Snap.load("/Zanzibar/image/mapALL.svg", function(f){
        load();

        f.selectAll('[id^="rect_"]').forEach(function(el){

            el.parent().data('status', 'F');

            el.click(function(ev){
                var elem = el.parent();
                var id = '#'+ elem.node.id;

                // Stati possibili Prenotato - Checkin - Checkout - Selezionato

                if( elem.data('status')=='CO' || elem.data('status')=='F'){
                    //CheckOut effettuato o Free

                } else if( elem.data('status')=='S' ) {
                    //Selezionata
                    setFree(id, elem);
                    posSelected.splice(posSelected.indexOf(id), 1);
                    $('#postazioni .part_'+id.split("#")[1]).remove();
                    if(posSelected.length==0)
                        $('#checkBook').removeClass("active").addClass("disabled");
                    if($('.qty').val()>=(2*posSelected.length)){
                        $('.qty').val(2*posSelected.length);
                        updateChair();
                    }
                    updateTotal();

                } else if( elem.data('status')=='CI' ){
                    //CheckIn effettuato

                } else {
                    // Prenotata-CheckIn non effettuato
                    setSelected(id, elem);
                    posSelected.push(id);
                    var text = '<p class="part_'+id.split("#")[1]+'">Postazione '+ elem.data('row1') +' '+ elem.data('row2') +' <b>'+ elem.data('row3') +   '€</b></p>';
                    $('#postazioni').append(text);
                    $('#checkBook').removeClass("disabled").addClass("active");
                    $('.part_'+id.split("#")[1]).val(elem.data('row3'));
                    updateTotal();
                }
            });

            el.mousemove(function(ev){
                // when mouse is over the seat, system shows an informational tooltip
                var elem = el.parent();
                var id = '#'+ elem.node.id;

                if( elem.data('status')!='O' ){
                    var text = '<p class="row1">'+elem.data('row1')+'</p>'
                        + '<p class="row2">'+elem.data('row2')+'</p>'
                        + '<p class="row3">Prezzo €'+elem.data('row3')+'</p>';

                    $('#tooltip')
                        .html(text)
                        .css("opacity", "1")
                        .css("left", ev.clientX + 15 + "px")
                        .css("top", ev.clientY + 15 + "px");
                }
            });

            el.mouseout(function(ev){
                // hides the tooltip
                $('#tooltip').css("opacity", "0");
            });

        });

        s.append(f);
    });
});

var posSelected = [];

function load(){
    let date = $('#date').val();
    let period = $('#period').val();
    if (checkInput(date) && checkInput(period)) {
        $.ajax({
            url: './beachManage',
            dataType: 'json',
            type: 'post',
            data: {
                'Date': date,
                'Period': period
            },
            success: function (data) {
                if(data.RESPONSE == 'Confirm'){ //Dati ok
                    setPostazioni(data.BOOKED);
                    //setLabel(data.PRICE);
                    //setExtraChairs(data.EXTRA_CHAIR_PRICE);
                }
            },
            error: function (errorThrown) {
                console.log(errorThrown);
            }
        });
    }else{
        console.log("Error!");
    }
}

function setPostazioni(booked){
    $.each(booked, function (key, val) {
        let id="#pos_"+ val.id;
        posNotAvailable.push(id);
        setOccupied(id, Snap.select(id));
    });
}

function checkInput(val) {
    if (val != null && val.trim() != "") {
        return true;
    } else {
        return false;
    }
}