<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
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
        <title>Zanzibar Lido - Prenota Postazione</title>

        <link rel="shortcut icon" href="/Zanzibar/image/favicon.ico" />

        <!-- CSS, includes Bootstrap (off-line)-->
        <link href="/Zanzibar/css/styles.css" rel="stylesheet">
        <link href="/Zanzibar/css/heading.css" rel="stylesheet">
        <link href="/Zanzibar/css/body.css" rel="stylesheet">
        <link href="/Zanzibar/css/carousel.css" rel="stylesheet">

        <!-- Script -->
        <script src="https://kit.fontawesome.com/5a20e58df2.js" crossorigin="anonymous"></script>
        <script src="/Zanzibar/js/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="/Zanzibar/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>
        <script src="/Zanzibar/js/scripts.js"></script>
        <script src="/Zanzibar/js/Utils.js"></script>
        <script src="/Zanzibar/js/snap.svg-min.js"></script>
        <script src="/Zanzibar/js/User/book.js"></script>

        <!--SNAP-->
        <style>
            svg{
                width: 100%;
                height: 70%;
            }
            rect:hover{
                fill: #f6da9b;
                opacity: 35%;
                cursor: pointer;
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
            #tooltip {
                opacity: 0;
                color: #383d41;
                background-color: #e2e3e5;
                border: 2px solid #d6d8db;
                border-radius: 6px;
                position: fixed;
                padding: 10px 5px;
            }
            #tooltip p {
                font-family: tahoma;
                margin:0;
                padding:0;
            }
            #tooltip p.row3 {
                font-weight:bold;
            }
            input {
                text-align: center;
            }
            td div input{
                line-height: 0.75rem !important;
            }
        </style>


        <%@ include file="/WEB-INF/header.jsp"%>
        <%@ include file="/WEB-INF/User/checkout.jsp"%>
    </head>

    <body id="page-top">
    <main role="main" class="masthead" style="min-height: 80%">
        <div class="container">
            <div class="marketing">
                <section class="text-center">
                    <div class="row" style="justify-content: center">
                        <h1>Prenotazione</h1>
                    </div>
                    <div class="row" style="text-align: center">
                        <div class="col-sm-6">
                            <label for="date">Data:</label>
                            <input class="form-control" type="date" id="date" name="date" pattern="\d{2}/\d{2}/\d{4}" onchange="reset();load()">
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="period">Fascia oraria:</label>
                                <select class="form-control" id="period" name="period" onchange="reset();load()">
                                    <option id="op_full" value="Full" selected="selected">Tutto il giorno </option>
                                    <option id="op_am" value="AM">Mattina (8:00-13:00)</option>
                                    <option id="op_pm" value="PM">Pomeriggio (14:00-19:00)</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <!-- Map -->
        <div id="map"></div>
        <div id="tooltip"></div>
        <div class="container mt-4">
            <div class="row" style="justify-content: center" id="message-alert">
            </div>
            <div class="row" style="place-content: center;">
                <div class="col-sm-3 col-sm-offset-3">
                    <div class="input-group mb-3">
                        <label id="extra-chair" for="myform"></label><br>
                        <div id='myform'>
                            <input id="bookQtyMinus" type='button' value='-' class='qtyminus btn btn-danger' field='quantity' style="border-radius: 0.5rem"/>
                            <input id="bookQty" type='text' name='quantity' value='0' class='qty align-middle' style="max-width: 25%" readonly/>
                            <input id="bookQtyPlus" type='button' value='+' class='qtyplus btn btn-success' field='quantity' style="border-radius: 0.5rem"/>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9 text-right">
                    <div id="postazioni">
                    </div>
                    <div id="sdraio">
                    </div>
                    <div id="totale">
                    </div>
                    <div>
                        <input type="button" class="btn-lg btn-primary disabled" id="checkBook" value="Conferma e paga">
                    </div>
                </div>
            </div>
        </div>
    </main>

        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
