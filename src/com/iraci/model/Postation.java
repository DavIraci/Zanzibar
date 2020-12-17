package com.iraci.model;

public class Postation {
    private int id;
    private int row;
    private int number;
    private double price;

    public Postation(int id, double price) {
        this.id = id;
        this.row = (int) id/10;
        this.number=id -(this.row*10)+1;
        this.price=price;
    }

    public Postation(int id) {
        this.id = id;
        this.row = (int) id/10;
        this.number=id -this.row;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRow() {
        return row;
    }

    public void setRow(int row) {
        this.row = row;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
