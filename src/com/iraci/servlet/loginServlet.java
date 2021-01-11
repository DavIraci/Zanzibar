package com.iraci.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Questa classe gestisce la richiesta di login o la richiesta di visualizzazione della pagina stessa
 * @author Davide Iraci
 */
@WebServlet(name = "loginServlet", urlPatterns={"/login"})
public class loginServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Verifica se le credenziali sono sbagliate e reindirizza alla pagina di errore
        if (request.getParameter("Authentication") != null && request.getParameter("Authentication").equals("Error")) {
            request.getSession().setAttribute("Login", "ERROR");
        }
        response.sendRedirect(request.getContextPath()+ "/");
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.getSession().setAttribute("Login", "TRUE");
        response.sendRedirect(request.getContextPath()+ "/");
    }
}
