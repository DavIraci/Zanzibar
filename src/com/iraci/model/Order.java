package com.iraci.model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Questa classe è la rappresentazione dell'ordine del servizio ristorazione
 * @author Davide Iraci
 */
public class Order {
    private int orderID;
    private LocalDateTime date;
    private char status;
    private boolean payed;
    private int userID;
    private String deliveryMethod;
    private final Map<Product, Detail> products;

    /**
     * Costruttore ordine senza prodotti
     * @param date data ordine
     * @param status stato
     * @param payed pagato
     * @param userID user ID
     * @param deliveryMethod metodo di consegna
     */
    public Order(int orderID, LocalDateTime date, char status, boolean payed, int userID, String deliveryMethod) {
        this.orderID = orderID;
        this.date = date;
        this.status = status;
        this.payed = payed;
        this.userID = userID;
        this.deliveryMethod = deliveryMethod;
        this.products = new LinkedHashMap<>();
    }

    /**
     * Costruttore ordine
     * @param date data ordine
     * @param status stato
     * @param payed pagato
     * @param userID user ID
     * @param deliveryMethod metodo di consegna
     * @param products Mappa prodotti
     */
    public Order(int orderID, LocalDateTime date, char status, boolean payed, int userID, String deliveryMethod, Map<Product, Detail> products) {
        this.orderID = orderID;
        this.date = date;
        this.status = status;
        this.payed = payed;
        this.userID = userID;
        this.deliveryMethod = deliveryMethod;
        this.products = products;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Ordine
     */
    public int getOrderID() {
        return orderID;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Ordine
     */
    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public LocalDateTime getDate() {
        return date;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public char getStatus() {
        return status;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public void setStatus(char status) {
        this.status = status;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public boolean isPayed() {
        return payed;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public void setPayed(boolean payed) {
        this.payed = payed;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public int getUserID() {
        return userID;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public String getDeliveryMethod() {
        return deliveryMethod;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public void setDeliveryMethod(String deliveryMethod) {
        this.deliveryMethod = deliveryMethod;
    }

    /**
    * Metodo per la manipolazione degli attributi dell'oggetto Ordine
    */
    public Map<Product, Detail> getProducts() {
        return products;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Ordine
     */
    public void addProduct(Product product, int quantity, String note){
        products.put(product, new Detail(quantity,note));
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderID=" + orderID +
                ", date=" + date +
                ", status=" + status +
                ", payed=" + payed +
                ", userID=" + userID +
                ", deliveryMethod='" + deliveryMethod + '\'' +
                ", products=" + products +
                '}';
    }

    /**
     * Ritorna la stringa contenente l'array dei prodotti, formattati per essere inviati tramite JSON
     * @return stringa JSON
     */
    public String productToAjaxString() {
        StringBuilder order = new StringBuilder("[");
        double tot = 0, quantity=0;
        for (Product p : products.keySet()) {
            order.append("{\"barcode\":").append(p.getBarcode()).append(",\"name\":\"").append(p.getName()).append("\",\"category\":\"").append(p.getCategory()).append("\",\"quantity\":").append(products.get(p).getQuantity()).append(", \"price\": ").append(p.getPrice()).append(",\"note\":\"").append(products.get(p).getNote()).append("\"}, ");
        }
        return order.substring(0, order.length() - 2)+"] ";
    }

    /**
     * Ritorna la stringa contenente l'array dei prodotti, formattati per essere inviati tramite JSON
     * @return stringa JSON
     * @throws JsonProcessingException JsonProcessingException
     */
    public String toAjax() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return "{\"orderID\": " +this.orderID+ ", \"date\": " + mapper.writeValueAsString(this.date) + ", \"status\": \"" + this.status + "\", \"payed\": \"" + this.payed + "\", \"userID\": " + this.userID + ", \"deliveryMethod\": \"" + this.deliveryMethod + "\", \"products\": "+ this.productToAjaxString() + "}";
    }
}