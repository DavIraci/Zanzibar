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
        <script src="/Zanzibar/js/Common/ManageProfile.js"></script>

        <%@ include file="/WEB-INF/header.jsp"%>
    </head>

    <body id="page-top">


        <main role="main" class="masthead">
            <div class="container col-lg-6 marketing">

                <div class="text-center">
                    <h2 class="page-section-heading">Modifica dati profilo</h2>
                </div>

                <div class="modal-body">
                    <div id="response">

                    </div>
                    <form method="POST" class="was-validated" id="formManageProfile">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="name">Nome</label>
                                    <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="name" name="username" value="<%= ((User) request.getSession().getAttribute("USER")).getNome()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="birth">Data di Nascita</label><br>
                                    <input type="date" class="form-control" id="birth" name="birth" min="1900-01-01" max="2020-12-31" pattern="\d{2}/\d{2}/\d{4}" value="<%= ((User) request.getSession().getAttribute("USER")).getBirthday()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="mobile">Cellulare</label>
                                    <input title="Inserire nel format 3xx-xxxxxxx!" type="tel" class="form-control" id="mobile" placeholder="<%= ((User) request.getSession().getAttribute("USER")).getCellulare()%>" name="mobile" pattern="[0-9]{10}" value="<%= ((User) request.getSession().getAttribute("USER")).getCellulare()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="telephone">Telefono</label>
                                    <input title="Inserire nel format 3xx-xxxxxxx!" type="tel" class="form-control" id="telephone" placeholder="Inserisci numero cellulare" name="telephone" pattern="[0-9]{10}" value="<%= ((User) request.getSession().getAttribute("USER")).getTelefono()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label for="surname">Cognome</label>
                                    <input  type="text" class="form-control" id="surname" placeholder="Inserisci cognome" name="surname" value="<%= ((User) request.getSession().getAttribute("USER")).getCognome()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="email">Indirizzo e-mail</label>
                                    <input type="email" class="form-control" id="email" placeholder="Inserisci indirizzo e-mail" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="<%= ((User) request.getSession().getAttribute("USER")).getEmail()%>" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd1">Nuova Password</label>
                                    <input  class="form-control" id="pwd1" name="password" oninput="validatePasswordConf()" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Inserisci password" type="password">
                                    <span toggle="#pwd1" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Inserisci 8 caratteri,di cui almeno 1 maiuscolo, 1 miniscuolo e 1 numero</div>
                                </div>
                                <div class="form-group">
                                    <label for="pwd2">Ripeti nuova password</label>
                                    <input  class="form-control" id="pwd2" name="passwordrep" oninput="validatePasswordConf()" placeholder="Ripeti password" type="password">
                                    <span toggle="#pwd2" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Inserisci la stessa password inserita precedentemente</div>
                                </div>
                            </div>
                        </div>

                        <!-- Register Modal footer -->
                        <div class="modal-footer">
                            <div class="form-group">
                                <label for="pwd3">Password attuale</label>
                                <input  class="form-control" id="pwd3" name="passwordcheck" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Inserisci l'attuale password" required type="password">
                                <span toggle="#pwd3" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                <div class="valid-feedback">Valido</div>
                                <div class="invalid-feedback">Inserire la password per autorizzare l'operazione</div>
                            </div>
                            <button type="submit" class="btn btn-primary">Aggiorna</button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>
