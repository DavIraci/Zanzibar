$(document).ready(function () {

    fixDate(new Date());
    var s = Snap('#map');

    $('.qtyplus').click(function(){
        if($('.qty').val()<2) {
            $('.qty').val(parseInt($('.qty').val()) + 1);
            var testo="<p>Sdraio extra "+parseInt($('.qty').val())+" <b>"+ (($('#extra-chair').val())*(parseInt($('.qty').val()))).toFixed(2)+"€</b></p>";
            $('#sdraio').html(testo);
            updateTotal(parseInt($('#extra-chair').val()), "+");
        }
    });

    $('.qtyminus').click(function(){
        if($('.qty').val()>0) {
            $('.qty').val(parseInt($('.qty').val()) - 1);
            var testo="<p>Sdraio extra "+parseInt($('.qty').val())+" <b>"+ (($('#extra-chair').val())*(parseInt($('.qty').val()))).toFixed(2)+"€</b></p>";
            $('#sdraio').html(testo);
            updateTotal(parseInt($('#extra-chair').val()), "-");
            if(parseInt($('.qty').val())==0){
                $('#sdraio').html("");
            }
        }

    });

    $('#placeBook').click(function () {
        if(postazioniSelezionate.length>0){
            placeBook();
        }
    });

    Snap.load("/Zanzibar/image/mapALL.svg", function(f){
        load();

        f.selectAll('[id^="rect_"]').forEach(function(el){

            el.parent().data('status', 'F');

            el.click(function(ev){

                var elem = el.parent();
                var id = '#'+ elem.node.id;

                if( elem.data('status')=='O' ){
                    //Occupato
                }
                else if( elem.data('status')=='S' ) {
                    // The seat is already selected, the user wants to deselect it
                    //check('D', ev.target.id);
                    setFree(id, elem);
                    postazioniSelezionate.splice(postazioniSelezionate.indexOf(id), 1);
                    $('#postazioni .part_'+id.split("#")[1]).remove();
                    if(postazioniSelezionate.length==0){
                        $('#placeBook').removeClass("active").addClass("disabled");
                    }
                    updateTotal(elem.data('row3'), "-");
                } else {
                    // the seat is free, the user wants to select it
                    //check('S', ev.target.id);
                    setSelected(id, elem);
                    postazioniSelezionate.push(id);
                    var testo = '<p class="part_'+id.split("#")[1]+'">Postazione '+ elem.data('row1') +' '+ elem.data('row2') +' <b>'+ elem.data('row3') +   '€</b></p>';
                    $('#postazioni').append(testo);
                    $('#placeBook').removeClass("disabled").addClass("active");
                    updateTotal(elem.data('row3'), "+");
                }
            });

            el.mousemove(function(ev){
                // when mouse is over the seat, system shows an informational tooltip
                var elem = el.parent();
                var id = '#'+ elem.node.id;

                if( elem.data('status')!='O' ){
                    var testo = '<p class="row1">'+elem.data('row1')+'</p>'
                        + '<p class="row2">'+elem.data('row2')+'</p>'
                        + '<p class="row3">Prezzo €'+elem.data('row3')+'</p>';

                    $('#tooltip')
                        .html(testo)
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

//var prenotazioni = {};
//var ordini = {};
var postazioniNonPrenotabili = [];
var postazioniSelezionate = [];
//var prodottiSelezionati = {};
//var totaleOrdini = 0;
//var totalePrenotazioni = 0;

function updateTotal(price, action){
    let value=$('#totale').val();
    if(value=="")
        value = 0;
    if(action=="-"){
        value= (parseInt(value) - parseInt(price)).toFixed(2);
    }
    if(action=="+"){
        value= (parseInt(value) + parseInt(price)).toFixed(2);
    }
    $('#totale').val(value);
    if(value==0)
        $('#totale').html("");
    else
        $('#totale').html("<h1>Totale    " + value + "€</h1>");

}

function setDate(data){
    var month = data.getMonth() + 1;
    var day = data.getDate();
    var year = data.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var minDate= year + '-' + month + '-' + day;
    $('#date').val(minDate);
    $('#date').attr('min', minDate);
}

function fixDate(data){
    $('#period option').removeAttr("disabled");
    $('#period option').removeAttr("selected");
    //$('#op_full').attr('selected','selected');

    var today = new Date();
    if(today.getDay()==data.getDay() && today.getMonth()==data.getMonth() && today.getFullYear()==data.getFullYear()) {
        if (today.getHours() > 8 && today.getHours() < 14) {
            $('#op_am').attr("disabled", "disabled");
            $('#op_full').attr("disabled", "disabled");
            $('#op_pm').attr('selected', 'selected');
        } else if (today.getHours() > 14) {
            today.setDate(today.getDate() + 1);
        }
        setDate(today);
    }
}

function load(){
    let date = $('#date').val();
    let period = $('#period').val();
    if (checkInput(date) && checkInput(period)) {
        $.ajax({
            url: './book',
            dataType: 'json',
            type: 'post',
            data: {
                'Date': date,
                'Period': period
            },
            success: function (data) {
                if(data.RESPONSE == 'Confirm'){ //Dati ok
                    // buildMappa(data[0]);
                    setPostazioni(data.BOOKED);
                    setLabel(data.PRICE);
                    setExtraChairs(data.EXTRA_CHAIR_PRICE);
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

function placeBook(){
    let date = $('#date').val();
    let period = $('#period').val();
    let extra_chiar=$('.qty').val();
    if (checkInput(date) && checkInput(period)) {
        $.ajax({
            url: './checkBooking',
            dataType: 'json',
            type: 'post',
            data: {
                'Date': date,
                'Period': period,
                'Sit': postazioniSelezionate.sort().toString(),
                'ExtraChair': extra_chiar
            },
            success: function (data) {
                if(data.RESPONSE == 'Confirm'){ //Dati ok

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

function reset(){
    let id;
    for (let i = 10; i < 60; i++) {
        id="#pos_"+ i;
        setFree(id, Snap.select(id));
    }

    var date=$('#date').val().split("-");
    fixDate(new Date(date[0],date[1]-1,date[2]));
    $('#postazioni').html("");
    $('#totale').html("");
    $('#sdraio').html("");
    postazioniSelezionate=[];
    postazioniNonPrenotabili=[];
}

function setPostazioni(booked){
    $.each(booked, function (key, val) {
        let id="#pos_"+ val.id;
        postazioniNonPrenotabili.push(id);
        setOccupied(id, Snap.select(id));
    });
}

function setLabel(price){
    let elem;
    for (let i = 10; i < 60; i++) {
        elem=Snap.select("#pos_"+ i);
        if(elem.data('status')!='O'){
            let row=Math.floor(i / 10);
            let n=i-(row*10)+1;
            elem.data('row1', 'Fila ' + row);
            elem.data('row2', 'Posto ' + n);
            elem.data('row3', (price[(row-1)]).toFixed(2));
        }
    }
}

function setExtraChairs(price){
    $('#extra-chair').html("Extra sdraio ("+(parseInt(price)).toFixed(2)+"€ cad.):");
    $('#extra-chair').val((parseInt(price)).toFixed(2));
}

function checkInput(val) {
    if (val != null && val.trim() != "") {
        return true;
    } else {
        return false;
    }
}

function setSelected(id, elem){
    $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-selected");
    $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-selected");
    $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-selected");
    elem.data('status', 'S');

}
function setOccupied(id, elem){
    $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-occupied");
    $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-occupied");
    $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-occupied");
    elem.data('status', 'O');
}
function setFree(id, elem){
    $(id+' ellipse.st1-selected').removeClass("st1 st1-occupied st1-selected").addClass("st1");
    $(id+' rect.st2-selected').removeClass("st2 st2-occupied st2-selected").addClass("st2");
    $(id+' path.st3-selected').removeClass("st3 st3-occupied st3-selected").addClass("st3");
    $(id+' ellipse.st1-occupied').removeClass("st1 st1-occupied st1-selected").addClass("st1");
    $(id+' rect.st2-occupied').removeClass("st2 st2-occupied st2-selected").addClass("st2");
    $(id+' path.st3-occupied').removeClass("st3 st3-occupied st3-selected").addClass("st3");
    elem.data('status', 'F');
}
