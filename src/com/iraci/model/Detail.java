package com.iraci.model;

/**
 * Questa classe è la rappresentazione dei dettagli di un prodotto dell'ordine del servizio ristorazione
 * @author Davide Iraci
 */
public class Detail {
    private int quantity;
    private String note;

    /**
     * Costruttore della classe senza parametri.
     */
    public Detail() {
    }

    public Detail(int quantity, String note ) {
        this.quantity = quantity;
        this.setNote(note);
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano i dettagli di un prodotto dell'ordine.
     */
    public String getNote() {
        return note;
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano i dettagli di un prodotto dell'ordine.
     */
    public int getQuantity() {
        return quantity;
    }

    /**
     * Metodo set per modificare dall'esterno i dati che caratterizzano i dettagli di un prodotto dell'ordine.
     */
    public void setNote(String note) {
        if(note!=null && note.length()>0) {
            this.note=note;
        }else {
            this.note=null;
        }
    }

    /**
     * Metodo set per modificare dall'esterno i dati che caratterizzano i dettagli di un prodotto dell'ordine.
     */
    public void setQuantity(int quantity) {
        this.quantity=quantity;
    }
}
