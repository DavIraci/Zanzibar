package com.iraci.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Cart;
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
import java.sql.SQLException;

@WebServlet(name = "manageCartServlet", urlPatterns={"/user/cartManage"})
public class manageCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            if(request.getParameter("Type")==null)
                response.sendError(400);
            else{
                String status=null, type=request.getParameter("Type");
                switch (type){
                    case "AddProduct": {
                        addProduct(request, response);
                        break;
                    }
                    case "CartSize": {
                        status=cartSize(request, response);
                        break;
                    }
                    case "CartManage": {
                        status=cartManage(request, response);
                        break;
                    }
                    case "UpdateQuantity": {
                        status=updateQuantity(request, response);
                        break;
                    }
                    default:{
                        System.out.println("Error!");
                    }
                }
                if(status!=null) {
                    PrintWriter pr = response.getWriter();
                    response.setContentType("application/json");
                    pr.write(status);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    private String updateQuantity(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null || cart.getSize()==0 || cart.searchProduct(barcode)==null) {
            return "{\"RESPONSE\" : \"Error\"}";
        }
        if(quantity==0){
            cart.removeProduct(barcode);
        }else {
            cart.setQuantity(barcode, quantity);
            quantity = cart.getQuantity(barcode);
        }
        if(quantity==-1)
            return "{\"RESPONSE\" : \"Error\"}";
        System.out.println(cart);
        return "{\"RESPONSE\" : \"Confirm\", \"QUANTITY\" : "+quantity+"}";

    }

    private String cartManage(HttpServletRequest request, HttpServletResponse response) throws JsonProcessingException {
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null || cart.getSize()==0) {
            return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+null+"}";
        }
        return "{\"RESPONSE\" : \"Confirm\", \"CART\" : "+cart.toajaxString()+"}";
    }

    protected String cartSize(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        int quantity;
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null) {
            quantity=0;
        }else{
            quantity= cart.getSize();
        }
        return "{\"RESPONSE\" : \"Confirm\", \"SIZE\" : "+quantity+"}";
    }

    protected void addProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        if(request.getParameter("Barcode")==null || request.getParameter("Quantity")==null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        String note=request.getParameter("Description");
        int barcode=Integer.parseInt(request.getParameter("Barcode")), quantity=Integer.parseInt(request.getParameter("Quantity"));

        Product product;
        Cart cart = (Cart) request.getSession().getAttribute("CART");
        // Se il carrello è vuoto crea un nuovo oggetto carrello.
        if(cart == null) {
            cart = new Cart();
        }
        /* Se il prodotto non è ancora presente all'interno del carrello richiede al database i dati del prodotto
         * selezionato.
         */
        if((product=cart.searchProduct(barcode))==null) {
            product = DataBase.getProduct(barcode);
            if(product == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        /* Aggiunge il prodotto al carrello (caso in cui non era presente) o ne incrementa la quantità
         * (caso in cui era già nel carrello del cliente).
         */
        cart.addProduct(product, quantity, note);
        System.out.println(cart);
        request.getSession().setAttribute("CART", cart);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/cart.jsp");
        dispatcher.forward(request, response);
    }
}
