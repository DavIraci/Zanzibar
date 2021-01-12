package com.iraci.model;

import java.util.List;

/**
 * Questa classe è la rappresentazione di una Postazione del lido
 * @author Davide Iraci
 */
public class Postation {
    private int id;
    private int row;
    private int number;
    private double price;

    /**
     * Costruttore con i prezzi
     * @param id id
     * @param price prezzi
     */
    public Postation(int id, double price) {
        this(id);
        this.price=price;
    }

    /**
     * Costruttore con i prezzi ricavati dalla lista di prezzi
     * @param id id
     * @param prices lista prezzi
     */
    public Postation(int id, List<Double> prices) {
        this(id);
        this.price = prices.get(this.row);
    }

    /**
     * Costruttore senza i prezzi
     * @param id id
     */
    public Postation(int id) {
        this.id = id;
        this.row = id/10;
        this.number=id -(this.row*10)+1;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public int getId() {
        return id;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public int getRow() {
        return row;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public void setRow(int row) {
        this.row = row;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public int getNumber() {
        return number;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public void setNumber(int number) {
        this.number = number;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public double getPrice() {
        return price;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public void setPrice(double price) {
        this.price = price;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Postazione
     */
    public void setPrice(List<Double> prices) {
        this.price = prices.get(this.row);
    }

    /**
     * Override metodo equals, per verificare se le postazioni hanno lo stesso id e rappresentano la stesssa
     * @param obj Postazione
     * @return true o false
     */
    @Override
    public boolean equals(Object obj) {
        if(obj instanceof Postation){
            Postation pos2=(Postation) obj;
            return this.id == pos2.getId();
        }else{
            System.out.println("Errore nel tipo di confronto!");
            return false;
        }
    }

    /**
     * Effettua la concatenazione string degli attributi
     * @return stringa
     */
    @Override
    public String toString() {
        return "Postation{" +
                "id=" + id +
                ", row=" + row +
                ", number=" + number +
                ", price=" + price +
                '}';
    }

    /**
     * Verifica se la postazione è contenuta nella lista passata come parametro
     * @param occupied lista postazioni
     * @return true o false
     */
    public boolean isContained(List<Postation> occupied) {
        boolean result=false;
        for (Postation postation : occupied) {
            if (this.equals(postation)) {
                result = true;
                break;
            }
        }
        return result;
    }
}
