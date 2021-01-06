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
        @media (min-width: 576px){
            .modal-dialog.modal-lg {
                max-width: 80%;
            }
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
                                <button type="button" class="btn btn-primary" value="Insalatone">Insalatone</button>
                                <button type="button" class="btn btn-primary" value="Panini">Panini</button>
                                <button type="button" class="btn btn-primary" value="Rustici">Rosticceria</button>
                            </div>
                        </div>
                        <div class="mr-4">
                            <label for="drinkGroup" class="d-block">Bibite:</label>
                            <div id="drinkGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Analcolici">Analcolici</button>
                                <button type="button" class="btn btn-primary" value="Cocktails">Cocktails</button>
                                <button type="button" class="btn btn-primary" value="Birre">Birre</button>
                                <button type="button" class="btn btn-primary" value="Distillati">Distillati</button>
                                <button type="button" class="btn btn-primary" value="Vini Bianchi">Vini Bianchi</button>
                                <button type="button" class="btn btn-primary" value="Vini Rossi">Vini Rossi</button>
                                <button type="button" class="btn btn-primary" value="Caffetteria">Caffetteria</button>
                            </div>
                        </div>
                        <div class="mr-4">
                            <label for="dessertGroup" class="d-block">Dessert:</label>
                            <div id="dessertGroup" class="btn-group">
                                <button type="button" class="btn btn-primary" value="Colazione">Colazione</button>
                                <button type="button" class="btn btn-primary" value="Dessert">Dolci</button>
                                <button type="button" class="btn btn-primary" value="Frutta e Dessert">Frutta</button>
                            </div>
                        </div>
                    </div>
                    <div class="btn-toolbar pt-4 pb-4 text-center justify-content-center" id="pageDivGroup">
                        <div class="mr-4">
                            <div id="pageNGroup" class="btn-group">
                            </div>
                        </div>
                    </div>



                    <!--Section: Block Content-->
                    <section>

                        <!-- Grid row -->
                        <div class="row" id="productRowList">
                        </div>
                        <!-- Grid row -->

                    </section>
                    <!--Section: Block Content-->
                </div>


            </div>
        </div>
    </div>
    <!-- /Product List Modal -->

    <!-- Add to cart Modal -->
    <div class="modal fade" id="addToCartModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h5 class="modal-title" id="addToCartName">Nome Prodotto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="collapseDetail">Descrizione</label>
                    <div class="collapse show" id="collapseDetail">
                        <div class="card card-body text-capitalize" id="addToCartDescription">
                        </div>
                    </div>
                    <div class="row mt-4 justify-content-center">
                        <div class="col-sm-3 col-sm-offset-3 align-self-center">
                            <div class="input-group mb-3">
                                <label for="productQtyForm">Quantità:</label><br>
                                <div id='productQtyForm'>
                                    <input id="productQtyMinus" type='button' value='-' class='qtyminus btn btn-danger' field='quantity' style="border-radius: 0.5rem"/>
                                    <input id="productQty" type='text' name='quantity' value='1' class='qty text-center' style="max-width: 25%" readonly/>
                                    <input id="productQtyPlus" type='button' value='+' class='qtyplus btn btn-success' field='quantity' style="border-radius: 0.5rem"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-7 ml-auto">
                            <textarea name="productNote" id="productNote" cols="30" rows="3" class="form-control" placeholder="Lascia una nota sull'ordine... "></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Chiudi</button>
                    <button type="button" class="btn btn-primary" id="addToCartBtn" >Aggiungi al carrello</button>
                </div>
            </div>
        </div>
    </div>
    <!-- /Details Modal -->

    <!-- Added to Cart Modal -->
    <div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" id="addedToCartModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm" role="document">
            <div class="modal-content" style="border: #518CC8 5px solid;">
                <div class="modal-header">
                    <h4 class="modal-title" id="mySmallModalLabel">Conferma</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body" id="addedToCartMessage">
                </div>
            </div>
        </div>
    </div>
    <!-- /Added to Cart Modal -->

</body>
</html>
