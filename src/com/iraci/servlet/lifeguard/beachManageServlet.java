package com.iraci.servlet.lifeguard;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Book;
import com.iraci.model.User;

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
 * Questa classe si occupa della gestione della spiaggia da parte del bagnino
 * @author Davide Iraci
 */
@WebServlet(name = "beachManageServlet", urlPatterns={"/lifeguard/beachManage"})
public class beachManageServlet extends HttpServlet {
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Verifica se c'è stato un errore della richieta JSON
            if (request.getParameter("Type") == null)
                response.sendError(400);
            else { // Prende il tipo di operazione richesta e invoca il metodo adeguato
                String status = null, type = request.getParameter("Type");
                switch (type) {
                    case "Load": {
                        status = loadBeach(request, response);
                        break;
                    }
                    case "CheckIN": {
                        status = checkIN(request);
                        break;
                    }
                    case "CheckOUT": {
                        status = checkOUT(request);
                        break;
                    }
                    default: {
                        response.sendError(400);
                    }
                }
                if (status != null) { // Se è prevista una risposta la invia
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Lifeguard/beachManage.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Metodo per il caricamento di tutte le prenotazioni e gli utenti correlati
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private String loadBeach(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Prende i dati selezionati dal bagnino
        LocalDate date = LocalDate.parse(request.getParameter("Date"));
        String period = request.getParameter("Period");

        // Verifica il corretto format del periodo, prende la lista di prenotazioni, la lista degli utenti e invia la risposta JSON
        if(period.equals("Full") || period.equals("AM") || period.equals("PM")){
            List<Book> booked= DataBase.takeBooks(date, period);
            List<User> users=new ArrayList();

            // Per ogni prenotazione prende e i dati dell'utente e li inserisce nella lista a meno che non siano già presenti
            for ( Book book : booked ){
                User user = DataBase.takeUser(book.getUser_id());
                if(!users.contains(user))
                    users.add(user);
            }

            // Prepara il necessario per la risposta JSON
            ObjectMapper mapper = new ObjectMapper();

            return  "{\"RESPONSE\" : \"Confirm\", \"BOOKED\" : "+ mapper.writeValueAsString(booked) +", \"USERS\" : "+ mapper.writeValueAsString(users) +"}";
        }else{
            response.sendError(400);
            return null;
        }
    }

    /**
     * Metodo per l'inserimento del timestamp del check-in del cliente
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private String checkIN(HttpServletRequest request) throws SQLException {
        // Prende i dati selezionati dal bagnino
        int bookID = Integer.parseInt(request.getParameter("BookID"));
        String guests = request.getParameter("Guests");

        if(!DataBase.insertCheckIn(bookID, guests)){
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile registrare il Check-in, riprovare!\"}";
        }else {
            return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il Check-in è stato correttamente registrato\"}";
        }
    }

    /**
     * Metodo per l'inserimento del timestamp del check-out del cliente
     * @param request Servelt request del metodo invocante
     * @return stringa di risposta JSON
     * @throws SQLException SQLException
     */
    private String checkOUT(HttpServletRequest request) throws SQLException {
        // Prende i dati selezionati dal bagnino
        int bookID = Integer.parseInt(request.getParameter("BookID"));

        if(!DataBase.insertCheckOut(bookID))
            return "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile registrare il Check-out, riprovare!\"}";
        else
            return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il Check-out è stato correttamente registrato\"}";
    }
}
