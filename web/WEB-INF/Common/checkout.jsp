<%--
  Created by IntelliJ IDEA.
  User: Cuchi
  Date: 17/12/2020
  Time: 12:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iraci.model.User" %>
<html>
<head>
    <script src="/Zanzibar/js/Common/checkout.js"></script>
    <style>
        .lh-condensed { line-height: 1.25; }
    </style>
</head>
<body>
    <!-- CheckOut Modal -->
    <div class="modal fade" id="checkoutModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- CheckOut Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Check-Out</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- CheckOut Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 order-md-2 mb-4">
                            <h4 class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted">Prodotti selezionati</span>
                                <span class="badge badge-secondary badge-pill">3</span>
                            </h4>
                            <ul class="list-group mb-3 sticky-top" id="selectedProducts">
                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div class="mr-3">
                                        <h6 class="my-0">Postazione ombrellone con due sdraio</h6>
                                        <small class="text-muted">Fila 1 Posto 1</small>
                                    </div>
                                    <span class="text-muted">$12</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div class="mr-3">
                                        <h6 class="my-0">Postazione ombrellone con due sdraio</h6>
                                        <small class="text-muted">Fila 1 Posto 2</small>
                                    </div>
                                    <span class="text-muted">$12</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div class="mr-3">
                                        <h6 class="my-0">Sedie sdraio extra</h6>
                                        <small class="text-muted">N°1</small>
                                    </div>
                                    <span class="text-muted">$4</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between" id="totalPrice">
                                    <span>Totale </span>
                                    <strong>€</strong>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-8 order-md-1">
                            <h4 class="mb-3">Indirizzo di fatturazione</h4>
                            <form class="needs-validation" novalidate="">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="firstName">Nome</label>
                                        <input type="text" class="form-control" id="firstName" placeholder="" value="" required="">
                                        <div class="invalid-feedback"> Valid first name is required. </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="lastName">cognome</label>
                                        <input type="text" class="form-control" id="lastName" placeholder="" value="" required="">
                                        <div class="invalid-feedback"> Valid last name is required. </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="email">Email <span class="text-muted">(Optional)</span></label>
                                    <input type="email" class="form-control" id="email" placeholder="you@example.com">
                                    <div class="invalid-feedback"> Please enter a valid email address for shipping updates. </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address">Indirizzo</label>
                                    <input type="text" class="form-control" id="address" placeholder="1234 Main St" required="">
                                    <div class="invalid-feedback"> Please enter your shipping address. </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address2">Indirizzo 2 <span class="text-muted">(Optional)</span></label>
                                    <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
                                </div>
                                <div class="row">
                                    <div class="col-md-5 mb-3">
                                        <label for="country">Regione</label>
                                        <select class="custom-select d-block w-100" id="country" required="">
                                            <option value="">Choose...</option>
                                            <option>Sicilia</option>
                                        </select>
                                        <div class="invalid-feedback"> Please select a valid country. </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="state">Città</label>
                                        <select class="custom-select d-block w-100" id="state" required="">
                                            <option value="">Choose...</option>
                                            <option>California</option>
                                        </select>
                                        <div class="invalid-feedback"> Please provide a valid state. </div>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="zip">CAP</label>
                                        <input type="text" class="form-control" id="zip" placeholder="" required="">
                                        <div class="invalid-feedback"> Zip code required. </div>
                                    </div>
                                </div>
                                <hr class="mb-4">
                                <h4 class="mb-3">Metodo di Pagamento</h4>
                                <div class="d-block my-3">
                                    <div class="custom-control custom-radio">
                                        <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked="" required="">
                                        <label class="custom-control-label" for="credit">Carta di Credito</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required="">
                                        <label class="custom-control-label" for="paypal">PayPal</label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="cc-name">Intestatario Carta</label>
                                        <input type="text" class="form-control" id="cc-name" placeholder="" required="">
                                        <small class="text-muted">Full name as displayed on card</small>
                                        <div class="invalid-feedback"> Name on card is required </div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="cc-number">Numero Carta</label>
                                        <input type="text" class="form-control" id="cc-number" placeholder="" required="">
                                        <div class="invalid-feedback"> Credit card number is required </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <label for="cc-expiration">Scadenza</label>
                                        <input type="text" class="form-control" id="cc-expiration" placeholder="" required="">
                                        <div class="invalid-feedback"> Expiration date required </div>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <label for="cc-cvv">CVV</label>
                                        <input type="text" class="form-control" id="cc-cvv" placeholder="" required="">
                                        <div class="invalid-feedback"> Security code required </div>
                                    </div>
                                </div>
                                <hr class="mb-4">
                                <button class="btn btn-primary btn-lg btn-block" type="submit">Procedi al pagamento</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
