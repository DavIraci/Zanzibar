package com.iraci.servlet.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;
import com.iraci.model.User;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "placeBookServlet", urlPatterns={"/common/placeBook"})
public class placeBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String method, name, surname, email, fiscal, address, region, province, city, cap, cardno, period;
            List<Postation> postations=new ArrayList<>();
            int i=0, extrachair, id;
            double totalprice;
            LocalDate date;
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
            while (request.getParameter("Order[POSTATION]["+i+"][id]")!=null){
                postations.add(new Postation(Integer.parseInt(request.getParameter("Order[POSTATION]["+i+"][id]")), Double.parseDouble(request.getParameter("Order[POSTATION]["+i+"][price]"))));
                i++;
            }
            extrachair = Integer.parseInt(request.getParameter("Order[EXTRA_CHAIR]"));
            totalprice = Double.parseDouble(request.getParameter("Order[TOTAL_PRICE]"));
            period = request.getParameter("Order[PERIOD]");
            date = LocalDate.parse(request.getParameter("Order[DATE]"));
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;

            if(Utils.occupiedCheck(postations, date, period) || (id=DataBase.placeBook(postations, date, period, totalprice, ((User) request.getSession().getAttribute("USER")).getIdUtente(), extrachair))==-1){
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"E' stato riscontrato un errore nella prenotazione, una postazione risulta già prenotata! Per favore riprovare!\"}";
            }else{
                DataBase.insertInvoid(id, name, surname, email, fiscal, address, region, province, city, cap, method, cardno);
                status = "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il tuo ordine è stato pagato e confermato! A presto!\"}"; //Send email confirm order

                String start=(period.equals("PM")==true)?"14:00":"8:00", end=(period.equals("AM")==true)?"13:00":"19:00";

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


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(400);
    }
}
