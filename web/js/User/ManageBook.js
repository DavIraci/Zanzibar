$(document).ready(function () {
    loadBook();
});

function loadBook(){
    $.ajax({
        url: './managebook',
        dataType: 'json',
        type: 'post',
        data: {},
        success: function (data) {
            setBook(data);
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function setBook(data){
    $.each(data.BOOK, function(key, val){
        var checkin = "-";
        if(val.checkin!=null)
            checkin=val.checkin.hour + ':' + zeropadInt(val.checkin.minute,2) + ':' + val.checkin.second;

        var checkout = "-";
        var decoration="";
        if(val.checkout!=null) {
            checkout=val.checkout.hour + ':' + zeropadInt(val.checkout.minute,2) + ':' + val.checkout.second;

        }
        var period;
        if(val.period == "Full" || val.period == "AM" )
            period="8:00";
        else
            period="14:00";

        if(val.period == "Full" || val.period == "PM" )
            period+="-19:00";
        else
            period+="-13:00";

        var invoice='<i class="fas fa-file-invoice mr-1 actions" onclick="takeInvoice('+val.book_id+')"></i>';
        var canc='<i class="far fa-calendar-times actions" onclick="cancOrder('+val.book_id+')"></i>'
        if (val.canceled==true) {
            decoration = "class=\"canceled\"";
            canc=invoice='';
        }

        var date= new Date(val.date.year, (val.date.monthValue-1), val.date.dayOfMonth);
        var today = new Date();

        if (date<= today && val.canceled==false){
            decoration="class=\"finished\"";
            canc='';
        }

        var postations="";
        $.each(val.postations, function(key, val2){
            postations+="F"+val2.row+"P"+val2.number+", ";
        });
        postations=postations.slice(0,-2);

        text='<tr '+decoration+'>'+
            '<th scope="row">'+zeropadInt(val.book_id,4)+'</th>' +
            '<td>'+zeropadInt(val.date.dayOfMonth,2) + '-' + zeropadInt(val.date.monthValue, 2) + '-' + val.date.year+'</td>'+
            '<td>'+period+'</td>'+
            '<td>'+postations+'</td>'+
            '<td>'+val.extra_chair+'</td>'+
            '<td>'+(val.canceled==true?"Si":"-")+'</td>'+
            '<td>'+checkin+'</td>'+
            '<td>'+checkout+'</td>'+
            '<td>'+parseFloat(val.price).toFixed(2)+' €</td>'+
            '<td>'+invoice+canc+'</td>'+
        '</tr>';
        //metodo di pagamento, azioni (fattura eliminare)
        $('#booksRow').append(text);
    });
}

function takeInvoice(id){
    $.ajax({
        url: './managebook',
        dataType: 'json',
        type: 'post',
        data: {
            'Request': "Invoid",
            'BookID': id
        },
        success: function (data) {
            var typemessage = data.RESPONSE == 'Confirm'?"alert-success":"alert-danger";
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

function cancOrder(id){
    $.ajax({
        url: './managebook?BookID='+id,
        dataType: 'json',
        type: 'DELETE',
        success: function (data) {
            var typemessage = data.RESPONSE == 'Confirm'?"alert-success":"alert-danger";
            let text='<div class="row" style="justify-content: center">' +
                '<div class="alert '+typemessage+' alert-dismissible" role="alert">' +
                '<button type="button" class="close" data-dismiss="alert">&times;</button>'+ data.MESSAGE +'</div> </div>';
            $('#message-alert').html(text);
            resetManageBook();
        },
        error: function (errorThrown) {
            console.log(errorThrown);
        }
    });
}

function resetManageBook(){
    $('#booksRow').html("");
    loadBook();
}

function zeropadInt(num, padlen) {
    var pad_char = '0';
    var pad = new Array(1 + padlen).join(pad_char);
    return (pad + num).slice(-pad.length);
}