package com.iraci.servlet.company;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Order;
import com.iraci.model.User;
import com.iraci.utils.Mailer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Questa classe gestisce le richieste di modifica o aggiunzione degli impiegati da parte dell'Admin
 * @author Davide Iraci
 */
@WebServlet(name = "employeesManageServlet", urlPatterns={"/company/employeesManage"})
public class employeesManageServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Verifica se c'è stato un errore della richieta JSON
            if(request.getParameter("Type")==null)
                response.sendError(400);
            else{ // Prende il tipo di operazione richesta e invoca il metodo adeguato
                String status=null, type=request.getParameter("Type");
                switch (type){
                    case "GetEmployees": {
                        status=getEmployees(request, response);
                        break;
                    }case "ChangeRole": {
                        status=changeRole(request, response);
                        break;
                    }case "DisableEmployees": {
                        status=disableEmployees(request, response);
                        break;
                    }case "NewEmployees": {
                        status=newEmployees(request, response);
                        break;
                    }default:{
                        response.sendError(400);
                    }
                }
                if(status!=null) { // Se è prevista una risposta la invia
                    PrintWriter pr = response.getWriter();
                    response.setContentType("application/json");
                    pr.write(status);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/Company/employeesManage.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Metodo che restituisce la lista di tutti gli impiegati
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException SQLException
     */
    protected String getEmployees(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende tutti gli impiegati dal DB
        List<User> employees = DataBase.getEmployees();

        User user=((User) request.getSession().getAttribute("USER"));
        employees.remove(employees.indexOf(user));

        // Prepara il necessario per la risposta JSON
        ObjectMapper mapper = new ObjectMapper();

        return  "{\"RESPONSE\" : \"Confirm\", \"EMPLOYEES\" : "+ mapper.writeValueAsString(employees) +"}";
    }

    /**
     * Metodo che modifica il ruolo di un impiegato
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException
     * @throws JsonProcessingException
     */
    protected String changeRole(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende i dati selezionati dall'Admin e modifica il ruolo dell'impiegato richiesto
        int employeesID = Integer.parseInt(request.getParameter("EmployeesID"));
        String newRole= request.getParameter("Role");

        // Se l'ordine non esiste risponde con un errore
        if(!newRole.equals("Admin") && !newRole.equals("Lifeguard") && !newRole.equals("Cook") && !newRole.equals("CashDesk"))
            return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
        else{
            // Aggiorna il ruolo dell'impiegato nel DB
            if(!DataBase.updateEmployeesRole(employeesID, newRole))
                return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
            else {
                // Conferma il cambio di ruolo mandando la risposta al Client

                return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Il cambio di ruolo è stato correttamente effettuato!\" }";
            }
        }
    }

    /**
     * Metodo che elimina il record dell'impiegato selezionato
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException
     * @throws JsonProcessingException
     */
    protected String disableEmployees(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende i dati selezionati dall'Admin e modifica il ruolo dell'impiegato richiesto
        int employeesID = Integer.parseInt(request.getParameter("EmployeesID"));

        // Elimina il record dell'impiegato nel DB
        if(!DataBase.removeEmployees(employeesID))
            return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
        else {
            // Conferma il cambio di ruolo mandando la risposta al Client
            return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"L'eliminazione dell'impiegato è avvenuta con successo!\" }";
        }
    }

    /**
     * Metodo che inserisce nel DB un nuovo impiegato
     * @param request Servelt request del metodo invocante
     * @param response Servelt response del metodo invocante
     * @return Stringa formattata per la risposta AJAX
     * @throws SQLException
     * @throws JsonProcessingException
     */
    protected String newEmployees(HttpServletRequest request, HttpServletResponse response) throws SQLException, JsonProcessingException {
        // Prende i dati impostati dall'Admin
        String nome, cognome, email, password, cellulare, telefono, nascita, role, errore;
        nome = request.getParameter("username");
        cognome = request.getParameter("surname");
        email = request.getParameter("email").toLowerCase();
        password = request.getParameter("password");
        cellulare = request.getParameter("mobile");
        telefono = request.getParameter("telephone");
        nascita = request.getParameter("birth");
        LocalDate datanascita = LocalDate.parse(nascita, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        role = request.getParameter("role");

        // Registra l'impiegato e invia la mail di benvenuto
        if(!DataBase.userSignIn(nome, cognome, email, cellulare, telefono, datanascita, password, role))
            return  "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Si è verificato un errore, riprovare!\" }";
        else {
            // Conferma la registrazione e invia la mail
            String messaggio = "<p><h1>Il Lido Zanzibar ti d&agrave; il benvenuto!</h1> <p>Ciao " + nome + " " + cognome + ", <br>"
                    + "ti comunichiamo che la registrazione del tuo account impiegato &egrave; avvenuta con successo, la tua attuale password è: \""
                    + password + "\", ti ricordiamo che puoi sempre cambiarla una volta effettuato il login!<br><br>"
                    + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Questa</a> &egrave; la piattaforma per svolgere il lavoro."
                    + "<br>Ti auguriamo un buon lavoro, a presto! <br><br>"
                    + "Lo staff del lido</p>";
            Mailer mailer = new Mailer(email, "Lido Zanzibar - Benvenuto", messaggio);
            Thread thread = new Thread(mailer);
            thread.start();

            return "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"L'impiegato è stato creato correttamente!\" }";
        }
    }
}
