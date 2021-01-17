package com.iraci.servlet.company;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Order;
import com.iraci.model.User;
import com.iraci.utils.Mailer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Questa classe gestisce la consegna e il pagamento degli ordini del servizio ristorazione
 * @author Davide Iraci
 */
@WebServlet(name = "deskServlet", urlPatterns={"/company/desk"})
public class deskServlet extends HttpServlet {
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
                    case "GetOrders": {
                        status=getOrders(request, response);
                        break;
                    }case "ChangeStatus": {
                        status=changeStatus(request, response);
                        break;
                    }default:{
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Company/desk.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Metodo che restituisce la lista degli ordini attualmente non completati
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException SQLException
     */
    protected String getOrders(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende gli ordini del giorno attuale
        //List<Order> orders = DataBase.getOrdersDesk(LocalDate.parse("2021-01-11"));
        List<Order> orders = DataBase.getOrdersDesk(LocalDate.now());
        List<User> users=new ArrayList();
        String ajaxOrders="[";

        // Per ogni ordine prende e i dati dell'utente e li inserisce nella lista a meno che non siano già presenti
        // inoltre crea la concatenazione degli ordini formati per la risposta AJAX
        for ( Order order : orders ){
            ajaxOrders+=order.toAjax() + ", ";
            User user = DataBase.takeUser(order.getUserID());
            if(!users.contains(user))
                users.add(user);
        }

        // Prepara il necessario per la risposta JSON
        ObjectMapper mapper = new ObjectMapper();
        if (orders.isEmpty())
            ajaxOrders+="] ";
        else
            ajaxOrders=ajaxOrders.substring(0, ajaxOrders.length() - 2)+"] ";

        return  "{\"RESPONSE\" : \"Confirm\", \"ORDERS\" : "+ ajaxOrders +", \"USERS\" : "+ mapper.writeValueAsString(users) +"}";
    }

    /**
     * Metodo che modifica lo status di un ordine
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException
     * @throws JsonProcessingException
     */
    protected String changeStatus(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende i dati selezionati dal cuoco e recupera l'ordine
        int orderID = Integer.parseInt(request.getParameter("OrderID"));
        Order order = DataBase.getOrder(orderID);
        char newStatus;

        // Se l'ordine non esiste risponde con un errore
        if(order == null)
            return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
        else{
            // Verifica l'attuale stato e elabora il prossimo
            String status=order.getStatus()+"";
            switch (status){
                // Se lo stato attuale non è modificabile restituisce errore
                case "A":
                case "W":
                case "D":{
                    return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile cambiare lo stato di questo ordine!\" }";
                }
                case "T":{
                    if(order.isPayed())
                        status="Consegnato!";
                    else {
                        if(!DataBase.payOrder(orderID))
                            return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
                        status = "Consegnato e pagato!";
                    }
                    newStatus = "D".charAt(0);
                    break;
                }
                case "R": {
                    if (order.getDeliveryMethod().equals("Bar")) {
                        if (order.isPayed())
                            status = "Ritirato!";
                        else {
                            if(!DataBase.payOrder(orderID))
                                return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
                            status = "Pagato e ritirato!";
                        }
                        newStatus = "D".charAt(0);
                    }else {
                        status = "In consegna!";
                        newStatus = "T".charAt(0);

                        if(order.isPayed())
                            status+="<br>Ti ricordiamo che hai già pagato il tuo ordine!";
                        else
                            status+="<br>Ti ricordiamo che devi pagare il tuo ordine!";
                    }
                    break;
                }
                default:{
                    return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
                }
            }

            // Aggiorna il record nel DB e in caso di errore lo comunica
            if(!DataBase.updateOrderStatus(orderID, newStatus+""))
                return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
            else {
                // Conferma al cliente il cambio di stato e manda la risposta al Client
                User user=DataBase.takeUser(order.getUserID());

                String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                        + "Ti avvisiamo che lo stato del tuo ordine è cambiato in: <br> "+ status +"!<br><br>"
                        + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                        + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                        + "Lo staff del lido</p>";

                Mailer mailer = new Mailer(user.getEmail(), "Lido Zanzibar - Modifica stato ordine N°"+String.format("%08d", orderID), messaggio);
                Thread thread = new Thread(mailer);
                thread.start();

                return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il cambio è stato correttamente effettuato!\" }";
            }
        }
    }
}
