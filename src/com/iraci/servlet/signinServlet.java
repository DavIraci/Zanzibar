package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Notify;
import com.iraci.model.User;
import com.iraci.utils.Mailer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "signinServlet", urlPatterns={"/signin"})
public class signinServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nome, cognome, email, password, confPassword, cellulare, nascita, errore;
            nome = request.getParameter("j_username");
            cognome = request.getParameter("j_surname");
            email = request.getParameter("j_email");
            password = request.getParameter("j_password");
            confPassword = request.getParameter("j_passwordrep");
            cellulare = request.getParameter("j_phone");
            nascita = request.getParameter("j_birth");
            LocalDate datanascita = LocalDate.parse(nascita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            errore = verificaDatiRegistrazione(nome, cognome, email, password, confPassword, cellulare, nascita);

            if(errore!=null) { //sono stati inseriti dati scorretti
                request.getSession().setAttribute("SignInError", errore);
                response.sendRedirect(request.getContextPath());
                return;
            }

            if(DataBase.checkAlreadyReg(email)) { // l'indirizzo email già esiste
                request.getSession().setAttribute("SignInError","L'indirizzo email inserito è già associato ad un altro account");
                response.sendRedirect(request.getContextPath()+"/Signin");
                return;
            }
            DataBase.userSignIn(nome, cognome, email, cellulare, datanascita, password);

            String messaggio = "<h1>Il Lido Zanzibar ti d&agrave; il benvenuto!</h1> <p>Ciao " + nome + " " + cognome + ", <br>"
                    + "ti comunichiamo che la registrazione del tuo account &egrave; avvenuta con successo, "
                    + "<a href='"+ Mailer.getAddress() + request.getContextPath() + "'> visita il nostro sito</a> per usufruire dei nostri servizi."
                    + "<br>Ti auguriamo una buona permanenza nel nostro lido e speriamo di vederti presto! <br><br>"
                    + "Lo staff del lido</p>";
            Mailer mailer = new Mailer( email, "Lido Zanzibar - Benvenuto", messaggio);
            Thread thread = new Thread(mailer);
            thread.start();


            request.getSession().setAttribute("SignIn","Registrazione completata con successo");
            response.sendRedirect(request.getContextPath());

        }catch(Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    public static String verificaDatiRegistrazione(String nome, String cognome, String email, String password, String confPassword, String cellulare, String nascita) {

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

        return null;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("SignIn","Effettua la registrazione");
        response.sendRedirect(request.getContextPath());
    }
}
