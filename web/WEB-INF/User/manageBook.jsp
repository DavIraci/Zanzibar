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
        <title>Zanzibar Lido - Gestisci Prenotazioni</title>

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
        <script src="/Zanzibar/js/User/manageBook.js"></script>

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
            .table td.fit,
            .table th.fit {
                white-space: nowrap;
                width: 1%;
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

                    <div class="row" style="justify-content: center" id="message-alert"></div>
                        <table class="table table-striped table-responsive">
                            <thead class="thead-dark">
                            <tr>
                                <th class="fit" scope="col">ID</th>
                                <th class="fit" scope="col">Giorno</th>
                                <th class="fit" scope="col">Fascia Oraria</th>
                                <th class="fit" scope="col">Postazioni</th>
                                <th class="fit" scope="col">Sdraio Extra</th>
                                <th class="fit" scope="col">Cancellata</th>
                                <th class="fit" scope="col">Check-in</th>
                                <th class="fit" scope="col">Check-out</th>
                                <th class="fit" scope="col">Costo</th>
                                <th class="fit" scope="col">Azioni</th>
                            </tr>
                            </thead>
                            <tbody id="booksRow">
                            </tbody>
                        </table>
                </section>
            </div>
        </div>
    </main>

        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
