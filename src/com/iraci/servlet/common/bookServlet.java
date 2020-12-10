package com.iraci.servlet.common;

import com.iraci.DataBase.DataBase;
import com.iraci.model.User;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "bookServlet", urlPatterns={"/common/book"})
public class bookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nome, cognome, email, password, confPassword, checkPassword, cellulare, telefono, nascita, errore;
            boolean changePass=true;
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

            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            //ObjectMapper mapper = new ObjectMapper();
            String status;

            if(password.isEmpty() || confPassword.isEmpty()) {
                changePass=false;
                password = checkPassword;
                confPassword = password;
            }

            errore = Utils.verificaDatiForm(nome, cognome, email, password, confPassword, cellulare, telefono, nascita);

            if (errore != null) { //sono stati inseriti dati scorretti
                status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Data insert error\",\"MESSAGE\" : \"" + errore + "\"}";
            }else {
                User oldDate = (User) request.getSession().getAttribute("USER");
                User alterDate = new User(oldDate.getIdUtente(), nome, cognome, email, cellulare, telefono, oldDate.getRuolo(), datanascita);

                if (oldDate.equals(alterDate) && !changePass) { //Dati uguali, nessuna modifica richiesta
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Same data\", \"MESSAGE\" : \"I valori inseriti combaciano con quelli attualmente presenti\"}";
                }else if (DataBase.checkPassword(email, checkPassword)) { // la password attuale è sbagliata
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Incorrect password\",\"MESSAGE\" : \"La password inserita è sbagliata\"}";
                }else if (DataBase.alterDate(nome, cognome, email, cellulare, telefono, datanascita, password, oldDate)) {//update riuscito
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
                        Mailer mailer2 = new Mailer(oldDate.getEmail(), "Lido Zanzibar - Modifica Dati", messaggio);
                        Thread thread2 = new Thread(mailer2);
                        thread2.start();
                    }

                    status = "{\"RESPONSE\" : \"Success\", \"TYPE\" : \"Account info updated\",\"MESSAGE\" : \"Modifica dati completata con successo\"}";
                } else {//errore aggiornamento
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Database connection\",\"MESSAGE\" : \"Errore durante il collegamento con il database\"}";
                }
            }

            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Common/book.jsp");
        dispatcher.forward(request, response);
    }
}
