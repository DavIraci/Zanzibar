<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
  Date: 15/10/2020
  Time: 18:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
        <meta http-equiv="Pragma" content="no-cache" />
        <meta http-equiv="Expires" content="0" />
        <title>Zanzibar Lido - Modifica Dati</title>

        <link rel="shortcut icon" href="/Zanzibar/image/favicon.ico" />

        <!-- CSS, includes Bootstrap (off-line)-->
        <link href="/Zanzibar/css/styles.css" rel="stylesheet">
        <link href="/Zanzibar/css/heading.css" rel="stylesheet">
        <link href="/Zanzibar/css/body.css" rel="stylesheet">
        <link href="/Zanzibar/css/carousel.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

        <!-- Script -->
        <script src="/Zanzibar/js/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="/Zanzibar/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>
        <script src="/Zanzibar/js/scripts.js"></script>
        <script src="/Zanzibar/js/snap.svg-min.js"></script>
        <script src="/Zanzibar/js/Common/book.js"></script>

        <!--SNAP-->
        <style>
            svg{
                width: 100%;
                height: 70%;
            }
            rect:hover{
                fill: #f6da9b;
                opacity: 35%;
            }
            .st1-occupied{
                fill:none;
                stroke-width:5;
                stroke-miterlimit:10;
                stroke: red;
            }
            .st2-occupied{
                fill: red;
            }
            .st3-occupied {
                fill: red;
                stroke: red;
                stroke-miterlimit: 10;
            }
            .st1-selected{
                fill:none;
                stroke-width:5;
                stroke-miterlimit:10;
                stroke: #27aabe;
            }
            .st2-selected{
                fill: #27aabe;
            }
            .st3-selected{
                fill: #27aabe;
                stroke: #27aabe;
                stroke-miterlimit:10;
            }
        </style>
        <!--script>
            $(document).ready(function () {
                //load();
            });


            window.onload = function () {

                var s = Snap('#map');

                Snap.load("/Zanzibar/image/mapALL.svg", function(f){

                    /*console.log("Prima dei valori");

                    $('#right ellipse.st1').removeClass("st1").addClass("st1-selected");
                    $('#right rect.st2').removeClass("st2").addClass("st2-selected");
                    $('#right path.st3').removeClass("st3").addClass("st3-selected");
                    console.log("Dopo i primi valori");

                    $('#left ellipse.st1').removeClass("st1").addClass("st1-occupied");
                    $('#left rect.st2').removeClass("st2").addClass("st2-occupied");
                    $('#left path.st3').removeClass("st3").addClass("st3-occupied");
                    console.log("Dopo i secondi valori");

                    $('#pos_59 ellipse.st1').removeClass("st1").addClass("st1-selected");
                    $('#pos_59 rect.st2').removeClass("st2").addClass("st2-selected");
                    $('#pos_59 path.st3').removeClass().addClass("st3-selected");
                    console.log("Dopo i valori");*/

                    /*f.selectAll('[id^="pos_"]').forEach(function(el) {
                        //console.log(el.node.id);
                        el.data('status', 'F');
                        console.log(el.data('status'));
                    }*/


                    f.selectAll('[id^="rect_"]').forEach(function(el){

                        var id_temp = '#pos_'+ el.node.id[el.node.id.length-2]+el.node.id[el.node.id.length-1];
                        var elem_temp = Snap.select(id_temp);
                        //console.log(id_temp + elem_temp);

                        //elem_temp.data('status', 'F');

                        el.click(function(ev){

                            var id = '#pos_'+ ev.target.id[ev.target.id.length-2]+ev.target.id[ev.target.id.length-1];
                            var elem = Snap.select(id);
                            console.log(elem.data('status', 'S'));
                            //console.log(id + elem);
                            setSelected(id);
                            /*var elem = Snap.select('#'+ev.target.id);

                            if( elem.data('status')=='O' )
                            {
                                // nothing to do
                            }
                            else if( elem.data('status')=='S' )
                            {
                                // the seat is already selected, the user wants to deselect it
                                check('D', ev.target.id);
                                elem.data('status', 'D');
                            }
                            else
                            {
                                // the seat is free, the user wants to select it
                                check('S', ev.target.id);
                                elem.data('status', 'S');
                            }*/
                        });

                    });

                    s.append(f);
                });
            };

            function load(){
                var element;
                //console.log('#pos_'+i);

                for (let i=10; i<60; i++){
                    element=Snap.select('#pos_'+i);
                    console.log(element);
                    element.data('status', 'F');
                    console.log(element.data('status'));

                }
            }

            function setSelected(id){
                $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-selected");
                $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-selected");
                $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-selected");

            }
            function setOccupied(id){
                $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1-occupied");
                $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2-occupied");
                $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3-occupied");
            }
            function setUnselected(id){
                $(id+' ellipse.st1').removeClass("st1 st1-occupied st1-selected").addClass("st1");
                $(id+' rect.st2').removeClass("st2 st2-occupied st2-selected").addClass("st2");
                $(id+' path.st3').removeClass("st3 st3-occupied st3-selected").addClass("st3");
            }

        </script-->

        <%@ include file="/WEB-INF/header.jsp"%>
    </head>

    <body id="page-top">
        <main role="main" class="masthead">
            <section class="page-section portfolio">
                <!-- Date picker -->
                <div class="form-group row" style="font-style: normal">
                    <label for="date" class="col-2 col-form-label" style="font-size: 1.4rem">Data</label>
                    <div class="col-5">
                        <input class="form-control" type="date" id="date" name="date" pattern="\d{2}/\d{2}/\d{4}" onchange="load()">
                    </div>
                </div>
                <!-- Map -->
                <div id="map">
                </div>
            </section>
        </main>
        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
