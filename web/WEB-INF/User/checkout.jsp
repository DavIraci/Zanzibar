<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iraci.model.User" %>
<html>
<head>
    <script src="./js/User/checkout.js"></script>
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
                                <span class="badge badge-secondary badge-pill" id="element-number"></span>
                            </h4>
                            <ul class="list-group mb-3 sticky-top" id="selectedProducts">
                            </ul>
                        </div>
                        <div class="col-md-8 order-md-1">
                            <h4 class="mb-3">Indirizzo di fatturazione</h4>
                            <form class="was-validated" novalidate="" id="COform">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="nameCO">Nome</label>
                                        <input type="text" class="form-control text-capitalize" id="nameCO" value="<%= ((User) request.getSession().getAttribute("USER")).getNome()%>" name="username" required onchange="checkValidation()">
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="surnameCO">Cognome</label>
                                        <input  type="text" class="form-control text-capitalize" id="surnameCO" value="<%= ((User) request.getSession().getAttribute("USER")).getCognome()%>" name="surname" required onchange="checkValidation()">
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="emailCO">Indirizzo e-mail</label>
                                    <input type="email" class="form-control" id="emailCO" value="<%= ((User) request.getSession().getAttribute("USER")).getEmail()%>" name="email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required onchange="checkValidation()">
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback">Per favore riempi questo campo</div>
                                </div>
                                <div class="mb-3">
                                    <label for="fiscalcodeCO">Codice Fiscale</label>
                                    <input type="text" class="form-control text-uppercase" id="fiscalcodeCO" name="fiscalcodeCO" required onchange="checkValidation()" pattern="[a-zA-Z]{6}[0-9]{2}[a-zA-Z][0-9]{2}[a-zA-Z][0-9]{3}[a-zA-Z]$">
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                </div>
                                <div class="mb-3">
                                    <label for="addressCO">Indirizzo</label>
                                    <input type="text" class="form-control" id="addressCO" placeholder="Via/Piazza" required onchange="checkValidation()">
                                    <div class="valid-feedback">Valido</div>
                                    <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address2CO">Indirizzo 2 <span class="text-muted">(Optional)</span></label>
                                    <input type="text" class="form-control" id="address2CO">
                                </div>
                                <div class="row">
                                    <div class="col-md-8 mb-3">
                                        <label for="regionCO">Regione</label>
                                        <input type="text" class="form-control text-capitalize" name="regionCO" id="regionCO" placeholder="" required onchange="checkValidation()">
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="provinceCO">Provincia</label>
                                        <input type="text" class="form-control text-uppercase" name="provinceCO" id="provinceCO" placeholder="" required onchange="checkValidation()" pattern="(^[a-zA-Z]{2}$)|(roma|Roma|ROMA)$">
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8 mb-3">
                                        <label for="cityCO">Città</label>
                                        <input type="text" class="form-control text-capitalize" name="cityCO" id="cityCO" placeholder="" required onchange="checkValidation()">
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label for="capCO">CAP</label>
                                        <input type="text" class="form-control" name="capCO" id="capCO" placeholder="" required onchange="checkValidation()" pattern="^[0-9]{5}$">
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                </div>
                                <hr class="mb-4">
                                <h4 class="mb-3">Metodo di Pagamento</h4>
                                <div class="d-block my-3">
                                    <div class="custom-control custom-radio">
                                        <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked="" required onchange="checkValidation()" onclick="updatePaymentMethod()" >
                                        <label class="custom-control-label" for="credit">Carta di Credito</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required onchange="checkValidation()" onclick="updatePaymentMethod()">
                                        <label class="custom-control-label" for="paypal">PayPal</label>
                                    </div>
                                </div>
                                <div id="credit-card-method">
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="cc-number">Numero Carta</label>
                                            <input type="text" class="form-control" id="cc-number" placeholder="" required onchange="checkValidation()" pattern="^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$">
                                            <div class="invalid-feedback"> Il numero della carta di credito è necessario! "xxxx-xxxx-xxxx-xxxx"</div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="cc-expiration">Scadenza</label>
                                            <input type="text" class="form-control" id="cc-expiration" placeholder="xx/xx" required onchange="checkValidation()" pattern="[0-9]{2}(-|\/){1}[0-9]{2}$">
                                            <div class="invalid-feedback"> La scadenza della carta di credito è necessaria! </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="cc-name">Intestatario Carta</label>
                                            <input type="text" class="form-control" id="cc-name" placeholder="Nome Cognome" required onchange="checkValidation()" pattern="^[a-zA-Z]+ [a-zA-Z]+$">
                                            <small class="text-muted">Nome e cognome presenti sulla carta</small>
                                            <div class="invalid-feedback"> L'intestatario della carta di credito è necessario! </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="cc-cvv">CVV</label>
                                            <input type="text" class="form-control" id="cc-cvv" placeholder="" required onchange="checkValidation()" pattern="^[0-9]{3,4}$">
                                            <div class="invalid-feedback"> Il CVV della carta di credito è necessario! </div>
                                        </div>
                                    </div>
                                </div>
                                <hr class="mb-4">
                                <button id="payBtn" class="btn btn-primary btn-lg btn-block" type="submit">Procedi al pagamento</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
