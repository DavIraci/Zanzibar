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
        <title>Zanzibar Lido - Contagio Covid19</title>

        <link rel="shortcut icon" href="/Zanzibar/image/favicon.ico"/>

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
        <script src="/Zanzibar/js/Company/covidAlert.js"></script>

        <style>
            .actions:hover{
                color: grey;
                cursor: pointer;
            }
            td div{
                max-width: 9rem;
            }
            td div input{
                line-height: 0.5rem !important;
            }
            .table td.fit,
            .table th.fit {
                white-space: nowrap;
                width: 1%;
            }
        </style>

        <%@ include file="/WEB-INF/header.jsp"%>
    </head>

    <body id="page-top">
    <main role="main" class="masthead" style="min-height: 80%">
        <div class="container">
            <div class="marketing">
                <section class="text-center">
                    <div class="row" style="justify-content: center">
                        <h1>Segnalazione Covid</h1>
                    </div>
                    <div class="row" style="text-align: center">
                        <div class="col-sm-6">
                            <label for="date">Data:</label>
                            <input class="form-control" type="date" id="date" name="date" pattern="\d{2}/\d{2}/\d{4}" onchange="load()">
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="customersSelect">Cliente risultato positivo:</label>
                                <select class="form-control" id="customersSelect" name="customersSelect" onchange="$('#covidAlertConfirmBtn').removeAttr('disabled').removeClass('disabled');">
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="justify-content: center" id="covidAlert-message-alert"></div>
                    <div>
                        <div class="text-right">
                            <input type="button" class="btn btn-info float-right" value="Avverti" id="covidAlertConfirmBtn" data-toggle="modal" data-target="#covidAlertResponseMessageModal">
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <!-- Covid Alert Response Message Modal -->
    <div class="modal fade bd-example-modal" tabindex="-1" role="dialog" id="covidAlertResponseMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="covidAlertResponseMessageLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="covidAlertResponseMessageText">
                </div>
                <div class="modal-footer d-none" id="covidAlertStatusConfirm">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    <button type="button" class="btn btn-primary" id="covidAlertBtn" >Conferma</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Covid Alert Response Message Modal -->


    <%@ include file="/WEB-INF/footer.jsp"%>
    </body>
</html>
