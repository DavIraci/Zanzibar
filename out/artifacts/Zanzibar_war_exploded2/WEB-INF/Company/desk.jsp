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
        <title>Zanzibar Lido - Cassa</title>

        <link rel="shortcut icon" href="./image/favicon.ico"/>

        <!-- CSS, includes Bootstrap (off-line)-->
        <link href="./css/styles.css" rel="stylesheet">
        <link href="./css/heading.css" rel="stylesheet">
        <link href="./css/body.css" rel="stylesheet">
        <link href="./css/carousel.css" rel="stylesheet">

        <!-- Script -->
        <script src="https://kit.fontawesome.com/5a20e58df2.js" crossorigin="anonymous"></script>
        <script src="./js/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="./js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>
        <script src="./js/scripts.js"></script>
        <script src="./js/Utils.js"></script>
        <script src="./js/Company/desk.js"></script>

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
                        <h1>Ordini</h1>
                    </div>

                    <div class="row" style="justify-content: center" id="desk-message-alert"></div>
                    <table class="table table-striped table-responsive">
                        <thead class="thead-dark">
                            <tr>
                                <th class="fit" scope="col">ID</th>
                                <th class="fit" scope="col">Cliente</th>
                                <th class="fit" scope="col">Data</th>
                                <th class="fit" scope="col">N Prodotti</th>
                                <th class="fit" scope="col">Stato</th>
                                <th class="fit" scope="col">Pagato</th>
                                <th class="fit" scope="col"></th>
                                <th class="fit" scope="col"></th>
                            </tr>
                        </thead>
                        <tbody id="deskOrdersRow">
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </main>

    <!-- Kitchen Response Message Modal -->
    <div class="modal fade bd-example-modal" tabindex="-1" role="dialog" id="deskResponseMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="deskResponseMessageLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="deskResponseMessageText">
                </div>
                <div class="modal-footer d-none" id="changeStatusConfirm">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    <button type="button" class="btn btn-primary" id="changeStatusBtn" >Conferma</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Kitchen Response Message Modal -->

    <!-- Order Detail Modal -->
    <div class="modal fade bd-example-modal" tabindex="-1" role="dialog" id="orderDetailModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="orderDetailMessageLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="orderDetailMessageText">
                    <div class="order-md-2 mb-4">
                        <h4 class="d-flex justify-content-between align-items-center mb-3">
                            <span class="text-muted">Dettagli ordine</span>
                            <span class="badge badge-secondary badge-pill" id="orderProductsNumber">5(numero prodotti)</span>
                        </h4>
                        <ul class="list-group mb-3 sticky-top" id="orderProductsList">
                        </ul>
                    </div>
                </div>
                <div class="modal-footer" id="orderDetailFooter">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Order Detail Modal -->


    <%@ include file="/WEB-INF/footer.jsp"%>
    </body>
</html>
