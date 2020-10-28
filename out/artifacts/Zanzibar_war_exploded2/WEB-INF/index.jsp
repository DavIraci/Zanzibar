<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
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
        <script src="/Zanzibar/js/scripts.js" crossorigin="anonymous"></script>

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
        <main role="main" style="padding-top: calc(74px);padding-bottom: 6rem;">

            <!-- Carousel -->
            <div id="myCarousel" class="carousel container slide" data-ride="carousel" data-interval="3000">
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


        </main>
        <%@ include file="/WEB-INF/footer.jsp"%>

        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top position-fixed"><a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up" style="line-height: 3.1rem;"></i></a></div>
    </body>
</html>


