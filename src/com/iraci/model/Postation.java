package com.iraci.model;

import java.util.List;

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
        this.number=id -(this.row*10)+1;
    }

    public Postation(int id, List<Double> prices) {
        this.id = id;
        this.row = (int) id/10;
        this.number=id -(this.row*10)+1;
        this.price = prices.get(this.row);
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

    public void setPrice(List<Double> prices) {
        this.price = prices.get(this.row);
    }

    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Postation){
            Postation pos2=(Postation) obj;
            if(this.id== pos2.getId()){
                return true;
            }else{
                return false;
            }
        }else{
            System.out.println("Errore nel tipo di confronto!");
            return false;
        }
    }

    @Override
    public String toString() {
        return "Postation{" +
                "id=" + id +
                ", row=" + row +
                ", number=" + number +
                ", price=" + price +
                '}';
    }

    public boolean isContained(List<Postation> occupied) {
        boolean result=false;
        for(int i=0; i<occupied.size(); i++){
            if(this.equals(occupied.get(i))){
                result=true;
                break;
            }
        }
        return result;
    }
}
