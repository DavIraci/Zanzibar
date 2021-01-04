package com.iraci.servlet.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Book;
import com.iraci.model.Postation;
import com.iraci.model.User;
import com.iraci.utils.Utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "bookingServlet", urlPatterns={"/common/checkBook"})
public class checkBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            LocalDate date = LocalDate.parse(request.getParameter("Date"));
            String period = request.getParameter("Period");
            String[] ids = request.getParameter("Sit").split(",");
            List<Postation> idPostazioni= new ArrayList<>(); //Arrays.asList(request.getParameter("Sit").split(","));
            int extra_chair = Integer.parseInt(request.getParameter("ExtraChair"));
            int i;
            boolean error=false;
            List<Double> prices= DataBase.takePrice(date, period);
            Double extra = prices.get(0);
            Double total= extra_chair*extra;

            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;

            for(i=0; i< ids.length; i++){
                idPostazioni.add(new Postation(Integer.parseInt(ids[i].substring(ids[i].length()- 2)), prices));
            }

            for(i=0; i<idPostazioni.size(); i++){
                total+=idPostazioni.get(i).getPrice();
            }

            if(Utils.occupiedCheck(idPostazioni, date, period)) {
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"E' stato riscontrato un errore nella prenotazione, una postazione risulta già prenotata! Per favore riprovare!\"}";
            }else {

                status = "{\"RESPONSE\" : \"Confirm\", \"POSTATION\" : "+ mapper.writeValueAsString(idPostazioni) +" , \"EXTRA_CHAIR\" : "+ extra_chair +" , \"TOTAL_PRICE\" : "+ total +" }";
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
