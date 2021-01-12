package com.iraci.model;

import java.time.LocalDate;

/**
 * Questa classe è la rappresentazione di un Utente
 * @author Davide Iraci
 */
public class User {
    private int idUtente;
    private String nome;
    private String cognome;
    private String cellulare;
    private String telefono;
    private String email;
    private LocalDate birthday;
    private String ruolo;

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getTelefono() {
        return telefono;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getRuolo() {
        return ruolo;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setRuolo(String ruolo) {
        this.ruolo = ruolo;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getEmail() {
        return email;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public int getIdUtente() {
        return idUtente;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getNome() {
        return nome;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getCognome() {
        return cognome;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public String getCellulare() {
        return cellulare;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setCellulare(String cellulare) {
        this.cellulare = cellulare;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public LocalDate getBirthday() {
        return birthday;
    }

    /**
     * Metodo per la manipolazione degli attributi dell'oggetto Utente
     */
    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    /**
     * Costruttore utente completo
     * @param idUtente id utente
     * @param nome nome
     * @param cognome cognome
     * @param email email
     * @param cellulare cellulare
     * @param telefono telefono
     * @param ruolo ruolo
     * @param birthday compleanno
     */
    public User(int idUtente, String nome, String cognome, String email, String cellulare, String telefono, String ruolo, LocalDate birthday) {
        this.email = email;
        this.cognome = cognome;
        this.nome=nome;
        this.telefono=telefono;
        this.idUtente = idUtente;
        this.cellulare = cellulare;
        this.ruolo = ruolo;
        this.birthday = birthday;
    }

    /**
     * Costruttore utente senza id
     * @param nome nome
     * @param cognome cognome
     * @param email email
     * @param cellulare cellulare
     * @param ruolo ruolo
     * @param birthday compleanno
     */
    public User(String nome, String cognome, String email, String cellulare, String ruolo, LocalDate birthday) {
        this.nome=nome;
        this.cognome=cognome;
        this.email = email;
        this.cognome = cognome;
        this.cellulare = cellulare;
        this.ruolo = ruolo;
        this.birthday = birthday;
    }

    /**
     * Override metodo equals, per verificare se due oggetti utente hanno gli stessi attributi
     * @param obj Utente
     * @return true o false
     */
    @Override
    public boolean equals(Object obj) {
        if(obj instanceof User){
            User user2=(User) obj;
            return this.email.equals(user2.getEmail()) && this.nome.equals(user2.getNome()) && this.cognome.equals(user2.getCognome()) && this.telefono.equals(user2.getTelefono()) && this.idUtente == user2.getIdUtente() && this.cellulare.equals(user2.getCellulare()) && this.birthday.equals(user2.getBirthday());
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
        return this.getNome() +" "+ this.getCognome() +" "+ this.getEmail() +" "+ this.getRuolo() +" "+ this.getIdUtente() +" "+ this.getCellulare() +" "+ this.getTelefono() +" "+ this.getBirthday();
    }
}
