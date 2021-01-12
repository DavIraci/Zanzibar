package com.iraci.utils;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;
import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.ByteArrayOutputStream;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * Questa classe contiene dei metodi statici utili per il funzionamento dell'applicativo
 * @author Davide Iraci
 */
public class Utils {
    /**
     * Verifica se i dati passati sono stati formattati bene attraverso le regex, nel caso di un errore restituisce il problema
     * @param nome nome
     * @param cognome cognome
     * @param email email
     * @param password password
     * @param confPassword confPassword
     * @param cellulare cellulare
     * @param telefono telefono
     * @param nascita nascita
     * @return risultato verifica o null se tutto funzionante
     */
    public static String verificaDatiForm(String nome, String cognome, String email, String password, String confPassword, String cellulare, String telefono, String nascita) {
        if( (nome == null || cognome == null || email == null || password == null || confPassword == null || cellulare == null || nascita == null) || (nome.replaceAll("\\s+","").contentEquals("") || cellulare.replaceAll("\\s+","").contentEquals("") || cognome.replaceAll("\\s+","").contentEquals("") ||
                email.replaceAll("\\s+","").contentEquals("") || password.replaceAll("\\s+","").contentEquals("") || nascita.replaceAll("\\s+","").contentEquals("")) )
            return "I campi sono tutti richiesti.";


        String regex = "^[A-Za-zèùàòé][a-zA-Z'èùàòé ]*$";
        if(!nome.matches(regex))
            return "Il nome non rispetta il formato richiesto.";

        if(!cognome.matches(regex))
            return "Il cognome non rispetta il formato richiesto.";

        regex = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+[.][a-zA-Z0-9-.]+$";
        if(!email.matches(regex))
            return "L'email non rispetta il formato richiesto.";

        regex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";
        if(!password.matches(regex))
            return "La password non rispetta il formato richiesto.";

        if(!password.equals(confPassword))
            return "Le password non corrispondono.";

        regex = "\\d{4}-\\d{2}-\\d{2}";
        if(!nascita.matches(regex))
            return "La data di nascita non rispetta il formato richiesto.";

        regex = "[0-9]{10}";
        if( (!telefono.replaceAll("\\s+","").contentEquals("") && !telefono.matches(regex)) || !cellulare.matches(regex))
            return "Il telefono non rispetta il formato richiesto.";

        return null;
    }

    /**
     * Verifica se una o più postazioni della lista risultano già prenotate per quella data e quello slot temporale
     * @param posts lista di postazioni
     * @param date data
     * @param period slot temporale
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean occupiedCheck(List<Postation> posts, LocalDate date, String period) throws SQLException {
        boolean occupied = false;
        List<Postation> post_occupied= DataBase.takeBooking(date, period);

        for (Postation post : posts) {
            if (post_occupied.contains(post)) {
                occupied = true;
                break;
            }
        }
        return occupied;
    }
}
