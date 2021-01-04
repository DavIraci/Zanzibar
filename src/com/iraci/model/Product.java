package com.iraci.model;

public class Product {
    private String name;
    private int quantity;
    private String description;
    private double price;
    private int barcode;
    private String category;

    public Product(String name, int quantity, String description, double price, int barcode, String category) {
        this.name = name;
        //this.quantity = quantity==-1?null:quantity;
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
