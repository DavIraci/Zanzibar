package com.iraci.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.*;
import com.iraci.utils.InvoiceGenerator;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "manageCartServlet", urlPatterns={"/user/cartManage"})
public class manageCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(request.getParameter("Type")==null)
                response.sendError(400);
            else{
                String status=null, type=request.getParameter("Type");
                switch (type){
                    case "AddProduct": {
                        addProduct(request, response);
                        break;
                    }
                    case "CartSize": {
                        status=cartSize(request, response);
                        break;
                    }
                    case "CartManage": {
                        status=cartManage(request, response);
                        break;
                    }
                    case "UpdateQuantity": {
                        status=updateQuantity(request, response);
                        break;
                    }
                    case "PlaceOrder": {
                        status=placeOrder(request, response);
                        break;
                    }
                    default:{
                        System.out.println("Error!");
                    }
                }
                if(status!=null) {
                    PrintWriter pr = response.getWriter();
                    response.setContentType("application/json");
                    pr.write(status);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    private String placeOrder(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String method, delivery, name, surname, email, fiscal, address, region, province, city, cap, cardno;
        method = request.getParameter("PaymentMethod");
        delivery = request.getParameter("DeliveryMethod");
        name = request.getParameter("Name");
        surname = request.getParameter("Surname");
        email = request.getParameter("Email");
        fiscal = request.getParameter("Fiscal");
        address = request.getParameter("Address");
        region = request.getParameter("Region");
        province = request.getParameter("Province");
        city = request.getParameter("City");
        cap = request.getParameter("CAP");
        cardno = request.getParameter("CardNO");

        User user=((User) request.getSession().getAttribute("USER"));

        if( !(DataBase.userInSite(user.getIdUtente())) )
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile effettuare ordini se non si è all'interno del lido!\"}";

        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null || cart.getSize()==0) {
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile effettuare un ordine con il carrello vuoto!\"}";
        }

        int order_id = DataBase.placeOrder(cart, user.getIdUtente(), method.equals("Cassa")?false:true, delivery);
        if(order_id==-1)
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile effettuare l'ordine! Riprovare!\"}";

        request.getSession().setAttribute("CART", null);
        if(!method.equals("Cassa")) {
            DataBase.insertOrderInvoid(order_id, name, surname, email, fiscal, address, region, province, city, cap, method, cardno);
            sendOrderInvoid(order_id, user, cart, request);
        }else{
            String messaggio = "<p>Ciao " + name + " " + surname + ", <br>"
                    + "ti comunichiamo che è stato effettuato l'ordine N°"+String.format("%08d", order_id)+".<br>"
                    + "Questo è il riepilogo del suo ordine:<br>"+cart.getProductsString()
                    + "<br>Riceverai aggiornamenti tramite email quando lo stato dell'ordine cambierà!<br><br>"
                    + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                    + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                    + "Lo staff del lido</p>";
            Mailer mailer = new Mailer(user.getEmail(), "Lido Zanzibar - Conferma ordine N°"+String.format("%08d", order_id), messaggio);
            Thread thread = new Thread(mailer);
            thread.start();
        }
        return  "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il tuo ordine è stato confermato! <br>Riceverai a breve un'email contenente i dettagli dell'ordine!\"}"; //Send email confirm order
    }

    private String updateQuantity(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null || cart.getSize()==0 || cart.searchProduct(barcode)==null) {
            return "{\"RESPONSE\" : \"Error\"}";
        }
        if(quantity==0){
            cart.removeProduct(barcode);
        }else {
            cart.setQuantity(barcode, quantity);
            quantity = cart.getQuantity(barcode);
        }
        if(quantity==-1)
            return "{\"RESPONSE\" : \"Error\"}";
        return "{\"RESPONSE\" : \"Confirm\", \"QUANTITY\" : "+quantity+"}";

    }

    private String cartManage(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException, SQLException {
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null || cart.getSize()==0) {
            return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+null+"}";
        }
        return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+cart.toajaxString()+", \"INSITE\" : "+DataBase.userInSite(((User) request.getSession().getAttribute("USER")).getIdUtente()) +"}";
    }

    protected String cartSize(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        int quantity;
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null) {
            quantity=0;
        }else{
            quantity= cart.getSize();
        }
        return "{\"RESPONSE\" : \"Confirm\", \"SIZE\" : "+quantity+"}";
    }

    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        if(request.getParameter("Barcode")==null || request.getParameter("Quantity")==null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        String note=request.getParameter("Description");
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));

        Product product;
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null) {
            cart = new Cart();
        }
        /* Se il prodotto non è ancora presente all'interno del carrello richiede al database i dati del prodotto
         * selezionato.
         */
        if((product=cart.searchProduct(barcode))==null) {
            product = DataBase.getProduct(barcode);
            if(product == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        /* Aggiunge il prodotto al carrello (caso in cui non era presente) o ne incrementa la quantità
         * (caso in cui era già nel carrello del cliente).
         */
        cart.addProduct(product, quantity, note);
        System.out.println(cart);
        request.getSession().setAttribute("CART", cart);
    }

    private boolean sendOrderInvoid(int orderID, User user, Cart cart, HttpServletRequest request ) throws SQLException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Invoice invoice= DataBase.getOrderInvoice(orderID, cart);
        if(invoice==null)
            return false;

        InvoiceGenerator.createOrderInovice(baos, invoice);
        byte[] bytes = baos.toByteArray();
        String title=baos.toString().substring(baos.toString().indexOf("Title(")+6, baos.toString().indexOf("Title(")+29).trim();

        String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                + "ti comunichiamo che è stato effettuato l'ordine N°"+String.format("%08d", invoice.getOrderID())+".<br>"
                + "Questo è il riepilogo del suo ordine:<br>"+cart.getProductsString()+ "<br>"
                + "In allegato troverai la fattura dell'ordine da te richiesta!"
                + "<br>Riceverai aggiornamenti tramite email quando lo stato dell'ordine cambierà!<br><br>"
                + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                + "Lo staff del lido</p>";

        Mailer mailer = new Mailer(user.getEmail(), "Lido Zanzibar - "+ title, messaggio, bytes, title);

        Thread thread = new Thread(mailer);
        thread.start();
        return true;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/cart.jsp");
        dispatcher.forward(request, response);
    }
}
