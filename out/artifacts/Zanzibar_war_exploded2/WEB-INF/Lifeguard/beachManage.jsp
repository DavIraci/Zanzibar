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
        <title>Zanzibar Lido - Gestione Spiaggia</title>

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
        <script src="/Zanzibar/js/Lifeguard/beachManage.js"></script>

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
            .st1-booked{
                fill:none;
                stroke-width:5;
                stroke-miterlimit:10;
                stroke: red;
            }
            .st2-booked{
                fill: red;
            }
            .st3-booked {
                fill: red;
                stroke: red;
                stroke-miterlimit: 10;
            }
            .st1-checkin{
                fill:none;
                stroke-width:5;
                stroke-miterlimit:10;
                stroke: #27aabe;
            }
            .st2-checkin{
                fill: #27aabe;
            }
            .st3-checkin{
                fill: #27aabe;
                stroke: #27aabe;
                stroke-miterlimit:10;
            }
            .st1-checkout{
                fill:none;
                stroke-width:5;
                stroke-miterlimit:10;
                stroke: #a6a6a6;
            }
            .st2-checkout{
                fill: #a6a6a6;
            }
            .st3-checkout{
                fill: #a6a6a6;
                stroke: #a6a6a6;
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
            #tooltip p.row1, p.row2 {
                font-weight:bold;
            }
            input {
                text-align: center;
            }
            td div input{
                line-height: 0.75rem !important;
            }
            .table td.fit,
            .table th.fit {
                white-space: nowrap;
                width: 1%;
            }
            .bookedStatus{
                background-color: rgb(255, 77, 77) !important;
            }
            .checkInStatus{
                background-color: rgb(149, 222, 233) !important;
            }
            .checkOutStatus{
                background-color: rgb(230, 230, 230) !important;
            }
        </style>

        <%@ include file="/WEB-INF/header.jsp"%>
    </head>

    <body id="page-top">
    <main role="main" class="masthead">
        <div class="container">
            <div class="marketing">
                <section class="text-center">
                    <div class="row" style="justify-content: center">
                        <h1>Gestione Spiaggia</h1>
                    </div>
                    <div class="row" style="text-align: center">
                        <div class="col-sm-4">
                            <label for="date">Data:</label>
                            <input class="form-control" type="date" id="date" name="date" pattern="\d{2}/\d{2}/\d{4}" onchange="reset();load()">
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="period">Fascia oraria:</label>
                                <select class="form-control" id="period" name="period" onchange="reset();load()">
                                    <option id="op_full" value="Full" selected="selected">Tutto il giorno </option>
                                    <option id="op_am" value="AM">Mattina (8:00-13:00)</option>
                                    <option id="op_pm" value="PM">Pomeriggio (14:00-19:00)</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <label for="bookNumber">N° Prenotazioni:</label>
                            <input class="form-control" type="text" id="bookNumber" name="bookNumber" value="3" readonly>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <!-- Map -->
        <div id="map"></div>
        <div id="tooltip"></div>

        <div class="container mt-3">
            <div class="marketing">
                <section class="text-center">
                    <div class="row" style="justify-content: center">
                        <h1>Prenotazioni</h1>
                    </div>
                    <div class="row" style="justify-content: center" id="lifeguard-message-alert"></div>
                    <table class="table table-striped table-responsive">
                        <thead class="thead-dark">
                        <tr>
                            <th class="fit" scope="col">ID</th>
                            <th class="fit" scope="col">Cliente</th>
                            <th class="fit" scope="col">Fascia Oraria</th>
                            <th class="fit" scope="col">Postazioni</th>
                            <th class="fit" scope="col">Sdraio Extra</th>
                            <th class="fit" scope="col">Check-in</th>
                            <th class="fit" scope="col">Check-out</th>
                        </tr>
                        </thead>
                        <tbody id="booksRow">
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </main>

    <!-- Guests Check-In Modal -->
    <div class="modal fade" id="guestsCheckInModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h5 class="modal-title">Registrazioni ospiti Check-In</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="guestsCheckInAdv">Check-in prenotazione XXXX1 di Davide Iraci</div>
                    <label for="guestsLabel">Inserisci i nomi degli ospiti</label>
                    <div class="collapse show" id="guestsLabel">
                        <textarea name="guestsList" id="guestsList" cols="30" rows="4" class="form-control" placeholder="Inserisci i nomi delle persone che stanno effettuando l'accesso al lido... "></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    <button type="button" class="btn btn-primary" id="guestsCheckInBtn">Effettua Check-In</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Guests Check-In Modal -->

    <!-- Response Modal -->
    <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" id="responseModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="responseModalLabel">Conferma</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="responseMessage">
                </div>
            </div>
        </div>
    </div>
    <!-- /Response to Cart Modal -->

        <%@ include file="/WEB-INF/footer.jsp"%>
    </body>
</html>
