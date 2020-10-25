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

/**
 * Questa classe gestisce la richiesta di login o la richiesta di visualizzazione della pagina stessa
 * @author Davide Iraci
 */
@WebServlet(name = "loginServlet", urlPatterns={"/login"})
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getUserPrincipal() != null && request.getSession().getAttribute("USER") == null ) { //Richiesta post j_security_check
            try {
                User user = DataBase.takeUser(request.getUserPrincipal().getName());
                if (user == null) {
                    response.sendError(400);
                }
                request.getSession().setAttribute("USER", user);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

        } else if (request.getParameter("Authentication") != null && request.getParameter("Authentication").equals("Error")) { //Credenziali sbagliate
            request.getSession().setAttribute("Login", "ERROR");
        } else { //Richiesta pagina da url
            request.getSession().setAttribute("Login", "TRUE");
        }
        response.sendRedirect(request.getContextPath()+ "/");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
