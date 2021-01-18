package com.iraci.servlet.company;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
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
import java.util.List;

/**
 * Questa classe gestisce la segnalazione di un cliente trovato positivo, comunicando ai clienti
 * presenti lo stesso giorno al lido di fare un tampone
 * @author Davide Iraci
 */
@WebServlet(name = "covidAlertServlet", urlPatterns={"/company/covidAlert"})
public class covidAlertServlet extends HttpServlet {
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
                    case "GetCustomers": {
                        status=getCustomers(request, response);
                        break;
                    }case "SendAlert": {
                        status=sendAlert(request, response);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Company/covidAlert.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Metodo che restituisce la lista degli ordini
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException SQLException
     */
    protected String getCustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende i clienti che erano presenti nel lido il giorno selezionato
        LocalDate date = LocalDate.parse(request.getParameter("Date"));
        List<User> customers = DataBase.getCustomersInDate(date);

        // Prepara il necessario per la risposta JSON
        ObjectMapper mapper = new ObjectMapper();

        return  "{\"RESPONSE\" : \"Confirm\", \"CUSTOMERS\" : "+ mapper.writeValueAsString(customers) +"}";
    }

    /**
     * Metodo che restituisce la lista degli ordini
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException SQLException
     */
    protected String sendAlert(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        // Prende i clienti che erano presenti nel lido il giorno selezionato
        LocalDate date = LocalDate.parse(request.getParameter("Date"));
        int userID = Integer.parseInt(request.getParameter("Customer"));
        List<User> customers = DataBase.getCustomersInDate(date);
        User user = DataBase.getUser(userID);

        // Rimuove il cliente risultato positivo dalla lista
        customers.remove(customers.indexOf(user));

        // Invia la mail ad ogni utente presente nella lista
        for (User customer: customers){
            String messaggio = "<p>Ciao " + customer.getNome() + " " + customer.getCognome() + ", <br>"
                    + "con grande rammarico dobbiamo avvisarti che un altro cliente presente al lido come te giorno " + date.toString()
                    + " &egrave; risultato positivo al SARS-CoV-2. Pertanto ti consigliamo di effettuare un isolamento volontario e "
                    + " effettuare quanto prima il tampone!<br><br>"
                    + "Nella speranza che non possa avere nessun problema di salute,"
                    + "<br>Ti auguriamo una buona giornata, a presto! <br><br>"
                    + "Lo staff del lido</p>";
            Mailer mailer = new Mailer(customer.getEmail(), "Lido Zanzibar - AVVISO IMPORTANTE POSSIBILE INFEZIONE", messaggio);
            Thread thread = new Thread(mailer);
            thread.start();
        }
        return  "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"E' stata inviata la comunicazione a tutti i clienti!\"}";
    }
}
