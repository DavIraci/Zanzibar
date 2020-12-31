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
        <script src="/Zanzibar/js/User/ManageBook.js"></script>

        <style>
            .canceled{
                text-decoration: line-through;
                background-color: rgb(255, 77, 77) !important;
            }
            .finished{
                background-color: rgb(77, 255, 77) !important;
            }
            .actions:hover{
                color: grey;
                cursor: pointer;
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
                        <h1>Gestisci Prenotazioni</h1>
                    </div>
                    <!--div class="row" style="text-align: center"-->
                        <table class="table table-striped">
                            <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Giorno</th>
                                <th scope="col">Fascia Oraria</th>
                                <th scope="col">Postazioni</th>
                                <th scope="col">Sdraio Extra</th>
                                <th scope="col">Cancellata</th>
                                <th scope="col">Check-in</th>
                                <th scope="col">Check-out</th>
                                <th scope="col">Costo</th>
                                <th scope="col">Azioni</th>
                            </tr>
                            </thead>
                            <tbody id="booksRow">
                            </tbody>
                        </table>
                    <!--/div-->
                </section>
            </div>
        </div>
        <!--
        <div class="container mt-4">
            <div class="row" style="justify-content: center" id="message-alert">
            </div>
            <div class="row" style="place-content: center;">
                <div class="col-sm-3 col-sm-offset-3">
                    <div class="input-group mb-3">
                        <label id="extra-chair" for="myform"></label><br>
                        <div id='myform'>
                            <input type='button' value='-' class='qtyminus btn btn-danger' field='quantity' style="border-radius: 0.5rem"/>
                            <input type='text' name='quantity' value='0' class='qty' style="max-width: 25%" readonly/>
                            <input type='button' value='+' class='qtyplus btn btn-success' field='quantity' style="border-radius: 0.5rem"/>
                        </div>
                    </div>
                </div>
                <div class="col-sm-9" style="text-align: right;">
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
        </div-->
    </main>

        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
