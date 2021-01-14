package com.iraci.DataBase;

import com.iraci.model.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.Map;

/**
 * Questa classe modella la connessione con il database. Gestisce tutti i metodi che
 * interagiscono con il database, consentendo di effettuare interrogazioni per inserire,
 * cancellare, aggiornare o ritornare i dati delle tabelle.
 * @author Davide Iraci
 */
public class DataBase {
    private static DataSource dataSource = null;

    // Inizializza il context ed il data source per la comunicazione con il database.
    static {
        try {
            // Dichiarazione delle variabili necessarie a gestire la connessione con il database e l'esecuzione delle query.
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/iraci");
        }
        catch (NamingException e) {
            e.printStackTrace();
        }
    }

    /**
     * Prende i dati dal DB dell'utente registrato con l'email fornita come argomento
     * @param email Email dell'account con cui si vuole effettuare il login
     * @return Oggetto User inizializzato o null se non esiste!
     * @throws SQLException SQLException
     */
    public static User takeUser(String email) throws SQLException{
        String query = "SELECT U.id_User, U.name, U.surname, U.role, U.email, U.telephone, U.mobile, U.birthday FROM iraci.user AS U WHERE U.email=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id_User"), rs.getString("name"), rs.getString("surname"), rs.getString("email"), rs.getString("mobile"), rs.getString("telephone"), rs.getString("role"), LocalDate.parse(rs.getDate("birthday").toString()));
            } else {
                rs.close();
                return null;
            }
        }
    }

    /**
     * Prende i dati dal DB dell'utente registrato con l'email fornita come argomento
     * @param userID User ID dell'account voluto
     * @return Oggetto User inizializzato o null se non esiste!
     * @throws SQLException SQLException
     */
    public static User takeUser(int userID) throws SQLException{
        String query = "SELECT U.id_User, U.name, U.surname, U.role, U.email, U.telephone, U.mobile, U.birthday FROM iraci.user AS U WHERE U.id_User=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userID);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id_User"), rs.getString("name"), rs.getString("surname"), rs.getString("email"), rs.getString("mobile"), rs.getString("telephone"), rs.getString("role"), LocalDate.parse(rs.getDate("birthday").toString()));
            } else {
                rs.close();
                return null;
            }
        }
    }

    /**
     * Inserisce all'interno del database i dati del cliente che effettua la registrazione
     * @param nome nome
     * @param cognome cognome
     * @param email email
     * @param cellulare cellulare
     * @param datanascita datanascita
     * @param password password
     * @throws SQLException SQLException
     */
    public static void userSignIn(String nome, String cognome, String email, String cellulare, String telefono, LocalDate datanascita, String password) throws SQLException{
        String query = "INSERT INTO iraci.user (name, surname, email, password, mobile, telephone, birthday, role) " +
                "VALUES (?, ?, ?, SHA2(?, 256), ?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setString(3, email);
            statement.setString(4, password);
            statement.setString(5, cellulare);
            statement.setString(6, telefono);
            statement.setDate(7, Date.valueOf(datanascita));
            statement.setString(8, "User");
            statement.executeUpdate();
        }
    }

    /**
     * Ritorna TRUE se esiste un account con la stessa email, viceversa FALSE
     * @param email email
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean checkAlreadyReg(String email) throws SQLException{
        String query = "SELECT U.email FROM iraci.user AS U WHERE u.email=?";
        boolean res=false;
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                res = true;
            }
            rs.close();
            return res;
        }
    }

    /**
     * Metodo che genera una stringa di 10 caratteri con almeno un carattare minuscolo, uno maiuscolo e un numero
     * @param length lunghezza voluta della password
     * @return stringa contenente la password
     */
    public static String generateRandomPassword(int length) {
        String character = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder password= new StringBuilder();
        Random random = new Random();
        String regex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";

        while (!password.toString().matches(regex)){
            password = new StringBuilder();
            for (int i = 0; i < length; i++) {
                password.append(character.charAt(random.nextInt(character.length())));
            }
        }
        return password.toString();
    }

    /**
     * Resetta la password ritornando una stringa contenente la nuova password o ritorna null se non trova corrispondenza
     * @param email account da resettare
     * @return stringa password nuova o null
     * @throws SQLException SQLException
     */
    public static String resetPassword(String email) throws SQLException{
        String newpwd=generateRandomPassword(8);
        String query = "UPDATE iraci.user SET password=SHA2(?, 256) WHERE email=? ";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, newpwd);
            statement.setString(2, email);
            int result = statement.executeUpdate();
            if (result > 0) {
                return  newpwd;
            }else{
                return null;
            }
        }
    }

    /**
     * Verifica se la password inserita è corretta per l'email selezionato
     * @param email account
     * @param checkPassword password
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean checkPassword(String email, String checkPassword) throws SQLException {
        String query = "SELECT U.email FROM iraci.user AS U WHERE u.email=? AND u.password=?";
        boolean res=false;
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            statement.setString(2, checkPassword);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                res = true;
            }
            rs.close();
            return res;
        }
    }

    /**
     * Modifica i dati dell'account associato
     * @param nome nome
     * @param cognome cognome
     * @param email email
     * @param cellulare cellulare
     * @param telefono telefono
     * @param datanascita datanascita
     * @param password password
     * @param user user
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean alterDate(String nome, String cognome, String email, String cellulare, String telefono, LocalDate datanascita, String password, User user) throws SQLException{
        String query = "UPDATE iraci.user SET name=?, surname=?, birthday=?, telephone=?, email=?, password=SHA2(?, 256), mobile=?  WHERE email=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, nome);
            statement.setString(2, cognome);
            statement.setDate(3, Date.valueOf(datanascita));
            statement.setString(4, telefono);
            statement.setString(5, email);
            statement.setString(6, password);
            statement.setString(7, cellulare);
            statement.setString(8, user.getEmail());
            int result = statement.executeUpdate();
            return result > 0;
        }
    }

    /**
     * Ritorna una lista di Double contenente i prezzi relativi alla data e allo slot di tempo selezionato. Nel primo posto c'è il prezzo della sdraio extra e dopo le postazioni ordinate per fila
     * @param date data
     * @param period slot temporale
     * @return Lista prezzi [Sdraio, Fila1, Fila2, Fila3, Fila4, Fila5]
     * @throws SQLException SQLException
     */
    public static List<Double> takePrice(LocalDate date, String period) throws SQLException {
        List<Double> price = new ArrayList<>();
        String season;
        if(date.getMonthValue() == 8){
            season="highSeason";
        }else if(date.getMonthValue() == 7){
            season="midSeason";
        }else {
            season="lowSeason";
        }
        int half=period.equals("Full")?1:2;
        String query = "SELECT * FROM iraci.price ORDER BY price.row ASC";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                price.add( rs.getDouble(season)/( (rs.getInt("row")==0)?1:half ) );
            }
            rs.close();
            return price;
        }
    }

    /**
     * Prende tutte le postazioni prenotate nel giorno e nello slot di tempo selezionato
     * @param date data
     * @param period slot temporale
     * @return lista di postazioni occupate
     * @throws SQLException SQLException
     */
    public static List<Postation> takePostationsBooked(LocalDate date, String period) throws SQLException {
        List<Postation> postazioni = new ArrayList<>();
        List<Double> prices = takePrice(date, period);
        String query = "SELECT UmbrellaStation_id_UmbrellaStation FROM iraci.book_has_umbrellastation JOIN iraci.book ON book.id_book=book_has_umbrellastation.Book_id_Book WHERE book.date=? AND book.canceled=0 AND (book.bookingPeriod='Full' OR book.bookingPeriod=? OR book.bookingPeriod=?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDate(1, Date.valueOf(date));
            if(period.equals("Full")) {
                statement.setString(2, "AM");
                statement.setString(3, "PM");
            }else{
                statement.setString(2, period);
                statement.setString(3, "");
            }
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                postazioni.add(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation"), prices));
            }
            rs.close();
            return postazioni;
        }
    }

    /**
     * Effettua l'insirimento nel DB di una prenotazione, inserendo tutte le postazioni prenotate con i dettagli
     * @param postations lista di Postazioni
     * @param date data
     * @param period slot temporale
     * @param price prezzo totale
     * @param user_id user_id
     * @param extra_chair sedie sdraio extra
     * @return id_prenotazione o -1 in caso di errore
     * @throws SQLException SQLException
     */
    public static int placeBook(List<Postation> postations, LocalDate date, String period, double price, int user_id, int extra_chair )throws SQLException {
        String query1 = "INSERT INTO iraci.book (date, bookingPeriod, cost, User_id_User) " +
                "VALUES (?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS)) {
            statement.setDate(1, Date.valueOf(date));
            statement.setString(2, period);
            statement.setDouble(3, price);
            statement.setInt(4, user_id);
            statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                rs.close();
                for (Postation postation : postations) {
                    String query2 = "INSERT INTO iraci.book_has_umbrellastation (Book_id_Book, UmbrellaStation_id_UmbrellaStation, extraChair) values (?, ?, ?)";
                    try (PreparedStatement statement2 = connection.prepareStatement(query2)) {
                        statement2.setInt(1, id);
                        statement2.setInt(2, postation.getId());
                        statement2.setInt(3, Math.min(extra_chair, 2));
                        extra_chair -= Math.min(extra_chair, 2);
                        if (statement2.executeUpdate() == 0) {
                            return -1;
                        }
                    }
                }
                return id;
            }
            rs.close();
        }
        return -1;
    }

    /**
     * Inserisce nel DB i dati della fattura relativa ad una prenotazione
     * @param id id prenotazione
     * @param name nome
     * @param surname cognome
     * @param email email
     * @param fiscal codice fiscale
     * @param address indirizzo
     * @param region regione
     * @param province provincia
     * @param city città
     * @param cap CAP
     * @param method metodo pagamento
     * @param cardno numero carta
     * @throws SQLException SQLException
     */
    public static void insertInvoid(int id, String name, String surname, String email, String fiscal, String address, String region, String province, String city, String cap, String method, String cardno) throws SQLException{
        String query = "INSERT INTO iraci.invoice (id_book, name, surname, email, fiscalcode, address, region, province, city, CAP, method, cardno) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.setString(3, surname);
            statement.setString(4, email);
            statement.setString(5, fiscal);
            statement.setString(6, address);
            statement.setString(7, region);
            statement.setString(8, province);
            statement.setString(9, city);
            statement.setString(10, cap);
            statement.setString(11, method);
            statement.setString(12, cardno == null ? "" : cardno);
            statement.executeUpdate();
        }
    }

    /**
     * Seleziona tutte le prenotazioni effettuate da un determinato utente
     * @param user_id id user
     * @return lista di prenotazioni
     * @throws SQLException SQLException
     */
    public static List<Book> getBooks(int user_id) throws SQLException {
        List<Book> books = new ArrayList<>();
        int last_bookid=-1;
        Book book = null;
        String query = "SELECT * FROM iraci.book JOIN iraci.book_has_umbrellastation ON book.id_Book=book_has_umbrellastation.Book_id_Book WHERE book.User_id_User=?;";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, user_id);
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                if(rs.getInt("id_Book")==last_bookid){
                    assert book != null;
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));
                    book.setExtra_chair(book.getExtra_chair()+rs.getInt("extraChair"));
                }else{
                    if (last_bookid!=-1)
                        books.add(book);
                    book=new Book(rs.getString("bookingPeriod"), user_id, rs.getInt("id_Book"), rs.getDouble("cost"), rs.getInt("canceled") != 0, rs.getTimestamp("checkIn")==null?null:rs.getTimestamp("checkIn").toLocalDateTime(), rs.getTimestamp("checkOut")==null?null:rs.getTimestamp("checkOut").toLocalDateTime(), rs.getInt("extraChair"), LocalDate.parse(rs.getDate("date").toString()), LocalDate.parse(rs.getDate("bookingDate").toString()));
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));
                    last_bookid=book.getBook_id();
                }
            }
            if (last_bookid!=-1)
                books.add(book);
            rs.close();
            return books;
        }
    }

    /**
     * Seleziona una determinata prenotazione mediante il suo ID
     * @param bookID id prenotazione
     * @return la prenotazione o null se inesistente
     * @throws SQLException SQLException
     */
    public static Book getBook(int bookID) throws SQLException {
        Book book=null;
        int last_bookid=-1;
        LocalDateTime checkin, checkout;
        String query = "SELECT * FROM iraci.book JOIN iraci.book_has_umbrellastation ON book.id_Book=book_has_umbrellastation.Book_id_Book WHERE book.id_Book=?;";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, bookID);
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                if(rs.getInt("id_Book")==last_bookid){
                    assert book != null;
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));
                    book.setExtra_chair(book.getExtra_chair()+rs.getInt("extraChair"));
                }else{
                    checkin=rs.getTimestamp("checkIn")==null?null:rs.getTimestamp("checkIn").toLocalDateTime();
                    checkout=rs.getTimestamp("checkOut")==null?null:rs.getTimestamp("checkOut").toLocalDateTime();
                    book=new Book(rs.getString("bookingPeriod"), rs.getInt("User_id_User"), rs.getInt("id_Book"), rs.getDouble("cost"), rs.getInt("canceled") != 0, checkin, checkout, rs.getInt("extraChair"), LocalDate.parse(rs.getDate("date").toString()), LocalDate.parse(rs.getDate("bookingDate").toString()));
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));

                    last_bookid=book.getBook_id();
                }
            }
            rs.close();
            assert book != null;
            book.setPrices(takePrice(book.getDate(), book.getPeriod()));
            return book;
        }
    }

    /**
     * Ritorna la fattura di una determinata prenotazione mediante il suo id
     * @param BookID id prenotazione
     * @return la fattura o null se inesistente
     * @throws SQLException SQLException
     */
    public static Invoice getInvoice(int BookID) throws SQLException {
        String query = "SELECT I.*, B.bookingDate, B.date FROM iraci.invoice as I JOIN iraci.book as B ON I.id_book=B.id_Book where I.id_Book=?;";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, BookID);
            ResultSet rs = statement.executeQuery();
            if (rs.next())
                return new Invoice(BookID, rs.getInt("id_invoice"), rs.getString("name"), rs.getString("surname"), rs.getString("email"), rs.getString("fiscalcode"), rs.getString("address"), rs.getString("region"), rs.getString("province"), rs.getString("city"), rs.getString("CAP"), rs.getString("method"), LocalDate.parse(rs.getDate("bookingDate").toString()), LocalDate.parse(rs.getDate("date").toString()), getBook(BookID));
            rs.close();
        }
        return null;
    }

    /**
     * Elimina la prenotazione con l'id inserito 
     * @param bookID id prenotazione
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean cancelBook(int bookID) throws SQLException {
        String query = "UPDATE iraci.book SET book.canceled = 1 WHERE id_Book = ?;";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, bookID);
            int result = statement.executeUpdate();
            return result > 0;
        }
    }

    /**
     * Ritorna la lista di prodotti in vendita della categoria selezionata
     * @param category categoria
     * @return lista di prodotti o null se vuoti
     * @throws SQLException SQLException
     */
    public static List<Product> getProducts(String category) throws SQLException {
        List<Product> products= new ArrayList<>();
        String condition=category.equals("All")?"1":"product.category";
        String query = "SELECT * FROM iraci.product WHERE "+ condition +"=? ORDER BY product.name ASC";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, category.equals("All")?"1":category);
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                products.add(new Product(rs.getString("name"), rs.getInt("quantity"), rs.getString("description"), rs.getDouble("price"), rs.getInt("barcode"), rs.getString("category")));
            }
            rs.close();
            return products;
        }
    }

    /**
     * Ritorna il prodotto con il codice inserito
     * @param barcode codice prodotto
     * @return il prodotto o null se inesistente
     * @throws SQLException SQLException
     */
    public static Product getProduct(int barcode) throws SQLException {
        String query = "SELECT * FROM iraci.product WHERE product.barcode=? ";
        try (Connection connection = dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, barcode);
            ResultSet rs = statement.executeQuery();
            if (rs.next())
                return new Product(rs.getString("name"), rs.getInt("quantity"), rs.getString("description"), rs.getDouble("price"), rs.getInt("barcode"), rs.getString("category"));
            rs.close();
            return null;
        }
    }

    /**
     * Verifica se l'utente è attualmente presente dentro al lido
     * @param user_id user id
     * @return true o false
     * @throws SQLException SQLException
     */
    public static boolean userInSite(int user_id) throws SQLException {
        String query = "SELECT * FROM iraci.book WHERE book.date=? AND book.checkIn<now() AND book.User_id_User=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDate(1, Date.valueOf(LocalDate.now()));
            statement.setInt(2, user_id);
            ResultSet rs = statement.executeQuery();
            while(rs.next()) {
                if(rs.getTimestamp("checkOut")==null)
                    return true;
            }
            rs.close();
            return false;
        }
    }

    /**
     * Inserisce nel database un ordine effettuato per il servizio ristorazione
     * @param cart carrello contenente i prodotti
     * @param user_id user id
     * @param payed pagato
     * @param delivery metodo di ritiro
     * @return id dell'ordine inserito
     * @throws SQLException SQLException
     */
    public static int placeOrder(Cart cart, int user_id, boolean payed, String delivery)throws SQLException {
        String query = "INSERT INTO iraci.order (order.date, order.payed, order.User_id_User, order.delivery_method) VALUES (?,?,?,?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            statement.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            statement.setByte(2, (byte) (payed ?1:0));
            statement.setInt(3, user_id);
            statement.setString(4, delivery);
            statement.executeUpdate();
            ResultSet rs = statement.getGeneratedKeys();
            int order_id = -1;
            if (rs.next()) {
                order_id = rs.getInt(1);
                rs.close();
                for (Map.Entry<Product, Detail> entry : cart.getProducts().entrySet()) {
                    String query2 = "INSERT INTO iraci.order_has_product (order_has_product.Order_id_Order, order_has_product.Product_barcode, order_has_product.quantity, order_has_product.price, order_has_product.details) VALUES (?,?,?,?,?)";
                    try(PreparedStatement statement2 = connection.prepareStatement(query2)) {
                        statement2.setInt(1, order_id );
                        statement2.setInt(2, entry.getKey().getBarcode());
                        statement2.setInt(3, entry.getValue().getQuantity());
                        statement2.setDouble(4, entry.getKey().getPrice());
                        statement2.setString(5, entry.getValue().getNote());
                        statement2.executeUpdate();
                    }
                }
            }
            rs.close();
            return order_id;
        }
    }

    /**
     * Inserisce nel DB i dati della fattura relativa ad un ordine del servizio ristorazione
     * @param id id ordine
     * @param name nome
     * @param surname cognome
     * @param email email
     * @param fiscal codice fiscale
     * @param address indirizzo
     * @param region regione
     * @param province provincia
     * @param city città
     * @param cap CAP
     * @param method metodo pagamento
     * @param cardno numero carta
     * @throws SQLException SQLException
     */
    public static void insertOrderInvoid(int id, String name, String surname, String email, String fiscal, String address, String region, String province, String city, String cap, String method, String cardno) throws SQLException{
        String query = "INSERT INTO iraci.invoice (id_order, name, surname, email, fiscalcode, address, region, province, city, CAP, method, cardno) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.setString(2, name);
            statement.setString(3, surname);
            statement.setString(4, email);
            statement.setString(5, fiscal);
            statement.setString(6, address);
            statement.setString(7, region);
            statement.setString(8, province);
            statement.setString(9, city);
            statement.setString(10, cap);
            statement.setString(11, method);
            statement.setString(12, cardno == null ? "" : cardno);
            statement.executeUpdate();
        }
    }

    /**
     * Ritorna la fattura di un determinato ordine mediante il suo id
     * @param orderID id prenotazione
     * @param cart carello contenente i prodotti
     * @return la fattura o null se inesistente
     * @throws SQLException SQLException
     */
    public static Invoice getOrderInvoice(int orderID, Cart cart) throws SQLException {
        String query = "SELECT I.* FROM iraci.invoice AS I WHERE I.id_order=?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderID);
            ResultSet rs = statement.executeQuery();
            if (rs.next())
                return new Invoice(orderID, rs.getInt("id_invoice"), rs.getString("name"), rs.getString("surname"), rs.getString("email"), rs.getString("fiscalcode"), rs.getString("address"), rs.getString("region"), rs.getString("province"), rs.getString("city"), rs.getString("CAP"), rs.getString("method"), LocalDate.now(), cart);
            rs.close();
        }
        return null;
    }

    /**
     * Restituiscre la liste delle prenotazioni per la giornata e lo slot temporale selezionato
     * @param date data
     * @param period slot temporale
     * @return lista di prenotazioni
     * @throws SQLException
     */
    public static List<Book> takeBooks(LocalDate date, String period) throws SQLException {
        List<Book> books = new ArrayList<>();
        int last_bookid=-1;
        Book book = null;
        String query = "SELECT * FROM iraci.book_has_umbrellastation JOIN iraci.book ON book.id_book=book_has_umbrellastation.Book_id_Book WHERE book.date=? AND book.canceled=0 AND (book.bookingPeriod='Full' OR book.bookingPeriod=? OR book.bookingPeriod=?)";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDate(1, Date.valueOf(date));
            if(period.equals("Full")) {
                statement.setString(2, "AM");
                statement.setString(3, "PM");
            }else{
                statement.setString(2, period);
                statement.setString(3, "");
            }
            ResultSet rs = statement.executeQuery();

            while(rs.next()) {
                if(rs.getInt("id_Book")==last_bookid){
                    assert book != null;
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));
                    book.setExtra_chair(book.getExtra_chair()+rs.getInt("extraChair"));
                }else{
                    if (last_bookid!=-1)
                        books.add(book);
                    book=new Book(rs.getString("bookingPeriod"), rs.getInt("User_id_User"), rs.getInt("id_Book"), rs.getDouble("cost"), rs.getInt("canceled") != 0, rs.getTimestamp("checkIn")==null?null:rs.getTimestamp("checkIn").toLocalDateTime(), rs.getTimestamp("checkOut")==null?null:rs.getTimestamp("checkOut").toLocalDateTime(), rs.getInt("extraChair"), LocalDate.parse(rs.getDate("date").toString()), LocalDate.parse(rs.getDate("bookingDate").toString()));
                    book.addPostation(new Postation(rs.getInt("UmbrellaStation_id_UmbrellaStation")));
                    last_bookid=book.getBook_id();
                }
            }
            if (last_bookid!=-1)
                books.add(book);
            rs.close();
            return books;
        }
    }

    /**
     * Effettua l'inserimento del Timestamp attuale per il check-in del cliente assieme alla lista degli ospiti
     * @param bookID bookID
     * @param guests ospiti
     * @return true o false
     * @throws SQLException
     */
    public static boolean insertCheckIn(int bookID, String guests) throws SQLException {
        String query = "UPDATE iraci.book SET guests = ?, checkIn = ? WHERE id_Book = ? AND book.checkIn IS NULL";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, guests);
            statement.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            statement.setInt(3, bookID);
            int result = statement.executeUpdate();
            return  result > 0;
        }
    }

    /**
     * Effettua l'inserimento del Timestamp attuale per il check-out del cliente
     * @param bookID bookID
     * @return true o false
     * @throws SQLException
     */
    public static boolean insertCheckOut(int bookID) throws SQLException {
        String query = "UPDATE iraci.book SET checkOut = ? WHERE id_Book = ? AND book.checkIn IS NOT NULL";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            statement.setInt(2, bookID);
            int result = statement.executeUpdate();
            return  result > 0;
        }
    }

    /**
     * Metodo per la selezione di tutti gli ordini di ristorazione della data selezionata
     * @param date data
     * @return Lista degli ordini
     * @throws SQLException SQLException
     */
    public static List<Order> getOrders(LocalDate date) throws SQLException {
        List<Order> orders = new ArrayList();
        int last_orderID=-1;
        Order order = null;
        String query= "SELECT * FROM iraci.order JOIN iraci.order_has_product ON iraci.order.id_Order=iraci.order_has_product.Order_id_Order WHERE DATE(iraci.order.date) = ? AND iraci.order.status != 'D' ORDER BY iraci.order.id_Order ASC";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setDate(1, Date.valueOf(date));
            ResultSet rs = statement.executeQuery();

            while(rs.next()) { // Finchè ci sono nuovi record
                if(rs.getInt("id_Order")==last_orderID){ // Se il record appartiene all'ordine precedente e lo aggiunge
                    assert order != null;
                    order.addProduct(DataBase.getProduct(rs.getInt("Product_barcode")),rs.getInt("quantity") , rs.getString("details"));
                }else{
                    if (last_orderID!=-1)
                        orders.add(order);
                    order=new Order(rs.getInt("id_Order"), LocalDate.parse(rs.getDate("date").toString()), rs.getString("status").charAt(0), rs.getInt("payed")==1?true:false, rs.getInt("User_id_User"), rs.getString("delivery_method"));
                    order.addProduct(DataBase.getProduct(rs.getInt("Product_barcode")),rs.getInt("quantity") , rs.getString("details"));
                    last_orderID=order.getOrderID();
                }
            }
            if (last_orderID!=-1)
                orders.add(order);
            rs.close();
            return orders;
        }
    }

    /**
     * Metodo per la selezione di un ordine di ristorazione
     * @param orderID orderID
     * @return Ordine o null
     * @throws SQLException SQLException
     */
    public static Order getOrder(int orderID) throws SQLException {
        Order order = null;
        int last_orderID=-1;
        String query= "SELECT * FROM iraci.order JOIN iraci.order_has_product ON iraci.order.id_Order=iraci.order_has_product.Order_id_Order WHERE iraci.order.id_Order = ? ORDER BY iraci.order.id_Order ASC";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, orderID);
            ResultSet rs = statement.executeQuery();

            while(rs.next()) { // Finchè ci sono nuovi record
                if (last_orderID==-1)
                    order=new Order(rs.getInt("id_Order"), LocalDate.parse(rs.getDate("date").toString()), rs.getString("status").charAt(0), rs.getInt("payed")==1?true:false, rs.getInt("User_id_User"), rs.getString("delivery_method"));
                order.addProduct(DataBase.getProduct(rs.getInt("Product_barcode")),rs.getInt("quantity") , rs.getString("details"));
                last_orderID=order.getOrderID();
            }
            return order;
        }
    }

    /**
     * Effettua la modifica dello stato di un ordine del servizio di ristorazione
     * @param orderID orderID
     * @param newStatus nuovo stato da impostare
     * @return true o false
     * @throws SQLException
     */
    public static boolean updateOrderStatus(int orderID, String newStatus) throws SQLException {
        String query = "UPDATE iraci.order SET iraci.order.status= ? WHERE iraci.order.id_Order = ?";
        try(Connection connection=dataSource.getConnection(); PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, newStatus);
            statement.setInt(2, orderID);
            int result = statement.executeUpdate();
            return  result > 0;
        }
    }
}
