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
    </style>
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
                    <!--Section: Block Content-->
                    <section>

                        <!-- Grid row -->
                        <div class="row">

                            <!-- Grid column -->
                            <div class="col-md-4 mb-4">

                                <!-- Card -->
                                <div class="">

                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <img class="img-fluid w-100"
                                             src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/12a.jpg" alt="Sample">
                                        <a href="#!">
                                            <div class="mask">
                                                <img class="img-fluid w-100"
                                                     src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/12.jpg">
                                                <div class="mask rgba-black-slight"></div>
                                            </div>
                                        </a>
                                    </div>

                                    <div class="text-center pt-4">

                                        <h5>Fantasy T-shirt</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Shirts</p>
                                        <ul class="rating">
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                        </ul>
                                        <hr>
                                        <h6 class="mb-3">12.99 $</h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                        <button type="button" class="btn btn-danger btn-sm px-3 mb-2 material-tooltip-main"
                                                data-toggle="tooltip" data-placement="top" title="Add to wishlist"><i
                                                class="far fa-heart"></i></button>

                                    </div>

                                </div>
                                <!-- Card -->

                            </div>
                            <!-- Grid column -->

                            <!-- Grid column -->
                            <div class="col-md-4 mb-4">

                                <!-- Card -->
                                <div class="">

                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <img class="img-fluid w-100"
                                             src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/13a.jpg" alt="Sample">
                                        <h4 class="mb-0"><span class="badge badge-dark badge-pill badge-news">Sold out</span></h4>
                                        <a href="#!">
                                            <div class="mask">
                                                <img class="img-fluid w-100"
                                                     src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/13.jpg">
                                                <div class="mask rgba-black-slight"></div>
                                            </div>
                                        </a>
                                    </div>

                                    <div class="text-center pt-4">

                                        <h5>Fantasy T-shirt</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Shirts</p>
                                        <ul class="rating">
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="far fa-star fa-sm text-primary"></i>
                                            </li>
                                        </ul>
                                        <hr>
                                        <h6 class="mb-3">12.99 $</h6>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                        <button type="button" class="btn btn-danger btn-sm px-3 mb-2 material-tooltip-main"
                                                data-toggle="tooltip" data-placement="top" title="Add to wishlist"><i
                                                class="far fa-heart"></i></button>

                                    </div>

                                </div>
                                <!-- Card -->

                            </div>
                            <!-- Grid column -->

                            <!-- Grid column -->
                            <div class="col-md-4 mb-4">

                                <!-- Card -->
                                <div class="">

                                    <div class="view zoom overlay z-depth-2 rounded">
                                        <img class="img-fluid w-100"
                                             src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14a.jpg" alt="Sample">
                                        <h4 class="mb-0"><span class="badge badge-primary badge-pill badge-news">Sale</span></h4>
                                        <a href="#!">
                                            <div class="mask">
                                                <img class="img-fluid w-100"
                                                     src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/14.jpg">
                                                <div class="mask rgba-black-slight"></div>
                                            </div>
                                        </a>
                                    </div>

                                    <div class="text-center pt-4">

                                        <h5>Fantasy T-shirt</h5>
                                        <p class="mb-2 text-muted text-uppercase small">Shirts</p>
                                        <ul class="rating">
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                            <li>
                                                <i class="fas fa-star fa-sm text-primary"></i>
                                            </li>
                                        </ul>
                                        <hr>
                                        <h6 class="mb-3">
                                            <span class="text-danger mr-1">$12.99</span>
                                            <span class="text-grey"><s>$36.99</s></span>
                                        </h6>
                                        <button type="button" class="btn btn-primary btn-sm mr-1 mb-2"><i
                                                class="fas fa-shopping-cart pr-2"></i>Add to cart</button>
                                        <button type="button" class="btn btn-light btn-sm mr-1 mb-2"><i
                                                class="fas fa-info-circle pr-2"></i>Details</button>
                                        <button type="button" class="btn btn-danger btn-sm px-3 mb-2 material-tooltip-main"
                                                data-toggle="tooltip" data-placement="top" title="Add to wishlist"><i
                                                class="far fa-heart"></i></button>

                                    </div>

                                </div>
                                <!-- Card -->

                            </div>
                            <!-- Grid column -->

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
