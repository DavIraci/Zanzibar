$(document).ready(function () {

    fixDate(new Date());
    let s = Snap('#map');

    // Aumenta la selezione delle sdraio extra se possibile
    $('#bookQtyPlus').click(function(){
        if($('#bookQty').val()<(2*posSelected.length)) {
            $('#bookQty').val(parseInt($('#bookQty').val()) + 1);
            updateChair();
        }
    });

    // Diminuisce la selezione delle sdraio extra se possibile
    $('#bookQtyMinus').click(function(){
        if($('#bookQty').val()>0) {
            $('#bookQty').val(parseInt($('#bookQty').val()) - 1);
            updateChair();
        }
    });

    // Se sono state selezionate delle postazioni va alla fase successiva dell'ordinazione
    $('#checkBook').click(function () {
        if(posSelected.length>0){
            checkBook();
        }
    });

    // Carica la mappa SVG inizializzando le funzionalità di hover del mouse e di selezione/deselezione
    Snap.load("../image/mapALL.svg", function(f){
        load();

        f.selectAll('[id^="rect_"]').forEach(function(el){

            el.parent().data('status', 'F');

            el.click(function(ev){

                let elem = el.parent();
                let id = '#'+ elem.node.id;

                if( elem.data('status')=='O' ){
                    //Occupato
                }
                else if( elem.data('status')=='S' ) {
                    // The seat is already selected, the user wants to deselect it
                    setFree(id, elem);
                    posSelected.splice(posSelected.indexOf(id), 1);
                    $('#postazioni .part_'+id.split("#")[1]).remove();
                    if(posSelected.length==0){
                        $('#checkBook').removeClass("active").addClass("disabled");
                    }
                    if($('.qty').val()>=(2*posSelected.length)){
                        $('.qty').val(2*posSelected.length);
                        updateChair();
                    }
                    updateTotal();
                } else {
                    // the seat is free, the user wants to select it
                    setSelected(id, elem);
                    posSelected.push(id);
                    let text = '<p class="part_'+id.split("#")[1]+'">Postazione '+ elem.data('row1') +' '+ elem.data('row2') +' <b>'+ elem.data('row3') +   '€</b></p>';
                    $('#postazioni').append(text);
                    $('#checkBook').removeClass("disabled").addClass("active");
                    $('.part_'+id.split("#")[1]).val(elem.data('row3'));
                    updateTotal();
                }
            });

            el.mousemove(function(ev){
                // when mouse is over the seat, system shows an informational tooltip
                let elem = el.parent();
                let id = '#'+ elem.node.id;

                if( elem.data('status')!='O' ){
                    let text = '<p class="row1">'+elem.data('row1')+'</p>'
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

// Variabili globali per la gestione dell'ordine
var order;
var posNotAvailable = [];
var posSelected = [];

// Aggiorna il prezzo mostrato nella preview
function updateTotal(){
    let total=parseFloat(($('#extra-chair').val())*(parseInt($('.qty').val())).toFixed(2));
    $.each($('#postazioni p'), function(key, val){
        total+=parseFloat(val.value);
    });

    if(total==0)
        $('#totale').html("");
    else
        $('#totale').html("<h1>Totale    " + total.toFixed(2) + "€</h1>");
    $('#totale').val(total);
}

// Aggiorna il numero di sdraio extra in relazione al numero di postazioni
function updateChair(){
    let text="<p>N°"+parseInt($('.qty').val())+" Sdraio extra  <b>"+ (($('#extra-chair').val())*(parseInt($('.qty').val()))).toFixed(2)+"€</b></p>";
    $('#sdraio').html(text);
    if(parseInt($('.qty').val())==0){
        $('#sdraio').html("");
    }
    updateTotal();
}

// Imposta il datepicker per la selezione del giorno
function setDate(data){
    let month = data.getMonth() + 1;
    let day = data.getDate();
    let year = data.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    let minDate= year + '-' + month + '-' + day;
    $('#date').val(minDate);
    $('#date').attr('min', minDate);
}

// Verifica che l'orario della richiesta rientri nei limiti della prenotazione del giorno viceversa imposta l'indomani
function fixDate(data){
    $('#period option').removeAttr("disabled");
    $('#period option').removeAttr("selected");

    let today = new Date();
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

// Carica le informazioni dal DB circa le prenotazioni e i prezzi del giorno e della fascia selezionata
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

// Verifica che le postazioni selezionate siano ancora disponibili all'acquisto
function checkBook(){
    let date = $('#date').val();
    let period = $('#period').val();
    let extra_chiar=$('.qty').val();
    if (checkInput(date) && checkInput(period)) {
        $.ajax({
            url: './checkBook',
            dataType: 'json',
            type: 'post',
            data: {
                'Date': date,
                'Period': period,
                'Sit': posSelected.sort().toString(),
                'ExtraChair': extra_chiar
            },
            success: function (data) {
                if(data.RESPONSE == 'Confirm'){ //Dati ok
                    data.DATE=date;
                    data.PERIOD=period;
                    initializeCheckout(data);
                }else {
                    reset();
                    load();
                    let text='<div class="row" style="justify-content: center">' +
                        '<div class="alert alert-danger alert-dismissible" role="alert">' +
                        '<button type="button" class="close" data-dismiss="alert">&times;</button>'+ data.MESSAGE +'</div> </div>';
                    $('#message-alert').append(text);
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

// Reimposta i valori della pagina
function reset(){
    let id;
    $('.qty').val(0);
    for (let i = 10; i < 60; i++) {
        id="#pos_"+ i;
        setFree(id, Snap.select(id));
    }

    let date=$('#date').val().split("-");
    fixDate(new Date(date[0],date[1]-1,date[2]));
    $('#postazioni').html("");
    $('#totale').html("");
    $('#sdraio').html("");
    posSelected=[];
    posNotAvailable=[];
}

// Imposta le postazioni occupate
function setPostazioni(booked){
    $.each(booked, function (key, val) {
        let id="#pos_"+ val.id;
        posNotAvailable.push(id);
        setOccupied(id, Snap.select(id));
    });
}

// Imposta i label che appariranno con il mouse Hover
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

// Aggiunge le sdraio extra nella preview
function setExtraChairs(price){
    $('#extra-chair').html("Extra sdraio ("+(parseFloat(price)).toFixed(2)+"€ cad.):");
    $('#extra-chair').val((parseFloat(price)).toFixed(2));
}

// Imposta la postazione come selezionata
function setSelected(id, elem){
    $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-selected");
    $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-selected");
    $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-selected");
    elem.data('status', 'S');
}

// Imposta la postazione come occupata
function setOccupied(id, elem){
    $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-occupied");
    $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-occupied");
    $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-occupied");
    elem.data('status', 'O');
}

// Imposta la postazione come libera
function setFree(id, elem){
    $(id+' ellipse.st1-selected').removeClass("st1 st1-occupied st1-selected").addClass("st1");
    $(id+' rect.st2-selected').removeClass("st2 st2-occupied st2-selected").addClass("st2");
    $(id+' path.st3-selected').removeClass("st3 st3-occupied st3-selected").addClass("st3");
    $(id+' ellipse.st1-occupied').removeClass("st1 st1-occupied st1-selected").addClass("st1");
    $(id+' rect.st2-occupied').removeClass("st2 st2-occupied st2-selected").addClass("st2");
    $(id+' path.st3-occupied').removeClass("st3 st3-occupied st3-selected").addClass("st3");
    elem.data('status', 'F');
}
