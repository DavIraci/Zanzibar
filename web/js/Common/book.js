$(document).ready(function () {

    var today = new Date();
    $('#date').val(today.getFullYear()+'-'+(today.getMonth()+1) + '-'+ today.getDate());


    var s = Snap('#map');

    Snap.load("/Zanzibar/image/mapALL.svg", function(f){
        //load();
        /*$('#right ellipse.st1').removeClass("st1").addClass("st1-selected");
        $('#right rect.st2').removeClass("st2").addClass("st2-selected");
        $('#right path.st3').removeClass("st3").addClass("st3-selected");
        console.log("Dopo i primi valori");

        $('#left ellipse.st1').removeClass("st1").addClass("st1-occupied");
        $('#left rect.st2').removeClass("st2").addClass("st2-occupied");
        $('#left path.st3').removeClass("st3").addClass("st3-occupied");
        console.log("Dopo i secondi valori");*/

        /*f.selectAll('[id^="pos_"]').forEach(function(el) {
            //console.log(el.node.id);
            el.data('status', 'F');
            console.log(el.data('status'));

        */f.selectAll('[id^="rect_"]').forEach(function(el){

            /*var id_temp = '#pos_'+ el.node.id[el.node.id.length-2]+ el.node.id[el.node.id.length-1];
            var elem_temp = Snap.select(id_temp);
            console.log(id_temp + elem_temp);*/

            el.parent().data('status', 'F');

            el.click(function(ev){

                var elem = el.parent();
                var id = '#'+ elem.node.id;

                if( elem.data('status')=='O' ){
                    //Occupato
                }
                else if( elem.data('status')=='S' )
                {
                    // The seat is already selected, the user wants to deselect it
                    //check('D', ev.target.id);
                    setUnselected(id, elem);
                }
                else
                {
                    // the seat is free, the user wants to select it
                    //check('S', ev.target.id);
                    setSelected(id, elem);
                }
            });

        });

        s.append(f);
    });
});

function load(){
    let date = $('#date').val();
    if (checkInput(date)) {
        $.ajax({
            url: './spiaggia',
            dataType: 'json',
            type: 'post',
            data: {
                'data': date
            },
            success: function (data) {
                //buildMappa(data[0]);
                setPostazioni(data[1]);
            },
            error: function (errorThrown) {
                console.log(errorThrown);
            }
        });
    }
}

function setPostazioni(val){
    console.log("setPostazioni!");
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
function setUnselected(id, elem){
    $(id+' ellipse.st1-selected').removeClass("st1 st1-occupied st1-selected").addClass("st1");
    $(id+' rect.st2-selected').removeClass("st2 st2-occupied st2-selected").addClass("st2");
    $(id+' path.st3-selected').removeClass("st3 st3-occupied st3-selected").addClass("st3");
    elem.data('status', 'F');
}
