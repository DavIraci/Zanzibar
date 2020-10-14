package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "loginServlet", urlPatterns={"/login"})
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username=request.getParameter("user");
        String pass=request.getParameter("password");
        RequestDispatcher dispatcher = request.getRequestDispatcher("");

        if(username==null || pass==null) {
            request.setAttribute("ErrorMessage", "Operazione non concessa!");
        }else{
            User user= DataBase.login(username, pass);
            if(user == null){
                request.setAttribute("ErrorMessage", "Username o password errati!");
            }else{
                request.getSession().setAttribute("USER", user);
            }
        }
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
