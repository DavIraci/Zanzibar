package com.iraci.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Questa classe di utility gestisce l'invio delle mail ai clienti. Implementa
 * l'interfaccia Runnable per permettere l'invio delle mail tramite un thread
 * durante lo svolgimento di altre operazioni.
 * @author Davide Iraci
 */
public class Mailer implements Runnable {
	
	/**
	 * Variabili:
	 * host --> web host dell'indirizzo email sorgente
	 * indirizzoEmail --> indirizzo email sorgente
	 * password --> password associata all'indirizzo email sorgente
	 * indirizzoDestinazione --> indirizzo email di destinazione
	 * oggetto --> oggetto della mail
	 * messaggio --> stringa html che contiene il corpo della mail
	 */

	private String host;
	private String password;
	private String indirizzoDestinazione;
	private String oggetto;
	private String messaggio;
	private static String address="http://localhost:8080";
	private static String indirizzoEmail="lidozanzibar01@gmail.com";
	private static String cellulare="3290000000";
	
	/**
	 * Construttore della classe.
	 * @param indirizzoDestinazione
	 * @param oggetto
	 * @param messaggio
	 */
	public Mailer (String indirizzoDestinazione, String oggetto, String messaggio) {
		this.host = "smtp.gmail.com";
		this.password = "LidoZanzibar01";
		this.indirizzoDestinazione = indirizzoDestinazione;
		this.oggetto = oggetto;
		this.messaggio = messaggio;
	}
	
	/**
	 * Invia una mail dall'indirizzo email sorgente all'indirizzo email di destinazione.
	 * Tutti i parametri necessari a gestire la comunicazione sono impostati attraverso 
	 * il costruttore. 
	 */
	public void sendMail() throws MessagingException {
		
		// Imposta le proprietà del server SMTP.
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host); 
		properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
		
		// Crea una nuova sessione con un autenticatore.
		Session session = Session.getDefaultInstance(properties, new Authenticator() {  
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(indirizzoEmail, password);
			}
		});
		
		// Compone il messaggio della mail.
		MimeMessage msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(indirizzoEmail));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(indirizzoDestinazione));
		msg.setSubject(oggetto);
		msg.setContent(messaggio, "text/html");
   
		// Invia il messaggio al destinatario
			Transport.send(msg);
			System.out.println("Email inviata con successo a " + indirizzoDestinazione);
		} 
	
	/**
	 * Override del metodo run() della classe Thread. Serve per permettere alle servlet di 
	 * inviare le mail con thread separati mentre svolgono altre operazioni.
	 */
	@Override
	public void run() {
		try {
		this.sendMail();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static String getAddress() {
		return address;
	}


	public static String getCellulare() {
		return cellulare;
	}

	public static String getIndirizzoEmail() {
		return indirizzoEmail;
	}
}