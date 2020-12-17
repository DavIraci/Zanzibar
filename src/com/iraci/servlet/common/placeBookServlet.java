package com.iraci.servlet.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "bookingServlet", urlPatterns={"/common/placeBook"})
public class placeBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            LocalDate date = LocalDate.parse(request.getParameter("Date"));
            String period = request.getParameter("Period");
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;

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


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
