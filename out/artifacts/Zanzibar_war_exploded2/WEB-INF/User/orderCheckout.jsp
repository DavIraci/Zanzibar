<%--
  Created by IntelliJ IDEA.
  User: Davide Iraci
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.iraci.model.User" %>
<html>
<head>
    <style>
        .lh-condensed { line-height: 1.25; }
    </style>
</head>
<body>
    <!-- Order CheckOut Modal -->
    <div class="modal fade" id="orderCheckoutModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Order CheckOut Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Check-Out</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Order CheckOut Modal body -->
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-4 order-md-2 mb-4">
                            <h4 class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted">Prodotti selezionati</span>
                                <span class="badge badge-secondary badge-pill" id="product-number"></span>
                            </h4>
                            <ul class="list-group mb-3 sticky-top" id="cartProducts">
                            </ul>
                        </div>
                        <div class="col-md-8 order-md-1">
                            <form class="was-validated" novalidate="" id="OrderCOform">
                                <h4 class="mb-3">Metodo di Pagamento</h4>
                                <div class="d-block my-3">
                                    <div class="custom-control custom-radio">
                                        <input id="creditOrderCO" name="paymentMethod" type="radio" class="custom-control-input" checked="" required onclick="updateOrderPaymentMethod()" >
                                        <label class="custom-control-label" for="creditOrderCO">Carta di Credito</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input id="paypalOrderCO" name="paymentMethod" type="radio" class="custom-control-input" required onclick="updateOrderPaymentMethod()">
                                        <label class="custom-control-label" for="paypalOrderCO">PayPal</label>
                                    </div>
                                    <div class="custom-control custom-radio">
                                        <input id="cashOrderCO" name="paymentMethod" type="radio" class="custom-control-input" required onclick="updateOrderPaymentMethod()" >
                                        <label class="custom-control-label" for="cashOrderCO">Contanti</label>
                                    </div>
                                </div>
                                <hr class="mb-4">
                                <div id="deliveryOrderCO">
                                    <h4 class="mb-3">Metodo di Consegna</h4>
                                    <div class="d-block my-3">
                                        <div class="custom-control custom-radio">
                                            <input id="onPostationDeliberyOrderCO" name="DeliveryOprion" type="radio" class="custom-control-input" checked="" required onclick="updateOrderPaymentMethod()" >
                                            <label class="custom-control-label" for="onPostationDeliberyOrderCO">Consegna all'ombrellone</label>
                                        </div>
                                        <div class="custom-control custom-radio">
                                            <input id="onSiteDeliberyOrderCO" name="DeliveryOprion" type="radio" class="custom-control-input" required onclick="updateOrderPaymentMethod()" >
                                            <label class="custom-control-label" for="onSiteDeliberyOrderCO">Ritiro al banco</label>
                                        </div>
                                    </div>
                                    <hr class="mb-4">
                                </div>

                                <div id="invoiceDateOrderCO">
                                    <h4 class="mb-3">Indirizzo di fatturazione</h4>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="nameOrderCO">Nome</label>
                                            <input type="text" class="form-control text-capitalize" id="nameOrderCO" value="<%= ((User) request.getSession().getAttribute("USER")).getNome()%>" name="username" required onchange="checkOrderValidation()">
                                            <div class="valid-feedback">Valido</div>
                                            <div class="invalid-feedback">Per favore riempi questo campo</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="surnameOrderCO">Cognome</label>
                                            <input  type="text" class="form-control text-capitalize" id="surnameOrderCO" value="<%= ((User) request.getSession().getAttribute("USER")).getCognome()%>" name="surname" required onchange="checkOrderValidation()">
                                            <div class="valid-feedback">Valido</div>
                                            <div class="invalid-feedback">Per favore riempi questo campo</div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="emailOrderCO">Indirizzo e-mail</label>
                                        <input type="email" class="form-control" id="emailOrderCO" value="<%= ((User) request.getSession().getAttribute("USER")).getEmail()%>" name="email" pattern="^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required onchange="checkOrderValidation()">
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback">Per favore riempi questo campo</div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="fiscalcodeOrderCO">Codice Fiscale</label>
                                        <input type="text" class="form-control text-uppercase" id="fiscalcodeOrderCO" name="fiscalcodeOrderCO" required onchange="checkOrderValidation()" pattern="[a-zA-Z]{6}[0-9]{2}[a-zA-Z][0-9]{2}[a-zA-Z][0-9]{3}[a-zA-Z]$">
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="addressOrderCO">Indirizzo</label>
                                        <input type="text" class="form-control" id="addressOrderCO" placeholder="Via/Piazza" required onchange="checkOrderValidation()">
                                        <div class="valid-feedback">Valido</div>
                                        <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="address2OrderCO">Indirizzo 2 <span class="text-muted">(Optional)</span></label>
                                        <input type="text" class="form-control" id="address2OrderCO">
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="regionOrderCO">Regione</label>
                                            <input type="text" class="form-control text-capitalize" name="regionOrderCO" id="regionOrderCO" placeholder="" required onchange="checkOrderValidation()">
                                            <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="provinceOrderCO">Provincia</label>
                                            <input type="text" class="form-control text-uppercase" name="provinceOrderCO" id="provinceOrderCO" placeholder="" required onchange="checkOrderValidation()" pattern="(^[a-zA-Z]{2}$)|(roma|Roma|ROMA)$">
                                            <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="cityOrderCO">Città</label>
                                            <input type="text" class="form-control text-capitalize" name="cityOrderCO" id="cityOrderCO" placeholder="" required onchange="checkOrderValidation()">
                                            <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="capOrderCO">CAP</label>
                                            <input type="text" class="form-control" name="capOrderCO" id="capOrderCO" placeholder="" required onchange="checkOrderValidation()" pattern="^[0-9]{5}$">
                                            <div class="invalid-feedback"> Per favore riempi questo campo </div>
                                        </div>
                                    </div>
                                    <hr class="mb-4">
                                </div>
                                <div id="credit-card-methodOrderCO">
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="cc-numberOrderCO">Numero Carta</label>
                                            <input type="text" class="form-control" id="cc-numberOrderCO" placeholder="" required onchange="checkOrderValidation()" pattern="^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$">
                                            <div class="invalid-feedback"> Il numero della carta di credito è necessario! "xxxx-xxxx-xxxx-xxxx"</div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="cc-expirationOrderCO">Scadenza</label>
                                            <input type="text" class="form-control" id="cc-expirationOrderCO" placeholder="xx/xx" required onchange="checkOrderValidation()" pattern="[0-9]{2}(-|\/){1}[0-9]{2}$">
                                            <div class="invalid-feedback"> La scadenza della carta di credito è necessaria! </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-8 mb-3">
                                            <label for="cc-nameOrderCO">Intestatario Carta</label>
                                            <input type="text" class="form-control" id="cc-nameOrderCO" placeholder="Nome Cognome" required onchange="checkOrderValidation()" pattern="^[a-zA-Z]+ [a-zA-Z]+$">
                                            <small class="text-muted">Nome e cognome presenti sulla carta</small>
                                            <div class="invalid-feedback"> L'intestatario della carta di credito è necessario! </div>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="cc-cvvOrderCO">CVV</label>
                                            <input type="text" class="form-control" id="cc-cvvOrderCO" placeholder="" required onchange="checkOrderValidation()" pattern="^[0-9]{3,4}$">
                                            <div class="invalid-feedback"> Il CVV della carta di credito è necessario! </div>
                                        </div>
                                    </div>
                                    <hr class="mb-4">
                                </div>
                                    <button id="payBtnOrderCO" class="btn btn-primary btn-lg btn-block" type="submit">Procedi all'ordine</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
