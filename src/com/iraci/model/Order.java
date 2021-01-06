package com.iraci.model;

public class Order {
    private int quantity;
    private String note;

    /**
     * Costruttore della classe senza parametri.
     */
    public Order() {
    }

    public Order(int quantity, String note ) {
        this.quantity = quantity;
        this.setNote(note);
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano un'Order.
     */
    public String getNote() {
        return note;
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano un'Order.
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Metodo set per modificare dall'esterno i dati che caratterizzano un'Order.
     */
    public void setNote(String note) {
        if(note!=null && note.length()>0) {
            this.note=note;
        }else {
            this.note=null;
        }
    }

    /**
     * Metodo set per modificare dall'esterno i dati che caratterizzano un'Order.
     */
    public void setQuantity(int quantity) {
        this.quantity=quantity;
    }
}
