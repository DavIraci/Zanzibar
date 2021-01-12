package com.iraci.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Questa classe è la rappresentazione dell'oggetto Prenotazione
 * @author Davide Iraci
 */
public class Book {
    private String period;
    private LocalDate date;
    private LocalDate booked_date;
    private int user_id;
    private int book_id;
    private double price;
    private boolean canceled;
    private LocalDateTime checkin;
    private LocalDateTime checkout;
    private int extra_chair;
    private List<Postation> postations=new ArrayList<>();

    /**
     * Effettua la concatenazione string degli attributi
     * @return stringa
     */
    @Override
    public String toString() {
        return "Book{" +
                "period='" + period + '\'' +
                ", date=" + date +
                ", booked_date=" + booked_date +
                ", user_id=" + user_id +
                ", book_id=" + book_id +
                ", price=" + price +
                ", canceled=" + canceled +
                ", checkin=" + checkin +
                ", checkout=" + checkout +
                ", extra_chair=" + extra_chair +
                ", postations=" + postations.toString() +
                '}';
    }

    /**
     * Costruttore
     * @param period period
     * @param user_id user_id
     * @param book_id book_id
     * @param price price
     * @param canceled canceled
     * @param checkin checkin
     * @param checkout checkout
     * @param extra_chair extra_chair
     * @param date date
     * @param booked_date booked_date
     */
    public Book(String period, int user_id, int book_id, double price, boolean canceled, LocalDateTime checkin, LocalDateTime checkout, int extra_chair, LocalDate date, LocalDate booked_date) {
        this.period = period;
        this.user_id = user_id;
        this.book_id = book_id;
        this.price = price;
        this.canceled = canceled;
        this.checkin = checkin;
        this.checkout = checkout;
        this.extra_chair = extra_chair;
        this.date = date;
        this.booked_date = booked_date;
    }

    /**
     * Costruttore
     * @param period period
     * @param user_id user_id
     * @param price price
     * @param canceled canceled
     * @param extra_chair extra_chair
     * @param postations postations
     * @param date date
     */
    public Book(String period, int user_id, double price, boolean canceled, int extra_chair, List<Postation> postations, LocalDate date) {
        this.period = period;
        this.user_id = user_id;
        this.price = price;
        this.canceled = canceled;
        this.extra_chair = extra_chair;
        this.postations = postations;
        this.date = date;
    }

    public LocalDate getDate() { return date; }

    public void setDate(LocalDate date) { this.date = date; }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public boolean isCanceled() {
        return canceled;
    }

    public void setCanceled(boolean canceled) {
        this.canceled = canceled;
    }

    public LocalDateTime getCheckin() {
        return checkin;
    }

    public void setCheckin(LocalDateTime checkin) {
        this.checkin = checkin;
    }

    public LocalDateTime getCheckout() {
        return checkout;
    }

    public void setCheckout(LocalDateTime checkout) {
        this.checkout = checkout;
    }

    public int getExtra_chair() {
        return extra_chair;
    }

    public void setExtra_chair(int extra_chair) {
        this.extra_chair = extra_chair;
    }

    public List<Postation> getPostations() {
        return postations;
    }

    public void setPostations(List<Postation> postations) {
        this.postations = postations;
    }

    public void addPostation(Postation postation){ this.postations.add(postation); }

    /**
     * Imposta il prezzo di ciascuna postazione
     * @param prices lista dei prezzi
     */
    public void setPrices(List<Double> prices){
        for (Postation postation : this.postations) {
            postation.setPrice(prices);
        }
    }
}
