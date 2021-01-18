<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
    </head>
    <body>
        <!-- Login Modal -->
        <div class="modal fade" id="loginModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Accedi</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Login Modal body -->
                    <div class="modal-body">
                        <% if(request.getSession().getAttribute("Login")!=null && ( request.getSession().getAttribute("Login").equals("TRUE") || request.getSession().getAttribute("Login").equals("ERROR")) ){ %>
                                <script> $('#loginModal').modal('show') </script>
                        <%      if(request.getSession().getAttribute("Login").equals("ERROR")){ %>
                                    <div class="alert alert-danger alert-dismissible" role="alert">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                        Username e password errati! Riprovare
                                    </div>
                                <% }
                                request.getSession().removeAttribute("Login");
                            } %>
                        <form action="<%= response.encodeURL("j_security_check") %>" method="POST" class="was-validated">
                            <div class="form-group">
                                <label for="uname">Email:</label>
                                <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="uname" placeholder="Inserisci username" name="j_username" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                <div class="valid-feedback">Valido</div>
                                <div class="invalid-feedback">Per favore riempi questo campo</div>
                            </div>

                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input  type="password" class="form-control" id="pwd" placeholder="Inserisci password" name="j_password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                                <span toggle="#pwd" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                <div class="valid-feedback">Valido</div>
                                <div class="invalid-feedback">Per favore riempi questo campo</div>
                            </div>
                            <div class="form-group links">
                                <a onclick="showResetPwd()" style="text-decoration: underline;color: #1abc9c;cursor:pointer;"><small>Password dimenticata? Reimpostala!</small></a>
                            </div>

                            <!-- Login Modal footer -->
                            <div class="modal-footer">
                                <button type="submit"  class="btn btn-primary">Accedi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Login Modal -->

        <!-- Register Modal -->
        <div class="modal fade" id="registerModal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <!-- Register Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Registrazione</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                     <!-- Register Modal body -->
                    <div class="modal-body">
                        <div id="response"></div>
                        <form method="POST" class="was-validated" id="registerForm">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
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
                                        <label for="telephone">Telefono</label>
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
                                        <input  class="form-control" id="pwd1" name="password" oninput="validatePasswordConf()" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Inserisci password" required type="password">
                                        <span toggle="#pwd1" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="pwd2">Ripeti password</label>
                                        <input  class="form-control" id="pwd2" name="passwordrep" oninput="validatePasswordConf()" placeholder="Ripeti password" required type="password">
                                        <span toggle="#pwd2" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Register Modal footer -->
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Registrati</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Register Modal -->

        <!-- ResetPassword Modal -->
        <div class="modal fade" id="resetPasswordModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Reimposta Password</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- ResetPassword Modal body -->
                    <div class="modal-body">
                        <div id="responseResetPwd"></div>
                        <form method="POST" class="was-validated" id="resetPwdForm">
                            <div class="form-group">
                                <label for="resetmail">Indirizzo email associato:</label>
                                <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="resetmail" placeholder="Inserisci username" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                <div class="valid-feedback">Valido</div>
                                <div class="invalid-feedback">Per favore riempi questo campo</div>
                            </div>

                            <!-- ResetPassword Modal footer -->
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Reimposta Password</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- ResetPassword Modal -->
    </body>
</html>
