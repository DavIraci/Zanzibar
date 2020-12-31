package com.iraci.servlet.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Invoice;
import com.iraci.model.Order;
import com.iraci.model.Postation;
import com.iraci.model.User;
import com.iraci.utils.InvoiceGenerator;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "manageBookServlet", urlPatterns={"/user/managebook"})
public class manageBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status;
            int id;

            if(request.getParameter("BookID")!=null && request.getParameter("Request").equals("Invoid")){
                sendInvoid(Integer.parseInt(request.getParameter("BookID")), request);
                status = "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Inviata email con fattura in allegato!\"}";
            }else { //TakeBook
                List<Order> book = DataBase.getBooks(((User) request.getSession().getAttribute("USER")).getIdUtente());

                if (book.isEmpty()) {
                    status = "{\"RESPONSE\" : \"Alert\", \"MESSAGE\" : \"Non è stata effettuata ancora alcuna prenotazione\"}";
                } else {
                    status = "{\"RESPONSE\" : \"Confirm\", \"BOOK\" : " + mapper.writeValueAsString(book) + " }";
                }
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    private void sendInvoid(int bookID, HttpServletRequest request) throws SQLException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Invoice invoice= DataBase.getInvoice(bookID);
        if(invoice==null){
            //errore da gestire
        }
        InvoiceGenerator.createInovice(baos, invoice);
        byte[] bytes = baos.toByteArray();
        String title=baos.toString().substring(baos.toString().indexOf("Title(")+6, baos.toString().indexOf("Title(")+29).trim();

        User user=((User) request.getSession().getAttribute("USER"));
        String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                + "Questa è una prova di invio della fattura come allegato<br><br>"
                + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                + "Lo staff del lido</p>";

        Mailer mailer = new Mailer(((User) request.getSession().getAttribute("USER")).getEmail(), "Lido Zanzibar - "+ title, messaggio, bytes, title);

        Thread thread = new Thread(mailer);
        thread.start();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/manageBook.jsp");
        dispatcher.forward(request, response);
    }
}
