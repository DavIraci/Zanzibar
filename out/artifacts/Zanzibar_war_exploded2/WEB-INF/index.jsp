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

        <script src="js/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
        <script src="js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src='http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js'></script>

        <style>
            @media (max-width: 992px){
                .carousel.container{
                    padding:0;
                    max-width:none;
                }
            }
        </style>

        <%@ include file="/WEB-INF/header.jsp"%>
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

                <% if(request.getSession().getAttribute("Login")!=null && request.getSession().getAttribute("Login").equals("TRUE")){ %>
                        <script> $('#loginModal').modal('show') </script>
                <%      request.getSession().removeAttribute("Login");
                    }
                    if(request.getAttribute("ErrorMessage")!= null){
                        pageContext.getOut().print(request.getAttribute("ErrorMessage"));
                    }
                    if(request.getSession().getAttribute("USER") != null) {
                        pageContext.getOut().print("Benvenuto: ");
                        pageContext.getOut().print( ((User) request.getSession().getAttribute("USER")).getEmail());
                    }
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

            <%@ include file="/WEB-INF/footer.jsp"%>
        </main>


        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
        <!-- Script -->
        <script src="js/scripts.js" crossorigin="anonymous"></script>
    </body>
</html>


