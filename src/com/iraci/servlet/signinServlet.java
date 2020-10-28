package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.utils.Mailer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Questa classe gestisce la creazione di un nuovo account User da parte di un utente
 * @author Davide Iraci
 */
@WebServlet(name = "signinServlet", urlPatterns={"/signin"})
public class signinServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getUserPrincipal() == null)
            request.getSession().setAttribute("SignIn","");
        response.sendRedirect(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getUserPrincipal() != null)
            response.sendRedirect(request.getContextPath());
        else {
            try {
                String nome, cognome, email, password, confPassword, cellulare, telefono, nascita, errore;
                nome = request.getParameter("username");
                cognome = request.getParameter("surname");
                email = request.getParameter("email");
                password = request.getParameter("password");
                confPassword = request.getParameter("passwordrep");
                cellulare = request.getParameter("mobile");
                telefono = request.getParameter("telephone");
                nascita = request.getParameter("birth");
                LocalDate datanascita = LocalDate.parse(nascita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

                errore = verificaDatiRegistrazione(nome, cognome, email, password, confPassword, cellulare, telefono, nascita);

                if (errore != null) { //sono stati inseriti dati scorretti
                    request.getSession().setAttribute("name", nome);
                    request.getSession().setAttribute("surname", cognome);
                    request.getSession().setAttribute("email", email);
                    request.getSession().setAttribute("mobile", cellulare);
                    request.getSession().setAttribute("telephone", telefono);
                    request.getSession().setAttribute("birth", nascita);
                    request.getSession().setAttribute("tel", request.getParameter("tel"));
                    request.getSession().setAttribute("SignInError", errore);
                    response.sendRedirect(request.getContextPath());
                    return;
                }

                if (DataBase.checkAlreadyReg(email)) { // l'indirizzo email già esiste
                    request.getSession().setAttribute("name", nome);
                    request.getSession().setAttribute("surname", cognome);
                    request.getSession().setAttribute("email", email);
                    request.getSession().setAttribute("mobile", cellulare);
                    request.getSession().setAttribute("telephone", telefono);
                    request.getSession().setAttribute("birth", nascita);
                    request.getSession().setAttribute("SignInError", "L'indirizzo email inserito è già associato ad un altro account");
                    response.sendRedirect(request.getContextPath());
                    return;
                }
                DataBase.userSignIn(nome, cognome, email, cellulare, telefono, datanascita, password);

                String messaggio = "<p><h1>Il Lido Zanzibar ti d&agrave; il benvenuto!</h1> <p>Ciao " + nome + " " + cognome + ", <br>"
                        + "ti comunichiamo che la registrazione del tuo account &egrave; avvenuta con successo, "
                        + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> visita il nostro sito</a> per usufruire dei nostri servizi."
                        + "<br>Ti auguriamo una buona permanenza nel nostro lido e speriamo di vederti presto! <br><br>"
                        + "Lo staff del lido</p>";
                Mailer mailer = new Mailer(email, "Lido Zanzibar - Benvenuto", messaggio);
                Thread thread = new Thread(mailer);
                thread.start();


                request.getSession().setAttribute("SignIn", "Registrazione completata con successo");
                response.sendRedirect(request.getContextPath());

            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(400);
            }
        }
    }

    public static String verificaDatiRegistrazione(String nome, String cognome, String email, String password, String confPassword, String cellulare, String telefono, String nascita) {

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
