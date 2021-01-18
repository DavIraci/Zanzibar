package com.iraci.servlet;

import com.iraci.DataBase.DataBase;
import com.iraci.utils.Mailer;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

/**
 * Questa classe gestisce il reset della password dell'account mediante email
 * @author Davide Iraci
 */
@WebServlet(name = "resetServlet", urlPatterns={"/resetpwd"})
public class resetServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Verifica che l'utente non abbia effettuato l'accesso
        if(request.getUserPrincipal() == null){
            try {
                // Riceve i dati dal form
                String email = request.getParameter("email"), password = DataBase.resetPassword(email);

                // Prepara il necessario per la risposta JSON
                PrintWriter pr = response.getWriter();
                response.setContentType("application/json");
                String status;

                if (password == null){
                    // Verifica se l'email esiste nel DB e se ci sono stati errori nel resettare
                    status = "{\"RESPONSE\" : \"Error\", \"TYPE\" : \"Reset Passsword Error\",\"MESSAGE\" : \"E' stato riscontrato un problema o l'email non è associata a nessun account!\"}";
                }else{
                    // Invia la mail con la nuova password all'utente
                    String messaggio = "<p>Salve,<br> è stata effettuata la richiesta per il reset della password. La tua nuova password "
                            + "temporanea &egrave:<br><br>" + password + "<br><br> Usala per effettuare il login e successivamente ti consigliamo"
                            + " di cambiarla.<br>Ti auguriamo una buona permanenza nel nostro lido e speriamo di vederti presto! <br><br>"
                            + "Lo staff del lido</p>";
                    Mailer mailer = new Mailer(email, "Lido Zanzibar - Reset Password", messaggio);
                    Thread thread = new Thread(mailer);
                    thread.start();

                    status = "{\"RESPONSE\" : \"Confirm\", \"TYPE\" : \"Reset Passsword succes\",\"MESSAGE\" : \"E' stata impostata una password temporanea ed è stata inviata per email!\"}";
                }

                pr.write(status);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
                response.sendError(400);
            }
        }
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Verifica che l'utente non abbia effettuato l'accesso
        if(request.getUserPrincipal() == null)
            request.getSession().setAttribute("ResetPwd","");
        response.sendRedirect(request.getContextPath());
    }
}
