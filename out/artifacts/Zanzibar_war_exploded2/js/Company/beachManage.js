$(document).ready(function () {
    setDate(new Date())
    let s = Snap('#map');

    Snap.load("/Zanzibar/image/mapALL.svg", function(f){
        load();

        f.selectAll('[id^="rect_"]').forEach(function(el){

            el.parent().data('status', 'F');

            el.click(function(ev){
                // Stati possibili: Prenotato - Checkin - Checkout - Free
            });

            el.mousemove(function(ev){
                // when mouse is over the seat, system shows an informational tooltip
                let elem = el.parent();

                if( elem.data('status')!=='F' ){
                    let text = '<p class="row1">'+elem.data('row1')+'</p>' //ID prenotazione,
                        + '<p class="row2">'+elem.data('row2')+'</p>' // Stato
                        + '<p class="row3">'+elem.data('row3')+'</p>' // Nome e Cognome Cliente
                        + '<p class="row4">'+elem.data('row4')+'</p>' // Numero telefono
                        + '<p class="row5">'+elem.data('row5')+'</p>'; // Email

                    $('#tooltip')
                        .html(text)
                        .css("opacity", "1")
                        .css("left", ev.clientX + 15 + "px")
                        .css("top", ev.clientY + 15 + "px");
                }
            });

            el.mouseout(function(){
                // hides the tooltip
                $('#tooltip').css("opacity", "0");
            });

        });
        s.append(f);
    });
});

var book;
var user;

function load(){
    let date = $('#date').val();
    let period = $('#period').val();
    if (checkInput(date) && checkInput(period)) {
        $.ajax({
            url: './beachManage',
            dataType: 'json',
            type: 'post',
            data: {
                'Type': 'Load',
                'Date': date,
                'Period': period
            },
            success: function (data) {
                reset();
                if(data.RESPONSE === 'Confirm'){ //Dati ok
                    $('#bookNumber').val(data.BOOKED.length)
                    book=data.BOOKED;
                    user=data.USERS;
                    setPostazioni(data.BOOKED);
                    setTable(data.BOOKED);
                }
            },
            error: function (errorThrown) {
                console.log(errorThrown);
            }
        });

        setInterval(function(){
            load();
        }, 60000);
    }else{
        console.log("Error!");
    }
}

function setTable(BOOK){
    $('#booksRow').html("");

    $.each(BOOK, function(key, val){
        let decoration="class=\"bookedStatus\"";
        let checkout, checkin;

        if (val.period==="PM" && new Date().getHours()<14 )
            checkin='<input type="button" class="btn btn-primary disabled" id="checkIn" value="Check In" onclick="checkIN('+val.book_id+')" disabled>';
        else
            checkin='<input type="button" class="btn btn-primary active" id="checkIn" value="Check In" onclick="checkIN('+val.book_id+')">';

        if(val.checkin!=null) {
            checkin = zeropadInt(val.checkin.hour,2) + ':' + zeropadInt(val.checkin.minute, 2);
            decoration="class=\"checkInStatus\"";
            checkout='<input type="button" class="btn btn-info active" id="checkOut" value="Check Out" onclick="checkOUT('+val.book_id+')">';
        }else
            checkout='<input type="button" class="btn btn-info disabled" id="checkOut" value="Check Out" disabled>';


        if(val.checkout!=null){
            checkout=zeropadInt(val.checkout.hour,2) + ':' + zeropadInt(val.checkout.minute,2);
            decoration="class=\"checkOutStatus\"";
        }

        let date=$('#date').val().split("-");
        if( (new Date(date[0],date[1]-1,date[2]).getTime()) > (new Date().getTime())){
            checkin="";
            checkout="";
        }

        let period;
        if(val.period === "Full" || val.period === "AM" )
            period="8:00";
        else
            period="14:00";

        if(val.period === "Full" || val.period === "PM" )
            period+="-19:00";
        else
            period+="-13:00";

        let postations="";
        $.each(val.postations, function(key2, val2){
            postations+="F"+val2.row+"P"+val2.number+", ";
        });
        postations=postations.slice(0,-2);

        let selUser=userByID(val.user_id);

        text='<tr '+decoration+'>'+
            '<th scope="row">'+zeropadInt(val.book_id,4)+'</th>' +
            '<td>'+ selUser.nome + " " + selUser.cognome+'</td>'+
            '<td>'+period+'</td>'+
            '<td>'+postations+'</td>'+
            '<td>'+val.extra_chair+'</td>'+
            '<td class="text-center">'+checkin+'</td>'+
            '<td class="text-center">'+checkout+'</td>'+
            '</tr>';
        $('#booksRow').append(text);
    });
}

function reset(){
    let id;
    $('.qty').val(0);
    for (let i = 10; i < 60; i++) {
        id="#pos_"+ i;
        setFree(id, Snap.select(id));
    }
}

function checkIN(bookID){
    console.log("Wanna do check-in for book: " + bookID)
    let selBook=bookByID(bookID);
    let selUser=userByID(selBook.user_id);
    $('#guestsCheckInAdv').html("Check-in prenotazione <b>"+bookID+"</b> di <b>" + selUser.nome + " " + selUser.cognome + "</b>");
    $('#guestsCheckInBtn').attr('onclick','registerCheckIn('+bookID+')');
    $('#guestsCheckInModal').modal('show');
}

function checkOUT(bookID){
    console.log("Wanna do check-out for book: " + bookID)

    $.ajax({
        url: './beachManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'CheckOUT',
            'BookID': bookID
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#responseModalLabel').html("Conferma");
            else
                $('#responseModalLabel').html("Errore");
            $('#guestsCheckInModal').modal('hide');
            $('#responseMessage').html(data.MESSAGE);
            $('#responseModal').modal('show');
            setTimeout(function(){ $('#responseModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function registerCheckIn(bookID){
    let guests = $('#guestsList').val();
    $.ajax({
        url: './beachManage',
        dataType: 'json',
        type: 'post',
        data: {
            'Type': 'CheckIN',
            'BookID': bookID,
            'Guests': guests
        },
        success: function (data) {
            if(data.RESPONSE === 'Confirm') //Dati ok
                $('#responseModalLabel').html("Conferma");
            else
                $('#responseModalLabel').html("Errore");
            $('#guestsCheckInModal').modal('hide');
            $('#responseMessage').html(data.MESSAGE);
            $('#responseModal').modal('show');
            setTimeout(function(){ $('#responseModal').modal('hide'); }, 1500);
            load();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setPostazioni(BOOK){
    $.each(BOOK, function(key, val){
        $.each(val.postations, function(key2, pos){
            let status;

            let id="#pos_"+ pos.id;
            if(val.checkout!=null) {
                setCheckOut(id, Snap.select(id));
                status = "Servizio finito";
            }
            else if ( val.checkin!=null) {
                setCheckIn(id, Snap.select(id));
                status = "Servizio in corso";
            }
            else {
                setBooked(id, Snap.select(id));
                status = "Prenotata";
            }

            elem=Snap.select("#pos_"+ pos.id);
            let selUser=userByID(val.user_id);
            elem.data('row1', 'ID pren. ' + zeropadInt(val.book_id,4))
            elem.data('row2', 'Stato: ' + status)
            elem.data('row3', 'Cliente: ' + selUser.nome + " " + selUser.cognome)
            elem.data('row4', 'Telefono: ' + selUser.cellulare)
            elem.data('row5', 'E-Mail: ' + selUser.email);
        });
    });
}

function userByID(id){
    let i=0;
    $.each(user, function(key, val){
        if(val.idUtente===id) {
            return false;
        }
        i++;
    });
    return user[i];
}

function bookByID(id){
    let i=0;
    $.each(book, function(key, val){
        if(val.book_id===id) {
            return false;
        }
        i++;
    });
    return book[i];
}

function checkInput(val) {
    return val != null && val.trim() !== "";
}

function setDate(data){
    let month = data.getMonth() + 1;
    let day = data.getDate();
    let year = data.getFullYear();
    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    let minDate= year + '-' + month + '-' + day;
    $('#date').val(minDate).attr('min', minDate);
}

function setFree(id, elem){
    //console.log("id: " + id + ", elem: "+ elem);
    $(id+' ellipse[class^=\'st1\']').attr("class","").addClass("st1");
    $(id+' rect[class^=\'st2\']').attr("class","").addClass("st2");
    $(id+' path[class^=\'st3\']').attr("class","").addClass("st3");
    $(id+' rect[id^=\'rect_\']').attr("disabled","");

    elem.data('status', 'F');
    elem.data('row1', '')
    elem.data('row2', '')
    elem.data('row3', '')
    elem.data('row4', '')
    elem.data('row5', '')
}

function setBooked(id, elem){
    $(id+' ellipse[class^=\'st1\']').attr("class","").addClass("st1-booked");
    $(id+' rect[class^=\'st2\']').attr("class","").addClass("st2-booked");
    $(id+' path[class^=\'st3\']').attr("class","").addClass("st3-booked");
    $(id+' rect[id^=\'rect_\']').removeAttr("disabled","");
    elem.data('status', 'B');
}

function setCheckIn(id, elem){
    $(id+' ellipse[class^=\'st1\']').attr("class","").addClass("st1-checkin");
    $(id+' rect[class^=\'st2\']').attr("class","").addClass("st2-checkin");
    $(id+' path[class^=\'st3\']').attr("class","").addClass("st3-checkin");
    $(id+' rect[id^=\'rect_\']').removeAttr("disabled","");
    elem.data('status', 'CI');
}

function setCheckOut(id, elem){
    $(id+' ellipse[class^=\'st1\']').attr("class","").addClass("st1-checkout");
    $(id+' rect[class^=\'st2\']').attr("class","").addClass("st2-checkout");
    $(id+' path[class^=\'st3\']').attr("class","").addClass("st3-checkout");
    $(id+' rect[id^=\'rect_\']').removeAttr("disabled","");
    elem.data('status', 'CO');
}