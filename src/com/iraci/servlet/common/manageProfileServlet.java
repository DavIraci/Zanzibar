package com.iraci.servlet.common;

import com.iraci.DataBase.DataBase;
import com.iraci.model.User;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Questa classe gestisce le richieste di modifica dati relative all'account che ha effettuato l'accesso.
 * @author Davide Iraci
 */
@WebServlet(name = "manageProfileServlet", urlPatterns={"/common/manageprofile"})
public class manageProfileServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Riceve i dati dal form tramite AJAX
            String nome, cognome, email, password, confPassword, checkPassword, cellulare, telefono, nascita, errore;
            nome = request.getParameter("username");
            cognome = request.getParameter("surname");
            email = request.getParameter("email").toLowerCase();
            password = request.getParameter("password");
            confPassword = request.getParameter("passwordrep");
            checkPassword = request.getParameter("passwordcheck");
            cellulare = request.getParameter("mobile");
            telefono = request.getParameter("telephone");
            nascita = request.getParameter("birth");
            LocalDate datanascita = LocalDate.parse(nascita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            boolean changePass=true;

            // Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            String status;

            // Verifica se deve essere cambiata la password
            if(password.isEmpty() || confPassword.isEmpty()) {
                changePass=false;
                password = checkPassword;
                confPassword = password;
            }

            // Verifica se i dati sono nella forma corretta
            errore = Utils.verificaDatiForm(nome, cognome, email, password, confPassword, cellulare, telefono, nascita);

            if (errore != null) {
                // Se sono stati inseriti dati in modo sbagliato, ritorna il tipo di errore
                status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Data insert error\",\"MESSAGE\" : \"" + errore + "\"}";

            }else {
                User oldDate = (User) request.getSession().getAttribute("USER");
                User alterDate = new User(oldDate.getIdUtente(), nome, cognome, email, cellulare, telefono, oldDate.getRuolo(), datanascita);

                if (oldDate.equals(alterDate) && !changePass) {
                    // Controlla se non è stato modificato niente rispetto a prima
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Same data\", \"MESSAGE\" : \"I valori inseriti combaciano con quelli attualmente presenti\"}";

                }else if (DataBase.checkPassword(email, checkPassword)) {
                    // Verifica che la password per autorizzare la modifica è sbaglaita
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Incorrect password\",\"MESSAGE\" : \"La password inserita è sbagliata\"}";

                }else if (DataBase.alterDate(nome, cognome, email, cellulare, telefono, datanascita, password, oldDate)) {
                    // Effettua l'aggiornamento dei dati dell'account, invio la mail e ritorno il successo
                    request.getSession().setAttribute("USER", alterDate);

                    String messaggio = "<p>Ciao " + nome + " " + cognome + ", <br>"
                            + "ti comunichiamo che sono state effettuate delle modifiche alle informazioni di profilo. <br>Se non sei stato tu ad effettuarle ti chiediamo di "
                            + "<a href=\"mailto:lidozanzibar01@gmail.com\">contattarci tramite email</a><br><br>"
                            + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                            + "<br>Ti auguriamo una buona permanenza nel nostro lido e speriamo di vederti presto! <br><br>"
                            + "Lo staff del lido</p>";
                    Mailer mailer = new Mailer(email, "Lido Zanzibar - Modifica Dati", messaggio);
                    Thread thread = new Thread(mailer);
                    thread.start();


                    if (!oldDate.getEmail().equals(alterDate.getEmail())) {
                        // Nel caso in cui sia stata cambiata la mail, invio la mail anche all'indirizzo vecchio
                        Mailer mailer2 = new Mailer(oldDate.getEmail(), "Lido Zanzibar - Modifica Dati", messaggio);
                        Thread thread2 = new Thread(mailer2);
                        thread2.start();
                    }

                    status = "{\"RESPONSE\" : \"Success\", \"TYPE\" : \"Account info updated\",\"MESSAGE\" : \"Modifica dati completata con successo\"}";
                } else { // Errore connessione con il DB
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Database connection\",\"MESSAGE\" : \"Errore durante il collegamento con il database\"}";
                }
            }

            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Common/manageprofile.jsp");
        dispatcher.forward(request, response);
    }
}
