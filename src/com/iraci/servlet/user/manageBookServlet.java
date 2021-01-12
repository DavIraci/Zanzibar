package com.iraci.servlet.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.iraci.DataBase.DataBase;
import com.iraci.model.Invoice;
import com.iraci.model.Book;
import com.iraci.model.User;
import com.iraci.utils.InvoiceGenerator;
import com.iraci.utils.Mailer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

/**
 * Questa classe gestisce le operazioni sulle prenotazioni effettuate dall'utente. Permettendo la visione, cancellazione o l'invio della fattura
 * @author Davide Iraci
 */
@WebServlet(name = "manageBookServlet", urlPatterns={"/user/managebook"})
public class manageBookServlet extends HttpServlet {
    /**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            String status;

            if(request.getParameter("BookID")!=null && request.getParameter("Request").equals("Invoid")){ // Richiesto l'invio della fattura di una prenotazione
                if(sendInvoid(Integer.parseInt(request.getParameter("BookID")), request))
                    status = "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"Inviata email con fattura in allegato!\"}";
                else
                    status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile inviare la fattura, riprovare o in caso contattarci!\"}";
            }else { // Richiesto l'elenco delle prenotazioni dell'utente
                List<Book> books = DataBase.getBooks(((User) request.getSession().getAttribute("USER")).getIdUtente());

                if (books.isEmpty()) { // Nessuna prenotazione dell'utente
                    status = "{\"RESPONSE\" : \"Alert\", \"MESSAGE\" : \"Non è stata effettuata ancora alcuna prenotazione\"}";
                } else { // Ritorna la lista di prenotazioni dell'utente
                    ObjectMapper mapper = new ObjectMapper();
                    status = "{\"RESPONSE\" : \"Confirm\", \"BOOK\" : " + mapper.writeValueAsString(books) + " }";
                }
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }

    /**
     * Si occupa di generare la fattura in formato PDF e inviarla per email al cliente
     * @param bookID ID Book
     * @param request Servlet request del metodo invocante
     * @return risultato
     * @throws SQLException SQLException
     */
    private boolean sendInvoid(int bookID, HttpServletRequest request) throws SQLException {
        // Controlla se la fattura esiste e la prende dal DB
        Invoice invoice= DataBase.getInvoice(bookID);
        if(invoice==null)
            return false;

        // Crea gli oggetti necessari alla fattura e invoca la creazione della stessa con la classe InvoiceGenerator
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        //InvoiceGenerator.createBookInovice(baos, invoice);
        InvoiceGenerator.createInovice(baos, invoice);
        byte[] bytes = baos.toByteArray();
        String title=baos.toString().substring(baos.toString().indexOf("Title(")+6, baos.toString().indexOf("Title(")+35).trim();

        // Prende i dati dell'utente e invia la mail con la fattura in allegato
        User user=((User) request.getSession().getAttribute("USER"));
        String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                + "In allegato troverai la fattura della prenotazione da te richiesta!<br><br>"
                + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                + "Lo staff del lido</p>";

        Mailer mailer = new Mailer(((User) request.getSession().getAttribute("USER")).getEmail(), "Lido Zanzibar - "+ title, messaggio, bytes, title);

        Thread thread = new Thread(mailer);
        thread.start();
        return true;
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/User/manageBook.jsp");
        dispatcher.forward(request, response);
    }

    /**
	 * @see HttpServlet#doDelete(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            //Prepara il necessario per la risposta JSON
            PrintWriter pr = response.getWriter();
            response.setContentType("application/json");
            String status;

            // Prende l'ID della prenotazione e effettua la cancellazione, inviando una mail all'utente per avvertirlo
            if(request.getParameter("BookID")!=null && DataBase.cancelBook(Integer.parseInt(request.getParameter("BookID")))){
                String id=String.format("%08d",Integer.parseInt(request.getParameter("BookID")));
                status = "{\"RESPONSE\" : \"Confirm\", \"MESSAGE\" : \"La prenotazione n°"+id +" è stata cancellata!\"}";
                User user=((User) request.getSession().getAttribute("USER"));
                String messaggio = "<p>Ciao " + user.getNome() + " " + user.getCognome() + ", <br>"
                        + "Come da te richiesto è stata cancellata la prenotazione n°"+id
                        + ".<br>Stiamo arrangiando il rimborso dal metodo da te usato per il pagamento, tra qualche giorno potrai visualizzare il movimento nel conto!"
                        + "<br><br>" + "<a href='" + Mailer.getAddress() + request.getContextPath() + "'> Visita il nostro sito</a> per usufruire dei nostri servizi."
                        + "<br>Ti auguriamo una buona permanenza nel nostro lido! <br><br>"
                        + "Lo staff del lido</p>";

                Mailer mailer = new Mailer(((User) request.getSession().getAttribute("USER")).getEmail(), "Lido Zanzibar - Cancellazione prenotazione N°"+ id, messaggio);

                Thread thread = new Thread(mailer);
                thread.start();
            }else { // Errore durante l'annullamento
                status = "{\"RESPONSE\" : \"Error\", \"MESSAGE\" : \"Non è stato possibile annullare l'ordine, riprovare o in caso contattarci!\"}";
            }
            pr.write(status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(400);
        }
    }
}
