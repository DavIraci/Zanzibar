package com.iraci.servlet.user;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;

import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

/**
 * Questa classe gestisce la visualizzazione della mappa della spiaggia in base al giorno e all'intervallo selezionato
 * @author Davide Iraci
 */
@WebServlet(name = "bookServlet", urlPatterns={"/user/book"})
public class bookServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Prende i dati selezionati dall'utente
            LocalDate date = LocalDate.parse(request.getParameter("Date"));
            String period = request.getParameter("Period");

            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;

            // Verifica il corretto format del periodo, prende la lista di prenotazioni, dei prezzi e invia la risposta JSON
            if(period.equals("Full") || period.equals("AM") || period.equals("PM")){
                List<Postation> booked= DataBase.takeBooking(date, period);
                List<Double> price=DataBase.takePrice(date, period);
                Double extra = price.remove(0);

                status = "{\"RESPONSE\" : \"Confirm\", \"BOOKED\" : "+ mapper.writeValueAsString(booked) +" , \"PRICE\" : "+ mapper.writeValueAsString(price)+" , \"EXTRA_CHAIR_PRICE\" : \"" + extra + "\"}";
                pr.write(status);
            }else{
                response.sendError(400);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/book.jsp");
        dispatcher.forward(request, response);
    }
}
