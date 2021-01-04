<%--
  Created by IntelliJ IDEA.
  User: Cuchi
  Date: 04/01/2021
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .rating li,.side-nav .social li{display:inline-block}
        .rating {
            padding: 0;
            list-style-type: none;
        }
        .overlay .mask {
            /* opacity: 0; */
            -webkit-transition: all .4s ease-in-out;
            transition: all .4s ease-in-out;
        }
        .view .mask {
            position: absolute;
            top: 0;
            right: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .zoom:hover img, .zoom:hover video {
            -webkit-transform: scale(1.1);
            transform: scale(1.1);
        }
        .view img, .view video {
            position: relative;
            display: block;
        }
        .btn-group .btn.active{
            background-color: #518cc8 !important;
        }
    </style>
    <script src="/Zanzibar/js/productList.js"></script>
</head>
<body>
    <!-- Product List Modal -->
    <div class="modal fade" id="productsModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Product List Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Prodotti</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Product List Modal body -->
                <div class="modal-body">
                    <%/*
                    <div class="row pb-4 text-center" id="categoryBtn">
                        <div class="col-md-3">
                            <label for="allGroup" class="d-block">Tutto:</label>
                            <div id="allGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="All">Tutto</button>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="starterGroup" class="d-block">Antipasti:</label>
                            <div id="starterGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Antipasti Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Antipasti Di Terra">Terra</button>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="firstGroup" class="d-block">Primi:</label>
                            <div id="firstGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Primi Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Primi Di Terra">Terra</button>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label for="secondGroup" class="d-block">Secondi:</label>
                            <div id="secondGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Secondi Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Secondi Di Terra">Terra</button>
                            </div>
                        </div>
                    </div>
                    */%>

                    <div class="btn-toolbar pb-4 text-center justify-content-center" id="categoryBtn">
                        <div class="mr-4">
                            <label for="allGroup" class="d-block">Tutto:</label>
                            <div id="allGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="All">Tutto</button>
                            </div>
                        </div>
                        <div class="mr-4">
                            <label for="starterGroup" class="d-block">Antipasti:</label>
                            <div id="starterGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Antipasti Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Antipasti Di Terra">Terra</button>
                            </div>
                        </div>
                        <div class="mr-4">
                            <label for="firstGroup" class="d-block">Primi:</label>
                            <div id="firstGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Primi Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Primi Di Terra">Terra</button>
                            </div>
                        </div>
                        <div class="mr-4">
                            <label for="secondGroup" class="d-block">Secondi:</label>
                            <div id="secondGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Secondi Di Mare">Mare</button>
                                <button type="button" class="btn btn-primary" value="Secondi Di Terra">Terra</button>
                            </div>
                        </div>
                    </div>

                    <!--Section: Block Content-->
                    <section>

                        <!-- Grid row -->
                        <div class="row" id="productRowList">
                            <% /*
                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                                 src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->

                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                                 src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->

                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                                 src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->

                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                                 src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->

                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                                 src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->

                            <!-- Item -->
                            <div class="col-md-4 mb-4">
                                <!-- Card -->
                                <div class="">
                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <a href="./prova">
                                            <img class="img-fluid w-100"
                                             src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        </a>
                                    </div>
                                    <div class="text-center pt-4">
                                        <h5>Nome prodotto</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Categoria</p>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-grey">$36.99</span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                    </div>
                                </div>
                                <!-- Card -->
                            </div>
                            <!-- Item -->
                            */%>
                        </div>
                        <!-- Grid row -->

                    </section>
                    <!--Section: Block Content-->
                </div>


            </div>
        </div>
    </div>
    <!-- /Product List Modal -->
</body>
</html>
