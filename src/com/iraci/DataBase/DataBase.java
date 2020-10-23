package com.iraci.DataBase;

import com.iraci.model.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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

    public static User takeUser(String email) throws SQLException{
        String query1 = "SELECT U.id_User, U.name, U.surname, U.role, U.email, U.telephone, u.birthday FROM iraci.user AS U WHERE U.email=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {

            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                return new User(result.getInt("id_User"), result.getString("name"), result.getString("surname"), result.getString("email"), result.getString("telephone"), result.getString("role"), LocalDate.parse(result.getDate("birthday").toString()));
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
     */
    public static void userSignIn(String nome, String cognome, String email, String cellulare, LocalDate datanascita, String password) throws SQLException{
        String query1 = "INSERT INTO iraci.user (name, surname, email, password, telephone, birthday, role) " +
                "VALUES (?, ?, ?, MD5(?), ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {

            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setString(3, email);
            statement.setString(4, password);
            statement.setString(5, cellulare);
            statement.setDate(6, Date.valueOf(datanascita));
            statement.setString(7, "User");
            statement.executeUpdate();
        }

    }

    /**
     * Ritorna l'IDUtente a partire dall'indirizzo email
     * @param email
     */
    public static boolean checkAlreadyReg(String email) throws SQLException{
        String query1 = "SELECT U.email FROM iraci.user AS U WHERE u.email=?";
        boolean res=false;
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1)) {
            statement.setString(1, email);
            ResultSet result = statement.executeQuery();
            if (result.next()) {
                res = true;
            }
            result.close();
            return res;
        }
    }
}
