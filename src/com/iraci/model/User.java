package com.iraci.model;

public class User {
    private int idUtente;
    private String nome;
    private String cognome;
    private String cellulare;
    private String email;

    public String getRuolo() {
        return ruolo;
    }

    public void setRuolo(String ruolo) {
        this.ruolo = ruolo;
    }

    private String ruolo;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getCellulare() {
        return cellulare;
    }

    public void setCellulare(String cellulare) {
        this.cellulare = cellulare;
    }

    public User(int idUtente, String nome, String cognome, String email, String cellulare, String ruolo) {
        this.email = email;
        this.cognome = cognome;
        this.idUtente = idUtente;
        this.cellulare = cellulare;
        this.ruolo = ruolo;
    }
}
