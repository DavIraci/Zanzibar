package com.iraci.model;

import javax.ejb.Local;
import java.time.LocalDate;

public class Invoice {
    private int bookID;
    private int orderID;
    private int invoiceID;
    private String name;
    private String surname;
    private String email;
    private String fiscalcode;
    private String address;
    private String region;
    private String province;
    private String city;
    private String CAP;
    private String method;
    private LocalDate booked_date;
    private LocalDate date;
    private Book book;
    private Cart order;

    public Invoice(int bookID, int invoiceID, String name, String surname, String email, String fiscalcode, String address, String region, String province, String city, String CAP, String method, LocalDate booked_date, LocalDate date, Book book) {
        this.bookID = bookID;
        this.invoiceID = invoiceID;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.fiscalcode = fiscalcode;
        this.address = address;
        this.region = region;
        this.province = province;
        this.city = city;
        this.CAP = CAP;
        this.method = method;
        this.booked_date = booked_date;
        this.book = book;
        this.date = date;
        this.order = null;
    }

    public Invoice(int orderID, int invoiceID, String name, String surname, String email, String fiscalcode, String address, String region, String province, String city, String CAP, String method, LocalDate date, Cart order) {
        this.orderID = orderID;
        this.invoiceID = invoiceID;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.fiscalcode = fiscalcode;
        this.address = address;
        this.region = region;
        this.province = province;
        this.city = city;
        this.CAP = CAP;
        this.method = method;
        this.order = order;
        this.date = date;
        this.book = null;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Cart getOrder() {
        return order;
    }

    public void setOrder(Cart order) {
        this.order = order;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Invoice{" +
                "bookID=" + bookID +
                ", invoiceID=" + invoiceID +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", email='" + email + '\'' +
                ", fiscalcode='" + fiscalcode + '\'' +
                ", address='" + address + '\'' +
                ", region='" + region + '\'' +
                ", province='" + province + '\'' +
                ", city='" + city + '\'' +
                ", CAP='" + CAP + '\'' +
                ", method='" + method + '\'' +
                ", booked_date=" + booked_date +
                ", date=" + date +
                ", book=" + book +
                '}';
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(int invoiceID) {
        this.invoiceID = invoiceID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFiscalcode() {
        return fiscalcode;
    }

    public void setFiscalcode(String fiscalcode) {
        this.fiscalcode = fiscalcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCAP() {
        return CAP;
    }

    public void setCAP(String CAP) {
        this.CAP = CAP;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public LocalDate getBooked_date() {
        return booked_date;
    }

    public void setBooked_date(LocalDate booked_date) {
        this.booked_date = booked_date;
    }
}
