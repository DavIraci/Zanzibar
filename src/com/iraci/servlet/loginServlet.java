package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "loginServlet", urlPatterns={"/login"})
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getUserPrincipal() != null){
            //System.out.println("Utente loggato: "+ request.getUserPrincipal().getName());
            try {
                User user=DataBase.takeUser(request.getUserPrincipal().getName());
                if(user == null){
                    response.sendError(400);
                }
                request.getSession().setAttribute("USER", user);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        } else if(request.getParameter("Authentication") != null && request.getParameter("Authentication").equals("Error")) {
            //System.out.println("Errore nel login!");
            request.getSession().setAttribute("Login", "ERROR");
        } else {
            //System.out.println("Nessun utente loggato! ");
            request.getSession().setAttribute("Login", "TRUE");
        }
        response.sendRedirect(request.getContextPath()+ "/");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            doPost(request, response);
    }
}
