<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
  Date: 16/10/2020
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.iraci.model.User" %>
<%@ page import="com.iraci.model.Cart" %>
<%@ page import="com.iraci.DataBase.DataBase" %>
<%@ page import="java.sql.SQLException" %>
<html>
    <head>
        <script src="/Zanzibar/js/header.js"></script>
        <style>
            .badge.badge-pill{
                background-color: #5fbfcd;
                color: white;
            }
            .dropdown-menu.extended li a:hover span{
                background-color: black !important;
            }
        </style>
        <%@ include file="/WEB-INF/productList.jsp"%>
    </head>
    <body>
        <% if(request.getUserPrincipal() != null && request.getSession().getAttribute("USER") == null){
                try {
                    User user = DataBase.takeUser(request.getUserPrincipal().getName());
                    if (user == null) {
                        response.sendError(400);
                    }
                    request.getSession().setAttribute("USER", user);
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }
            } %>
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
                        <% if(request.getRequestURI().equals("/Zanzibar/WEB-INF/index.jsp")){ %>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#service">SERVIZI</a>
                            </li>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#beach">SPIAGGIA</a>
                            </li>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="#about">CHI SIAMO</a>
                            </li>
                        <% } else{ %>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="${pageContext.request.contextPath}#service">SERVIZI</a>
                            </li>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="${pageContext.request.contextPath}#beach">SPIAGGIA</a>
                            </li>
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="${pageContext.request.contextPath}#about">CHI SIAMO</a>
                            </li>
                        <% } %>
                        <li class="nav-item mx-0 mx-lg-1 dropdown">
                            <a class="nav-link py-3 px-0 px-lg-3 rounded dropdown-toggle" data-toggle="dropdown" href="#">
                                    <span class="profile-ava">
                                        <i class="fas fa-user-circle"></i>
                                    </span>
                            </a>
                            <ul class="dropdown-menu extended" style="left: auto;right: 0" id="dropDownMenu">
                                <% if(request.getSession().getAttribute("USER") == null){ %>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt" ></i> Accedi</a>
                                        </li>
                                         <li>
                                             <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fas fa-pencil-alt" ></i> Registrati</a>
                                        </li>
                                <% } else if(((User) request.getSession().getAttribute("USER")).getRuolo().equals("Admin")){ %>
                                        <li class="eborder-top">
                                            <a ><i class="fas fa-user-alt"> <%= ((User) request.getSession().getAttribute("USER")).getRuolo() %></i> <%= ((User) request.getSession().getAttribute("USER")).getCognome() %></a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/manageprofile"><i class="fas fa-user-cog"></i> Dati profilo</a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/common/book"><i class="fas fa-calendar-plus"></i> Prenota</a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/user/managebook"><i class="fas fa-calendar-alt"></i> Gestisci prenotazioni</a>
                                        </li>
                                        <li>
                                            <a href="#" data-toggle="modal" data-target="#productsModal" onclick="$('#allGroup button').click();"><i class="fas fa-utensils" ></i> Prodotti</a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/user/cartManage"><span class="badge badge-pill" id="spanCart"><%if(((Cart) request.getSession().getAttribute("CART"))!=null && ((Cart) request.getSession().getAttribute("CART")).getSize()>0 ){%><%=((Cart) request.getSession().getAttribute("CART")).getSize() %><%}%></span><i class="fas fa-shopping-cart"></i> Carello
                                            </a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a>
                                        </li>
                                <% } else if(((User) request.getSession().getAttribute("USER")).getRuolo().equals("User") ){ %>
                                        <li class="eborder-top">
                                            <a ><i class="fas fa-user-alt"> <%= ((User) request.getSession().getAttribute("USER")).getRuolo() %></i> <%= ((User) request.getSession().getAttribute("USER")).getCognome() %></a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/manageprofile"><i class="fas fa-user-cog"></i> Dati profilo</a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/common/book"><i class="fas fa-calendar-day"></i> Prenota</a>
                                        </li>
                                        <li>
                                            <a href="#"><i class="icon_chat_alt"></i> Chats</a>
                                        </li>
                                        <li>
                                            <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Log Out</a>
                                        </li>
                                <% } %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- NavBar -->

        <% if(request.getSession().getAttribute("USER") == null){ %>
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
                            <% if(request.getSession().getAttribute("SignInError")!=null ){ %>
                                    <script> $('#registerModal').modal('show') </script>
                                    <div class="alert alert-danger alert-dismissible" role="alert">
                                        <button type="button" class="close" data-dismiss="alert">&times;</button>
                                       <%= request.getSession().getAttribute("SignInError") %>
                                    </div>
                            <%      request.getSession().removeAttribute("SignInError");
                                }
                                if(request.getSession().getAttribute("SignIn")!=null ){ %>
                                    <script> $('#registerModal').modal('show') </script>
                            <%      if(! request.getSession().getAttribute("SignIn").equals("")){ %>
                                        <div class="alert alert-success alert-dismissible" role="alert">
                                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <%=             request.getSession().getAttribute("SignIn") %>
                                        </div>
                            <%      }
                                    request.getSession().removeAttribute("SignIn");
                                } %>



                            <form action="${pageContext.request.contextPath}/signin" method="POST" class="was-validated">
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
                                    <button type="submit"  class="btn btn-primary">Registrati</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <% if(session.getAttribute("name")!=null){ %>
                    <script>$("#name").val("<%= session.getAttribute("name").toString()%>")</script>
            <% 	    session.removeAttribute("name");
                } %>

            <% if(session.getAttribute("surname")!=null){ %>
                    <script>$("#surname").val("<%= session.getAttribute("surname").toString()%>")</script>
            <% 	    session.removeAttribute("surname");
                } %>

            <% if(session.getAttribute("email")!=null){ %>
                    <script>$("#email").val("<%= session.getAttribute("email").toString()%>")</script>
            <% 	    session.removeAttribute("email");
                } %>

            <% if(session.getAttribute("mobile")!=null){ %>
                    <script>$("#mobile").val("<%= session.getAttribute("mobile").toString()%>")</script>
            <% 	    session.removeAttribute("phone");
                } %>

            <% if(session.getAttribute("birth")!=null){ %>
                    <script>$("#birth").val("<%= session.getAttribute("birth").toString()%>")</script>
            <% 	    session.removeAttribute("birth");
                } %>

            <% if(session.getAttribute("telephone")!=null){ %>
                    <script>$("#telephone").val("<%= session.getAttribute("telephone").toString()%>")</script>
            <% 	    session.removeAttribute("tel");
                } %>
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
                            <% if(request.getSession().getAttribute("ResetPwd")!=null ){ %>
                                    <script> $('#resetPasswordModal').modal('show') </script>
                            <%      if(request.getSession().getAttribute("ResetPwd").equals("ERROR")){ %>
                                        <div class="alert alert-danger alert-dismissible" role="alert">
                                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                                            Nessun account associato a questo indirizzo email!
                                        </div>
                            <%      }else if(request.getSession().getAttribute("ResetPwd").equals("SUCCESS")){ %>
                                        <div class="alert alert-success alert-dismissible" role="alert">
                                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                                            E' stata inviata una mail contenete le indicazioni su come procedere!
                                        </div>
                            <%      }
                                    request.getSession().removeAttribute("ResetPwd");
                            } %>
                            <form action="${pageContext.request.contextPath}/resetpwd" method="POST" class="was-validated">
                                <div class="form-group">
                                    <label for="resetmail">Indirizzo email associato:</label>
                                    <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="resetmail" placeholder="Inserisci username" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>

                                <!-- ResetPassword Modal footer -->
                                <div class="modal-footer">
                                    <button type="submit"  class="btn btn-primary">Reimposta Password</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ResetPassword Modal -->
        <% } %>

    </body>
</html>
