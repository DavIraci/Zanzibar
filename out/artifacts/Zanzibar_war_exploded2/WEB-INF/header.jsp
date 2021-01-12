<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
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
            } else  if (request.getUserPrincipal() == null){ %>
                <%@ include file="/WEB-INF/login-signin.jsp"%>
        <%  }
            if ( (request.getUserPrincipal() != null) ){ %>
                <%@ include file="/WEB-INF/User/productList.jsp"%>
        <%  } %>

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
                                        <a href="${pageContext.request.contextPath}/common/manageprofile"><i class="fas fa-user-cog"></i> Dati profilo</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/user/book"><i class="fas fa-calendar-plus"></i> Prenota</a>
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
                                        <a href="${pageContext.request.contextPath}/common/manageprofile"><i class="fas fa-user-cog"></i> Dati profilo</a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/user/book"><i class="fas fa-calendar-plus"></i> Prenota</a>
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
                                <% } %>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- NavBar -->
    </body>
</html>
