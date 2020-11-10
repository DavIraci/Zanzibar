package com.iraci.utils;

public class Utils {


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
}
