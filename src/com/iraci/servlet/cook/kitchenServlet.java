package com.iraci.servlet.cook;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.*;
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
 * Questa classe gestisce la preparazione degli ordini del servizio ristorazione
 * @author Davide Iraci
 */
@WebServlet(name = "kitchenServlet", urlPatterns={"/cook/kitchen"})
public class kitchenServlet extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Cook/kitchen.jsp");
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
        // Prende gli ordini del giorno attuale non ancora completati
        //List<Order> orders = DataBase.getOrders(LocalDate.parse("2021-01-11"));
        List<Order> orders = DataBase.getOrders(LocalDate.now());
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
                case "A": {
                    status="in lavorazione";
                    newStatus = "W".charAt(0);
                    break;
                }
                case "W": {
                    if (order.getDeliveryMethod().equals("Bar")){
                        newStatus = "R".charAt(0);
                        status="pronto per il ritiro! Ti aspettiamo al banco!";
                    }else {
                        newStatus = "T".charAt(0);
                        status = "in consegna! A breve ti verrà portato all'ombrellone!";
                    }
                    if(order.isPayed())
                        status+="<br>Ti ricordiamo che hai già pagato il tuo ordine!";
                    else
                        status+="<br>Ti ricordiamo che devi pagare il tuo ordine!";
                    break;
                }
                // Se lo stato attuale non è modificabile dal cuoco restituisce errore
                case "T":
                case "R":
                case "D": {
                    return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è possibile cambiare lo stato di questo ordine!\" }";
                }
                default:{
                    return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
                }
            }

            // Aggiorna il record nel DB e in caso di errore lo comunica
            if(!DataBase.updateOrderStatus(orderID, newStatus+""))
                return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare3!\" }";
            else {
                // Conferma al cliente il cambio di stato e manda la risposta al Client
                User user=DataBase.takeUser(order.getUserID());

                String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                        + "Ti avvisiamo che lo stato del tuo ordine è cambiato in: <br> "+ status +"!<br><br>"
                        + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                        + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                        + "Lo staff del lido</p>";

                Mailer mailer = new Mailer(user.getEmail(), "Lido Zanzibar - Modifica stato ordine", messaggio);
                Thread thread = new Thread(mailer);
                thread.start();

                return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il cambio è stato correttamente effettuato!\" }";
            }
        }
    }
}
