package com.iraci.servlet.user;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;
import com.iraci.model.User;
import com.iraci.utils.Mailer;
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
 * Questa classe gestisce la prenotazione delle postazioni
 * @author Davide Iraci
 */
@WebServlet(name = "placeBookServlet", urlPatterns={"/user/placeBook"})
public class placeBookServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Prende i dati selezionati dall'utente
            String method, name, surname, email, fiscal, address, region, province, city, cap, cardno, period;
            method = request.getParameter("PaymentMethod");
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
            int extrachair = Integer.parseInt(request.getParameter("Order[EXTRA_CHAIR]"));
            double totalprice = Double.parseDouble(request.getParameter("Order[TOTAL_PRICE]"));
            period = request.getParameter("Order[PERIOD]");
            LocalDate date = LocalDate.parse(request.getParameter("Order[DATE]"));

            // Inizializza le postazioni passate tramite JSON
            List<Postation> postations=new ArrayList<>();
            int i=0, id;
            while (request.getParameter("Order[POSTATION]["+i+"][id]")!=null){
                postations.add(new Postation(Integer.parseInt(request.getParameter("Order[POSTATION]["+i+"][id]")), Double.parseDouble(request.getParameter("Order[POSTATION]["+i+"][price]"))));
                i++;
            }

            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            String status;

            if(Utils.occupiedCheck(postations, date, period) || (id=DataBase.placeBook(postations, date, period, totalprice, ((User) request.getSession().getAttribute("USER")).getIdUtente(), extrachair))==-1){
                // Verifica se le postazioni sono state occupate nel mentre e verifica se c'è stato un errore nella prenotazione
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"E' stato riscontrato un errore nella prenotazione, una postazione risulta già prenotata! Per favore riprovare!\"}";
            }else{
                // Prenotazione effettuata, inserisce i dati della fattura, quindi invia una mail al cliente con i dati della prenotazione
                DataBase.insertInvoid(id, name, surname, email, fiscal, address, region, province, city, cap, method, cardno);
                status = "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il tuo ordine è stato pagato e confermato! A presto!\"}"; //Send email confirm order

                String start=(period.equals("PM"))?"14:00":"8:00", end=(period.equals("AM"))?"13:00":"19:00";
                String messaggio = "<p>Ciao " + name + " " + surname + ", <br>"
                        + "ti comunichiamo che è stato effettuato l'ordine N°"+String.format("%08d", id)+" per giorno " + date + ". Ti aspettiamo dalle ore "
                        + start + " alle ore " + end + "<br>Nel sito puoi gestire la tua prenotazione e trovare la relativa fattura.<br><br>"
                        + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                        + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                        + "Lo staff del lido</p>";
                Mailer mailer = new Mailer(((User) request.getSession().getAttribute("USER")).getEmail(), "Lido Zanzibar - Conferma ordine N°"+String.format("%08d", id), messaggio);
                Thread thread = new Thread(mailer);
                thread.start();
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
        response.sendError(404);
    }
}
