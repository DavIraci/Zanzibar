<%--
  Created by IntelliJ IDEA.
  User: Cuchi
  Date: 11/10/2020
  Time: 22:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iraci.model.User" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Zanzibar Lido - Summer 2020</title>
        <link rel="shortcut icon" href="image/favicon.ico" />

        <!-- CSS, includes Bootstrap (off-line)-->
        <link href="css/styles.css" rel="stylesheet">
        <link href="css/heading.css" rel="stylesheet">
        <link href="css/body.css" rel="stylesheet">
        <link href="css/carousel.css" rel="stylesheet">

        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

        <style>
            @media (max-width: 992px){
                .carousel.container{
                    padding:0;
                    max-width:none;
                }
            }
        </style>


        <!-- NavBar -->
        <nav class="navbar navbar-expand-lg bg-secondary fixed-top" id="mainNav">
            <div class="container"><a class="navbar-brand js-scroll-trigger" href="#page-top">ZanziBar</a>
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
                            <ul class="dropdown-menu extended" style="float: right; left: auto;right: 0" id="dropDownMenu">
                                <li class="eborder-top">
                                    <a href="#"><i class="icon_profile"></i> My Profile</a>
                                </li>
                                <li>
                                    <a href="#" data-toggle="modal" data-target="#loginModal"><i class="icon_mail_alt" ></i> Accedi</a>
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
                                <li>
                                    <a href="documentation.html"><i class="icon_key_alt"></i> Documentation</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- NavBar -->

        <!-- Login Model -->
        <!-- The Modal -->
        <div class="modal fade" id="loginModal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Login</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/login" method="post" class="was-validated">
                            <div class="form-group">
                                <label for="uname">Username:</label>
                                <input type="text" class="form-control" id="uname" placeholder="Enter username" name="user" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>

                            <div class="form-group">
                                <label for="pwd">Password:</label>
                                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required>
                                <div class="valid-feedback">Valid.</div>
                                <div class="invalid-feedback">Please fill out this field.</div>
                            </div>

                            <button type="submit" class="btn btn-primary">Accedi</button>
                        </form>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
        <!-- Login Model -->
    </head>

    <body id="page-top">
        <main role="main">

            <!-- Carousel -->
            <div id="myCarousel" class="carousel container slide" data-ride="carousel" data-interval="2000">
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1" class=""></li>
                    <li data-target="#myCarousel" data-slide-to="2" class=""></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item">
                        <img class="first-slide" src="image/carousel1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="second-slide" src="image/carousel2.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item active">
                        <img class="third-slide" src="image/carousel3.jpg" alt="Third slide">
                    </div>
                </div>
                <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
            <!-- Carousel -->



            <div class="container marketing">

                <% if(request.getAttribute("ErrorMessage")!= null){
                        pageContext.getOut().print(request.getAttribute("ErrorMessage"));
                    }
                    if(request.getSession().getAttribute("USER") != null) {
                        pageContext.getOut().print("Ciao");
                        pageContext.getOut().print( ((User) request.getSession().getAttribute("USER")).getEmail());
                    }
                    pageContext.getOut().print("Ciao2");
                %>

                <!-- Services -->
                <section class="page-section portfolio" id="service">
                    <div class="row" style="text-align: center">
                        <div class="col-lg-6">
                            <img class="rounded-circle" src="image/umbrella-chairs.png" alt="Generic placeholder image" style="background-color: lightblue; width: 160px; height: 160px;">
                            <h2>Ombrellone e Sdraio</h2>
                            <p>Goditi il tuo momento di relax sdraiato all'ombra a due passi dalla riva.</p>
                        </div><!-- /.col-lg-4 -->
                        <div class="col-lg-6">
                            <img class="rounded-circle" src="image/food.png" alt="Generic placeholder image" style="background-color: lightblue; width: 160px; height: 160px;">
                            <h2>Food and Drinks</h2>
                            <p>Vieni a gustare i piatti unici e sorseggiare i meravigliosi cocktail preparati dalla nostra cucina!</p>
                        </div><!-- /.col-lg-4 -->
                    </div>
                </section>
                <!-- Services -->

                <!-- Services -->
                <section class="page-section portfolio" id="beach">
                    <div class="row" style="text-align: center">
                        <div class="col-lg-6">
                            <img class="rounded-circle" src="image/umbrella-chairs.png" alt="Generic placeholder image" style="background-color: lightblue; width: 160px; height: 160px;">
                            <h2>Ombrellone e Sdraio</h2>
                            <p>Goditi il tuo momento di relax sdraiato all'ombra a due passi dalla riva.</p>
                        </div><!-- /.col-lg-4 -->
                        <div class="col-lg-6">
                            <img class="rounded-circle" src="image/food.png" alt="Generic placeholder image" style="background-color: lightblue; width: 160px; height: 160px;">
                            <h2>Food and Drinks</h2>
                            <p>Vieni a gustare i piatti unici e sorseggiare i meravigliosi cocktail preparati dalla nostra cucina!</p>
                        </div><!-- /.col-lg-4 -->
                    </div>
                </section>
                <!-- Services -->

                <!-- About -->
                <section id="about">
                    Chi siamo
                </section>
                <!-- About -->

            </div>

            <!-- Footer -->
            <section id="footer" class="container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d12571.963706615064!2d12.896919!3d38.023991!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x669faf3378dc2d86!2sLido%20Zanzibar!5e0!3m2!1sit!2sit!4v1602677255244!5m2!1sit!2sit" width="100%" height="40%" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
            </section>
            <!-- Footer -->
        </main>

        <!-- Copyright Section-->
        <section class="copyright py-4 text-center text-white">
            <div class="container"><small class="pre-wrap">Copyright © Your Website 2020</small></div>
        </section>
        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
        <!-- Script -->
        <script src="js/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>
        <script src="js/scripts.js" crossorigin="anonymous"></script>
    </body>
</html>


