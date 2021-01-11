package com.iraci.servlet.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Product;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Questa classe gestisce la visualizzazione dei prodotti in vendita al bar del lido
 * @author Davide Iraci
 */
@WebServlet(name = "productListServlet", urlPatterns={"/productList"})
public class productListServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            String status, category=request.getParameter("Category");

            // Carica i prodotti dal DB in base alla categoria scelta e li ritorna tramite JSON, verificando prima che non siano vuoti
            List<Product> products;
            if((products=DataBase.getProducts(category)).isEmpty()){
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile reperire i prodotti, riprovare!\"}";
            }else { //TakeBook
                ObjectMapper mapper = new ObjectMapper();
                status = "{\"RESPONSE\" : \"Confirm\", \"PRODUCTS\" : " + mapper.writeValueAsString(products) + " }";
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
