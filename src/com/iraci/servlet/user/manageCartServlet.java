package com.iraci.servlet.user;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Cart;
import com.iraci.model.Invoice;
import com.iraci.model.Product;
import com.iraci.model.User;
import com.iraci.utils.InvoiceGenerator;
import com.iraci.utils.Mailer;

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

/**
 * Questa classe gestisce tutte le operazioni effettuate sul carrello, compreso l'ordine
 * @author Davide Iraci
 */
@WebServlet(name = "manageCartServlet", urlPatterns={"/user/cartManage"})
public class manageCartServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Verifica se c'è stato un errore della richieta JSON
            if(request.getParameter("Type")==null)
                response.sendError(400);
            else{ // Prende il tipo di operazione richesta e invoca il metodo adeguato
                String status=null, type=request.getParameter("Type");
                switch (type){
                    case "AddProduct": {
                        addProduct(request, response);
                        break;
                    }
                    case "CartSize": {
                        status=cartSize(request);
                        break;
                    }
                    case "CartManage": {
                        status=cartManage(request);
                        break;
                    }
                    case "UpdateQuantity": {
                        status=updateQuantity(request);
                        break;
                    }
                    case "PlaceOrder": {
                        status=placeOrder(request);
                        break;
                    }
                    default:{
                        response.sendError(400);
                    }
                }
                if(status!=null) { // Se è prevista una risposta la invia
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

    /**
     * Metodo che effettua la richiesta di ordine dei prodotti nel carrello
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private String placeOrder(HttpServletRequest request) throws SQLException {
        // Prende i dati selezionati dall'utente
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

        // Verifica se l'utente è attualmente all'interno del lido
        if( !(DataBase.userInSite(user.getIdUtente())) )
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile effettuare ordini se non si è all'interno del lido!\"}";

        // Verifica che il carrello non sia vuoto
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null || cart.getSize()==0) {
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile effettuare un ordine con il carrello vuoto!\"}";
        }

        // Effettua l'ordine inserendolo nel DB
        int order_id = DataBase.placeOrder(cart, user.getIdUtente(), !method.equals("Cassa"), delivery);

        // Verifica se c'è stato errore nell'inserimento
        if(order_id==-1)
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile effettuare l'ordine! Riprovare!\"}";

        // Resetta il carrello e invia la mail all'utente, nel caso in cui il pagamento sia online invia la fattura dell'ordine
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

    /**
     * Metodo che effettua la modifica della quantità di un oggetto inserito nel carrello o lo rimuove se è 0
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     */
    private String updateQuantity(HttpServletRequest request) {
        // Prende i dati dell'utente
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));

        // Carica il carrello e verifica se è vuoto
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null || cart.getSize()==0 || cart.searchProduct(barcode)==null) {
            return "{\"RESPONSE\" : \"Error\"}";
        }

        // Se la quantità voluta è 0 allora rimuove il prodotto, viceversa imposta la quantità voluta
        if(quantity==0){
            cart.removeProduct(barcode);
        }else {
            cart.setQuantity(barcode, quantity);
            quantity = cart.getQuantity(barcode);
        }

        if(quantity<0)
            return "{\"RESPONSE\" : \"Error\"}";
        return "{\"RESPONSE\" : \"Confirm\", \"QUANTITY\" : "+quantity+"}";
    }

    /**
     * Metodo che si occupa di restituire il carello
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private String cartManage(HttpServletRequest request) throws SQLException {
        // Carica il carrello e verifica se è vuoto
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null || cart.getSize()==0) {
            return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+null+"}";
        }
        return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+cart.toajaxString()+", \"INSITE\" : "+DataBase.userInSite(((User) request.getSession().getAttribute("USER")).getIdUtente()) +"}";
    }

    /**
     * Metodo che si occupa di restituire il quantitativo di prodotti nel carrello
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     */
    protected String cartSize(HttpServletRequest request) {
        // Carica il carrello, verifica se è vuoto e ne restituisce la quantità
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null)
            return "{\"RESPONSE\" : \"Confirm\", \"SIZE\" : "+0+"}";
        return "{\"RESPONSE\" : \"Confirm\", \"SIZE\" : "+cart.getSize()+"}";
    }

    /**
     * Metodo che aggiunge il prodotto selezionato dall'utente al carrello
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @throws SQLException SQLException
     */
    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        // Prende i dati selezionati dall'utente e verifica che non ci siano errori
        if(request.getParameter("Barcode")==null || request.getParameter("Quantity")==null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        String note=request.getParameter("Description");
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));


        // Carica il carrello, verifica se è vuoto e in caso lo istanzia
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        if(cart == null) {
            cart = new Cart();
        }

        // Se il prodotto non è ancora presente all'interno del carrello richiede al database i dati del prodotto selezionato.
        Product product;
        if((product=cart.searchProduct(barcode))==null) {
            product = DataBase.getProduct(barcode);
            if(product == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        // Aggiunge il prodotto al carrello (caso in cui non era presente) o ne incrementa la quantità (caso in cui era già nel carrello del cliente).
        cart.addProduct(product, quantity, note);
        request.getSession().setAttribute("CART", cart);
    }

    /**
     * Metodo che si occupa di generare la fattura dell'ordine e inviarla via mail al cliente
     * @param orderID ID ordine
     * @param user Oggetto User
     * @param cart Oggetto Cart
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private boolean sendOrderInvoid(int orderID, User user, Cart cart, HttpServletRequest request ) throws SQLException {
        // Controlla se la fattura esiste e la prende dal DB
        Invoice invoice= DataBase.getOrderInvoice(orderID, cart);
        if(invoice==null)
            return false;

        // Crea gli oggetti necessari alla fattura e invoca la creazione della stessa con la classe InvoiceGenerator
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        InvoiceGenerator.createOrderInovice(baos, invoice);
        byte[] bytes = baos.toByteArray();
        String title=baos.toString().substring(baos.toString().indexOf("Title(")+6, baos.toString().indexOf("Title(")+29).trim();

        // Prende i dati dell'utente e invia la mail con la fattura in allegato
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

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/cart.jsp");
        dispatcher.forward(request, response);
    }
}
