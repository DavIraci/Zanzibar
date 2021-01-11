package com.iraci.servlet.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;
import com.iraci.utils.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Questa classe gestisce la verifica la possibilità di effettuare la prenotazione richiesta dall'utente
 * @author Davide Iraci
 */
@WebServlet(name = "bookingServlet", urlPatterns={"/user/checkBook"})
public class checkBookServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Prende i dati selezionati dall'utente
            LocalDate date = LocalDate.parse(request.getParameter("Date"));
            String period = request.getParameter("Period");
            String[] ids = request.getParameter("Sit").split(",");
            int extra_chair = Integer.parseInt(request.getParameter("ExtraChair"));


            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;

            // Prende i prezzi del periodo richiesto dall'utente
            List<Double> prices= DataBase.takePrice(date, period);
            Double extra = prices.get(0);
            double total= extra_chair*extra;

            // Inizializza le postazioni e il calcola il prezzo totale
            List<Postation> idPostazioni= new ArrayList<>();
            int i;
            for(i=0; i< ids.length; i++){
                idPostazioni.add(new Postation(Integer.parseInt(ids[i].substring(ids[i].length()- 2)), prices));
            }
            for(i=0; i<idPostazioni.size(); i++){
                total+=idPostazioni.get(i).getPrice();
            }

            // Verifica se nel mentre le postazioni sono state occupate
            if(Utils.occupiedCheck(idPostazioni, date, period)) {
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"E' stato riscontrato un errore nella prenotazione, una postazione risulta già prenotata! Per favore riprovare!\"}";
            }else { // Ritorna tutti i dati per compilare il form di Checkout
                status = "{\"RESPONSE\" : \"Confirm\", \"POSTATION\" : "+ mapper.writeValueAsString(idPostazioni) +" , \"EXTRA_CHAIR\" : "+ extra_chair +" , \"TOTAL_PRICE\" : "+ total +" }";
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
