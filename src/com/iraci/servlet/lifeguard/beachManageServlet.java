package com.iraci.servlet.lifeguard;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Questa classe si occupa della gestione della spiaggia da parte del bagnino
 * @author Davide Iraci
 */
@WebServlet(name = "beachManageServlet", urlPatterns={"/lifeguard/beachManage"})
public class beachManageServlet extends HttpServlet {
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Lifeguard/beachManage.jsp");
        dispatcher.forward(request, response);
    }
}
