package com.iraci.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Book;
import com.iraci.model.Product;
import com.iraci.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "productListServlet", urlPatterns={"/productList"})
public class productListServlet extends HttpServlet {
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            ObjectMapper mapper = new ObjectMapper();
            String status, category=request.getParameter("Category");
            List<Product> products;

            System.out.println(category);

            if((products=DataBase.getProducts(category)).isEmpty()){
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile reperire i prodotti, riprovare!\"}";
            }else { //TakeBook
                status = "{\"RESPONSE\" : \"Confirm\", \"PRODUCTS\" : " + mapper.writeValueAsString(products) + " }";
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/manageBook.jsp");
        dispatcher.forward(request, response);
    }
}
