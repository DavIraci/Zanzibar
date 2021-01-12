package com.iraci.model;

/**
 * Questa classe è la rappresentazione di un prodotto
 * @author Davide Iraci
 */
public class Product {
    private String name;
    private int quantity;
    private String description;
    private double price;
    private int barcode;
    private String category;

    /**
     * Costruttore classe
     * @param name nome
     * @param quantity quantità
     * @param description descrizione
     * @param price prezzo
     * @param barcode codice prodotto
     * @param category categoria
     */
    public Product(String name, int quantity, String description, double price, int barcode, String category) {
        this.name = name;
        this.quantity=quantity;
        this.description = description;
        this.price = price;
        this.barcode = barcode;
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getBarcode() {
        return barcode;
    }

    public void setBarcode(int barcode) {
        this.barcode = barcode;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
