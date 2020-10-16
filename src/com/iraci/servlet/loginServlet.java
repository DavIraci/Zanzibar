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
        /*String username=request.getParameter("j_username");
        String pass=request.getParameter("j_password");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");

        //Reindirizzare alla home!

        if(username==null || pass==null) {
            request.setAttribute("Login", "TRUE");
        }else{
            User user= null;

            try {
                user = DataBase.login(username, pass);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

            if(user == null){
                request.setAttribute("ErrorMessage", "Username o password errati!");
            }else{
                request.getSession().setAttribute("USER", user);
            }
        }
        dispatcher.forward(request, response);*/
        request.getSession().setAttribute("Login", "TRUE");
        response.sendRedirect(request.getContextPath());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
