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

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public String getName() {
        return name;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public String getDescription() {
        return description;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public double getPrice() {
        return price;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public int getBarcode() {
        return barcode;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setBarcode(int barcode) {
        this.barcode = barcode;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public String getCategory() {
        return category;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Prodotto
     */
    public void setCategory(String category) {
        this.category = category;
    }
}
