package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

/**
 * Questa classe gestisce la creazione di un nuovo account User da parte di un utente
 * @author Davide Iraci
 */
@WebServlet(name = "signinServlet", urlPatterns={"/signin"})
public class signinServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Verifica che l'utente non abbia effettuato l'accesso
        if(request.getUserPrincipal() == null)
            request.getSession().setAttribute("SignIn","");
        response.sendRedirect(request.getContextPath());
    }

    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Verifica che l'utente non abbia effettuato l'accesso
        if(request.getUserPrincipal() != null)
            response.sendRedirect(request.getContextPath());
        else {
            try {
                // Prende i dati dal form compilato dall'utente
                String nome, cognome, email, password, confPassword, cellulare, telefono, errore;
                nome = request.getParameter("username");
                cognome = request.getParameter("surname");
                email = request.getParameter("email").toLowerCase();
                password = request.getParameter("password");
                confPassword = request.getParameter("passwordrep");
                cellulare = request.getParameter("mobile");
                telefono = request.getParameter("telephone");
                LocalDate datanascita = LocalDate.parse(request.getParameter("birth"));

                // Prepara il necessario per la risposta JSON
                PrintWriter pr = response.getWriter();
                response.setContentType("application/json");
                String status;

                // Verifica se i dati sono nella forma corretta
                errore = Utils.verificaDatiForm(nome, cognome, email, password, confPassword, cellulare, telefono, datanascita.toString());

                // Se sono stati inseriti dati in modo sbagliato, ritorna il tipo di errore
                if (errore != null) {
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Data insert error\",\"MESSAGE\" : \"" + errore + "\"}";
                }else {
                    if (DataBase.checkAlreadyReg(email)) {
                        status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Already Registered\",\"MESSAGE\" : \"L'indirizzo email inserito è già associato ad un altro account\"}";
                    }else {
                        // Registra l'utente e invia la mail di benvenuto
                        DataBase.userSignIn(nome, cognome, email, cellulare, telefono, datanascita, password, "User");

                        String messaggio = "<p><h1>Il Lido Zanzibar ti d&agrave; il benvenuto!</h1> <p>Ciao " + nome + " " + cognome + ", <br>"
                                + "ti comunichiamo che la registrazione del tuo account &egrave; avvenuta con successo, "
                                + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> visita il nostro sito</a> per usufruire dei nostri servizi."
                                + "<br>Ti auguriamo una buona permanenza nel nostro lido e speriamo di vederti presto! <br><br>"
                                + "Lo staff del lido</p>";
                        Mailer mailer = new Mailer(email, "Lido Zanzibar - Benvenuto", messaggio);
                        Thread thread = new Thread(mailer);
                        thread.start();

                        status = "{\"RESPONSE\" : \"Confirm\", \"TYPE\" : \"SignIn\",\"MESSAGE\" : \"Registrazione completata con successo!\"}";
                    }
                }

                pr.write(status);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(400);
            }
        }
    }
}
