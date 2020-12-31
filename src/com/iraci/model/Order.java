package com.iraci.model;

import com.iraci.model.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Order {
    private String period;
    private LocalDate date;
    private LocalDate booked_date;
    private int user_id;
    private int book_id;
    private double price;
    private boolean canceled;
    private LocalDate checkin;
    private LocalDate checkout;
    private int extra_chair;
    private List<Postation> postations=new ArrayList<>();

    @Override
    public String toString() {
        return "Order{" +
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

    public Order(String period, int user_id, int book_id, double price, boolean canceled, LocalDate checkin, LocalDate checkout, int extra_chair, LocalDate date, LocalDate booked_date) {
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

    public Order(String period, int user_id, double price, boolean canceled, int extra_chair, List<Postation> postations, LocalDate date) {
        this.period = period;
        this.user_id = user_id;
        this.price = price;
        this.canceled = canceled;
        this.extra_chair = extra_chair;
        this.postations = postations;
        this.date = date;
    }

    public Order() {
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

    public LocalDate getCheckin() {
        return checkin;
    }

    public void setCheckin(LocalDate checkin) {
        this.checkin = checkin;
    }

    public LocalDate getCheckout() {
        return checkout;
    }

    public void setCheckout(LocalDate checkout) {
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

    public void setPrices(List<Double> prices){
        for(int i=0; i<this.postations.size(); i++){
            postations.get(i).setPrice(prices);
        }
    }
}
