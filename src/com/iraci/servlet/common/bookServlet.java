package com.iraci.servlet.common;

import com.iraci.DataBase.DataBase;
import com.iraci.model.User;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "bookServlet", urlPatterns={"/common/book"})
public class bookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String data;
            data = request.getParameter("data");
            LocalDate date = LocalDate.parse(data, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            //ObjectMapper mapper = new ObjectMapper();
            String status;


            status = "{\"RESPONSE\" : \"Confirm\", \"TYPE\" : \"Data insert error\",\"MESSAGE\" : \"" + errore + "\"}";


            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Common/book.jsp");
        dispatcher.forward(request, response);
    }
}
