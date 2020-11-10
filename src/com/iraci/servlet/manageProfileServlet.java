package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.utils.Mailer;
import com.iraci.utils.Utils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "manageProfileServlet", urlPatterns={"/manageprofile"})
public class manageProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nome, cognome, email, password, confPassword, checkPassword, cellulare, telefono, nascita, errore;
            nome = request.getParameter("username");
            cognome = request.getParameter("surname");
            email = request.getParameter("email");
            password = request.getParameter("password");
            confPassword = request.getParameter("passwordrep");
            checkPassword = request.getParameter("passwordcheck");
            cellulare = request.getParameter("mobile");
            telefono = request.getParameter("telephone");
            nascita = request.getParameter("birth");
            LocalDate datanascita = LocalDate.parse(nascita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

            if(password.isEmpty()) {
                password = checkPassword;
                confPassword = password;
            }

            errore = Utils.verificaDatiForm(nome, cognome, email, password, confPassword, cellulare, telefono, nascita);

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

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/manageprofile.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/manageprofile.jsp");
        dispatcher.forward(request, response);
    }
}
