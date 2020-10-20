<%--
  Created by IntelliJ IDEA.
  User: Cuchi
  Date: 16/10/2020
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iraci.model.User" %>
<html>
    <head>
        <script>
            function validatePasswordConf() {
                var messaggio = "Le password non corrispondono";

                // Variabili che contengono i dati inseriti dall'utente nel form di registrazione.
                var password= document.getElementById("pwd1");
                var password_conf = document.getElementById("pwd2");

                // Controlli sui pattern richiesti per tutti i campi.
                if( password.value != password_conf.value) {
                    password_conf.setCustomValidity(messaggio);
                    return false;
                }
                else {
                    password_conf.setCustomValidity('');
                    return true;
                }
            }
        </script>
        <!--style>
            .field-icon {
                float: right;
                margin-left: -50px;
                margin-top: -25px;
                margin-right: 2rem;
                position: relative;
                z-index: 4;
            }
        </style-->
    </head>
    <body>
        <!-- NavBar -->
        <nav class="navbar navbar-expand-lg bg-secondary fixed-top" id="mainNav">
            <div class="container">
                <% if(request.getRequestURI().equals("/Zanzibar/WEB-INF/index.jsp")){ %>
                    <a class="navbar-brand js-scroll-trigger" href="#page-top">ZanziBar</a>
                <% } else{ %>
                    <a class="navbar-brand js-scroll-trigger" href="${pageContext.request.contextPath}">ZanziBar</a>
               <% } %>
                <button class="navbar-toggler navbar-toggler-right font-weight-bold bg-primary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">Menu <i class="fas fa-bars"></i></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#service">SERVIZI</a>
                        </li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#beach">SPIAGGIA</a>
                        </li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#about">CHI SIAMO</a>
                        </li>
                        <li class="nav-item mx-0 mx-lg-1 dropdown">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded" data-toggle="dropdown" class="dropdown-toggle" href="#">
                                    <span class="profile-ava">
                                        <i class="fas fa-user-circle"></i>
                                    </span>
                            </a>
                            <ul class="dropdown-menu extended" style="left: auto;right: 0" id="dropDownMenu">
                                <% if(request.getSession().getAttribute("USER") == null){ %>
                                <li>
                                    <a href="${pageContext.request.contextPath}/login"><i class="icon_mail_alt" ></i> Accedi</a>
                                </li>
                                 <li>
                                     <a href="#" data-toggle="modal" data-target="#registerModal"><i class="icon_mail_alt" ></i> Registrati</a>
                                </li>
                                <% } else if(((User) request.getSession().getAttribute("USER")).getRuolo().equals("Admin")){ %>
                                <li class="eborder-top">
                                    <a ><i class="icon_profile">Admin</i> Admin <% pageContext.getOut().print( ((User) request.getSession().getAttribute("USER")).getCognome()); %></a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/login"><i class="icon_mail_alt" ></i> Accedi</a>
                                    <!--a href="#" data-toggle="modal" data-target="#loginModal"><i class="icon_mail_alt" ></i> Accedi</a-->
                                </li>
                                <li>
                                    <a href="#"><i class="icon_clock_alt"></i> Timeline</a>
                                </li>
                                <li>
                                    <a href="#"><i class="icon_chat_alt"></i> Chats</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/logout"><i class="icon_key_alt"></i> Log Out</a>
                                </li>
                                <li>
                                    <a href="documentation.html"><i class="icon_key_alt"></i> Documentation</a>
                                </li>
                                <% } else if(((User) request.getSession().getAttribute("USER")).getRuolo().equals("User") ){ %>
                                <li class="eborder-top">
                                    <a ><i class="icon_profile">User</i> User <% pageContext.getOut().print( ((User) request.getSession().getAttribute("USER")).getCognome()); %></a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/login"><i class="icon_mail_alt" ></i> Accedi</a>
                                    <!--a href="#" data-toggle="modal" data-target="#loginModal"><i class="icon_mail_alt" ></i> Accedi</a-->
                                </li>
                                <li>
                                    <a href="#"><i class="icon_clock_alt"></i> Timeline</a>
                                </li>
                                <li>
                                    <a href="#"><i class="icon_chat_alt"></i> Chats</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/logout"><i class="icon_key_alt"></i> Log Out</a>
                                </li>
                                <li>
                                    <a href="documentation.html"><i class="icon_key_alt"></i> Documentation</a>
                                </li>
                                <% } %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- NavBar -->

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
                                    <div class="alert alert-danger" role="alert">
                                        Username e password errati! Riprovare
                                    </div>
                                <% }
                                request.getSession().removeAttribute("Login");
                            } %>
                        <form action="j_security_check" method="POST" class="was-validated">
                            <div class="form-group">
                                <label for="uname">Username:</label>
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

                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <button type="submit"  class="btn btn-primary">Accedi</button>
                                <button type="button" class="btn btn-secondary" href="#">Reimposta Password</button>
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
                        <form action="j_security_check" method="POST" class="was-validated">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="name">Nome</label>
                                        <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="name" placeholder="Inserisci nome" name="j_username" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="birth">Data di Nascita</label><br>
                                        <input type="date" class="form-control" id="birth" name="j_birth" min="1900-01-01" max="2020-12-31" pattern="\d{2}/\d{2}/\d{4}" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Cellulare</label>
                                        <input type="tel" class="form-control" id="phone" placeholder="Inserisci numero cellulare" name="j_phone" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="tel">Telefono</label>
                                        <input type="tel" class="form-control" id="tel" placeholder="Inserisci numero cellulare" name="j_tele" pattern="[0-9]{3}-[0-9]{2}-[0-9]{3}" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="surname">Cognome</label>
                                        <input  type="text" class="form-control" id="surname" placeholder="Inserisci cognome" name="j_surname" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Indirizzo e-mail</label>
                                        <input type="email" class="form-control" id="email" placeholder="Inserisci indirizzo e-mail" name="j_email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="pwd1">Password</label>
                                        <input  class="form-control" id="pwd1" name="j_password" oninput="validatePasswordConf()" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" placeholder="Inserisci password" required type="password">
                                        <span toggle="#pwd1" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="form-group">
                                        <label for="pwd2">Ripeti password</label>
                                        <input  class="form-control" id="pwd2" name="j_passwordrep" oninput="validatePasswordConf()" placeholder="Ripeti password" required type="password">
                                        <span toggle="#pwd2" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Register Modal footer -->
                            <div class="modal-footer">
                                <button type="submit"  class="btn btn-primary">Registrati</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Register Modal -->


    </body>
    <script>
        $(".toggle-password").click(function() {

            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $($(this).attr("toggle"));
            if (input.attr("type") == "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
    </script>
</html>
