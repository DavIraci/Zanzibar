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
        <title>Zanzibar Lido - Gestione impiegati</title>

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
        <script src="/Zanzibar/js/Company/employees.js"></script>

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
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4" style="justify-content: center">
                            <h1>Impiegati</h1>
                        </div>
                        <div class="col-md-4 mb-2">
                            <input data-toggle="modal" data-target="#registerEmployeeModal" type="button" class="btn btn-info active float-right" value="Aggiungi">
                        </div>
                    </div>
                    <div class="row" style="justify-content: center" id="employees-message-alert"></div>
                    <table class="table table-striped table-responsive">
                        <thead class="thead-dark">
                            <tr>
                                <th class="fit" scope="col">Matricola</th>
                                <th class="fit" scope="col">Nome</th>
                                <th class="fit" scope="col">Cognome</th>
                                <th class="fit" scope="col">Ruolo</th>
                                <th class="fit" scope="col"></th> 
                                <th class="fit" scope="col"></th>
                            </tr>
                        </thead>
                        <tbody id="employeesRow">
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </main>

    <!-- Employee Response Message Modal -->
    <div class="modal fade bd-example-modal" tabindex="-1" role="dialog" id="employeesResponseMessageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="employeesResponseMessageLabel"></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="employeesResponseMessageText">
                </div>
                <div class="modal-footer d-none" id="changeRoleConfirm">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    <button type="button" class="btn btn-primary" id="changeStatusBtn" >Conferma</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Kitchen Response Message Modal -->

    <!-- Register Employee Modal -->
    <div class="modal fade" id="registerEmployeeModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Register Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Registrazione Impiegato</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Register Modal body -->
                <div class="modal-body">
                    <form class="was-validated" id="newEmployeeForm">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group" >
                                    <label for="name">Nome</label>
                                    <input type="text" class="form-control" id="name" placeholder="Inserisci nome" name="username" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="birth">Data di Nascita</label><br>
                                    <input type="date" class="form-control" id="birth" name="birth" min="1900-01-01" max="2020-12-31" pattern="\d{2}/\d{2}/\d{4}" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="mobile">Cellulare</label>
                                    <input title="Inserire nel format 3xx-xxxxxxx!" type="tel" class="form-control" id="mobile" placeholder="Inserisci numero cellulare" name="mobile" pattern="[0-9]{10}" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="telephone">Telefono (Facoltativo)</label>
                                    <input title="Inserire nel format 3xx-xxxxxxx!" type="tel" class="form-control" id="telephone" placeholder="Inserisci numero cellulare" name="telephone" pattern="[0-9]{10}">
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="surname">Cognome</label>
                                    <input  type="text" class="form-control" id="surname" placeholder="Inserisci cognome" name="surname" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="email">Indirizzo e-mail</label>
                                    <input type="email" class="form-control" id="email" placeholder="Inserisci indirizzo e-mail" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd1">Password</label>
                                    <input  class="form-control" id="pwd1" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Inserisci password" required type="password">
                                    <span toggle="#pwd1" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="role">Selziona ruolo</label>
                                    <select class="form-control" id="role" required>
                                       <option value="" selected disabled hidden> --Seleziona un ruolo-- </option>
                                       <option value="Admin">Amministratore</option>
                                       <option value="CashDesk">Cassa/Banco</option>
                                       <option value="Lifeguard">Bagnino</option>
                                       <option value="Cook">Cucina</option>
                                    </select>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore seleziona questo campo</div>
                                </div>
                            </div>
                        </div>

                        <!-- Register Modal footer -->
                        <div class="modal-footer">
                            <input type="button" class="btn btn-primary active" value="Registra" id="addNewEmployeeBtn">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- /Register Employee Modal -->


    <%@ include file="/WEB-INF/footer.jsp"%>
    </body>
</html>
