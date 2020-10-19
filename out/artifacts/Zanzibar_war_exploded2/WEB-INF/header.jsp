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
                        <% if( request.getSession().getAttribute("Login") != null && request.getSession().getAttribute("Login").equals("ERROR")){ %>
                                <div class="alert alert-danger" role="alert">
                                    Username e password errati! Riprovare
                                </div>
                        <% } %>
                        <form action="j_security_check" method="POST" class="was-validated">
                            <div class="form-group">
                                <label for="uname">Username:</label>
                                <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="uname" placeholder="Enter username" name="j_username" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                <div class="valid-feedback">Valido</div>
                                <div class="invalid-feedback">Per favore riempi questo campo</div>
                            </div>

                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input  type="password" class="form-control" id="pwd" placeholder="Enter password" name="j_password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
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
                                        <label for="uname">Username:</label>
                                        <input title="Scrivi un indirizzo mail valido!" type="text" class="form-control" id="uname" placeholder="Enter username" name="j_username" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>

                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label for="pwd">Password:</label>
                                        <input  type="password" class="form-control" id="pwd" placeholder="Enter password" name="j_password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal footer -->
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
</html>
