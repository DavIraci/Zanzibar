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
        <title>Zanzibar Lido - Carrello</title>

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
        <script src="/Zanzibar/js/Utils.js"></script>
        <script src="/Zanzibar/js/User/cart.js"></script>

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
        <%@ include file="/WEB-INF/User/orderCheckout.jsp"%>
    </head>

    <body id="page-top">
    <main role="main" class="masthead">
        <div class="container">
            <div class="marketing">
                <section class="text-center">
                    <div class="row" style="justify-content: center">
                        <h1>Carrello</h1>
                    </div>

                    <div class="row" style="justify-content: center" id="cart-message-alert"></div>
                    <table class="table table-striped table-responsive">
                        <thead class="thead-dark">
                        <tr>
                            <th class="fit" scope="col">ID</th>
                            <th class="fit" scope="col">Nome Prodotto</th>
                            <th class="fit" scope="col">Categoria</th>
                            <th class="fit" scope="col">Quantità</th>
                            <th class="fit" scope="col">Prezzo</th>
                            <th class="fit" scope="col">Note</th>
                        </tr>
                        </thead>
                        <tbody id="productsRow">
                        </tbody>
                    </table>
                    <div>
                        <div class="text-right">
                            <div id="subTotal">
                            </div>
                            <div id="payOrder">
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <!-- Order Message Modal -->
    <div class="modal fade bd-example-modal" tabindex="-1" role="dialog" id="orderMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="orderMessageLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="orderMessageText">
                </div>
            </div>
        </div>
    </div>
    <!-- /Order Message Modal -->

        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
