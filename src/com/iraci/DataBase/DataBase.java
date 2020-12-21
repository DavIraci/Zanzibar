package com.iraci.DataBase;

import com.iraci.model.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.time.LocalDate;
import java.security.SecureRandom;
import java.util.*;
import javax.sql.DataSource;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Questa classe modella la connessione con il database. Gestisce tutti i metodi che
 * interagiscono con il database, consentendo di effettuare interrogazioni per inserire,
 * cancellare, aggiornare o ritornare i dati delle tabelle.
 * @author Davide Iraci
 */
public class DataBase {
    /**
     * Dichiarazione delle variabili necessarie a gestire la connessione con il database e
     * l'esecuzione delle query.
     */
    private static Context context = null;
    private static DataSource dataSource = null;


    /**
     * Inizializza il context ed il data source per la comunicazione con il database.
     */
    static {
        try {
            context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/iraci");
        }
        catch (NamingException e) {
            e.printStackTrace();
        }
    }

    /**
     *
     * @param email
     * @return
     * @throws SQLException
     */
    public static User takeUser(String email) throws SQLException{
        String query1 = "SELECT U.id_User, U.name, U.surname, U.role, U.email, U.telephone, U.mobile, U.birthday FROM iraci.user AS U WHERE U.email=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {

            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                return new User(result.getInt("id_User"), result.getString("name"), result.getString("surname"), result.getString("email"), result.getString("mobile"), result.getString("telephone"), result.getString("role"), LocalDate.parse(result.getDate("birthday").toString()));
            } else {
                return null;
            }
        }

    }

    /**
     * Inserisce all'interno del database i dati del cliente che effettua la registrazione
     * @param nome
     * @param cognome
     * @param email
     * @param cellulare
     * @param datanascita
     * @param password
     * @throws SQLException
     */
    public static void userSignIn(String nome, String cognome, String email, String cellulare, String telefono, LocalDate datanascita, String password) throws SQLException{
        String query1 = "INSERT INTO iraci.user (name, surname, email, password, mobile, telephone, birthday, role) " +
                "VALUES (?, ?, ?, SHA2(?, 256), ?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {

            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setString(3, email);
            statement.setString(4, password);
            statement.setString(5, cellulare);
            statement.setString(6, telefono);
            statement.setDate(7, Date.valueOf(datanascita));
            statement.setString(8, "User");
            statement.executeUpdate();
        }
    }

    /**
     * Ritorna TRUE se esiste un account con la stessa email, viceversa FALSE
     * @param email
     * @return
     * @throws SQLException
     */
    public static boolean checkAlreadyReg(String email) throws SQLException{
        String query = "SELECT U.email FROM iraci.user AS U WHERE u.email=?";
        boolean res=false;
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                res = true;
            }
            result.close();
            return res;
        }
    }

    /**
     * Metodo che genera una stringa di 10 caratteri con almeno un carattare minuscolo, uno maiuscolo e un numero
     * @param length
     * @return
     */
    public static String generateRandomPassword(int length) {
        String character = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        String password="";
        Random random = new Random();
        String regex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";

        while (!password.matches(regex)){
            password = "";
            for (int i = 0; i < length; i++) {
                password+=character.charAt(random.nextInt(character.length()));
            }
        }
        return password;
    }

    /**
     * Ritorna la stringa contenente la nuova password o ritorna null se non trova corrispondenza
     * @param email
     * @return
     * @throws SQLException
     */
    public static String resetPassword(String email) throws SQLException{
        String newpwd=generateRandomPassword(8);
        String query = "UPDATE iraci.user SET password=SHA2(?, 256) WHERE email=? ";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, newpwd);
            statement.setString(2, email);
            int result = statement.executeUpdate();
            if (result > 0) {
                return  newpwd;
            }else{
                return null;
            }
        }

    }

    public static boolean checkPassword(String email, String checkPassword) throws SQLException {
        String query = "SELECT U.email FROM iraci.user AS U WHERE u.email=? AND u.password=?";
        boolean res=false;
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            statement.setString(2, checkPassword);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                res = true;
            }
            result.close();
            return res;
        }
    }

    public static boolean alterDate(String nome, String cognome, String email, String cellulare, String telefono, LocalDate datanascita, String password, User user) throws SQLException{
        String query = "UPDATE iraci.user SET name=?, surname=?, birthday=?, telephone=?, email=?, password=SHA2(?, 256), mobile=?  WHERE email=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setDate(3, Date.valueOf(datanascita));
            statement.setString(4, telefono);
            statement.setString(5, email);
            statement.setString(6, password);
            statement.setString(7, cellulare);
            statement.setString(8, user.getEmail());
            int result = statement.executeUpdate();
            if (result > 0) {
                return true;
            }else{
                return false;
            }
        }
    }

    public static List<Double> takePrice(LocalDate date, String period) throws SQLException {
        List<Double> price = new ArrayList<>();
        String season;
        if(date.getMonthValue() == 8){
            season="highSeason";
        }else if(date.getMonthValue() == 7){
            season="midSeason";
        }else {
            season="lowSeason";
        }
        int half=period.equals("Full")?1:2;
        String query = "SELECT * FROM iraci.price ORDER BY price.row ASC";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                price.add( rs.getDouble(season)/( (rs.getInt("row")==0)?1:half ) );
            }
            rs.close();

            return price;
        }
    }

    public static List<Postation> takeBooking(LocalDate date, String period) throws SQLException {
        List<Postation> postazioni = new ArrayList<>();
        List<Double> prices = takePrice(date, period);
        String query = "SELECT UmbrellaStation_id_UmbrellaStation FROM iraci.book_has_umbrellastation JOIN iraci.book ON book.id_book=book_has_umbrellastation.Book_id_Book WHERE book.date=? AND book.canceled=0 AND (book.bookingPeriod='Full' OR book.bookingPeriod=?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDate(1, Date.valueOf(date));
            statement.setString(2, period);
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                postazioni.add(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation"), prices));
            }
            rs.close();

            return postazioni;
        }
    }

    public static int placeBook(List<Postation> postations, LocalDate date, String period, double price, int user_id, int extra_chair )throws SQLException {
        String query1 = "INSERT INTO iraci.book (date, bookingPeriod, cost, User_id_User) " +
                "VALUES (?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS)) {
            statement.setDate(1, Date.valueOf(date));
            statement.setString(2, period);
            statement.setDouble(3, price);
            statement.setInt(4, user_id);
            statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            int id = -1;
            if (rs.next()) {
                id = rs.getInt(1);
                System.out.println(id);
                rs.close();
                for (int i = 0; i < postations.size(); i++) {
                    String query2 = "INSERT INTO iraci.book_has_umbrellastation (Book_id_Book, UmbrellaStation_id_UmbrellaStation, extraChair) values (?, ?, ?)";
                    try (PreparedStatement statement2 = connection.prepareStatement(query2)) {
                        statement2.setInt(1, id);
                        statement2.setInt(2, postations.get(i).getId());
                        statement2.setInt(3, extra_chair > 2 ? 2 : extra_chair);
                        extra_chair -= extra_chair > 2 ? 2 : extra_chair;
                        if (statement2.executeUpdate() == 0) {
                            return -1;
                        }
                    }
                }
                return id;
            }
        }
        return -1;
    }

    public static void insertInvoid(int id, String name, String surname, String email, String fiscal, String address, String region, String province, String city, String cap, String method, String cardno) throws SQLException{
        String query1 = "INSERT INTO iraci.invoice (id_book, name, surname, email, fiscalcode, address, region, province, city, CAP, method, cardno) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.setString(3, surname);
            statement.setString(4, email);
            statement.setString(5, fiscal);
            statement.setString(6, address);
            statement.setString(7, region);
            statement.setString(8, province);
            statement.setString(9, city);
            statement.setString(10, cap);
            statement.setString(11, method);
            statement.setString(12, cardno == null ? "" : cardno);
            statement.executeUpdate();
        }
    }
}
