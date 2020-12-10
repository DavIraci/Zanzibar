$(document).ready(function () {

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
                //var elem = Snap.select(id);
                var elem = el.parent();
                var id = '#'+ elem.node.id;
                //console.log(id + elem);

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

    //load();
    $('#right ellipse.st1').removeClass("st1").addClass("st1-selected");
    $('#right rect.st2').removeClass("st2").addClass("st2-selected");
    $('#right path.st3').removeClass("st3").addClass("st3-selected");

    $('#left ellipse.st1').removeClass("st1").addClass("st1-occupied");
    $('#left rect.st2').removeClass("st2").addClass("st2-occupied");
    $('#left path.st3').removeClass("st3").addClass("st3-occupied");
});

function load(){
    //console.log('#pos_'+i);

    var element;

    for (let i=10; i<60; i++){
        element=Snap.select('#pos_'+i);
        element.data('status', 'F');
        //console.log(element.data('status'));

    }
}

function setSelected(id, elem){
    $(id+' ellipse.st1').removeClass("st1").removeClass("st1-occupied").removeClass("st1-selected").addClass("st1-selected");
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
    $(id+' ellipse.st1-selected').removeClass("st1-selected").addClass("st1");
    $(id+' rect.st2-selected').removeClass("st2-selected").addClass("st2");
    $(id+' path.st3-selected').removeClass("st3-selected").addClass("st3");
    elem.data('status', 'F');
}
