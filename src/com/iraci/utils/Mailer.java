package com.iraci.utils;

import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
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

	private final String host;
	private final String password;
	private final String indirizzoDestinazione;
	private final String oggetto;
	private final String messaggio;
	private final String attachment_title;
	private final byte[] pdf;
	private static final String address="http://localhost:8080";
	private static final String indirizzoEmail="lidozanzibar01@gmail.com";
	private static final String cellulare="3290000000";

	
	/**
	 * Construttore della classe.
	 * @param indirizzoDestinazione indirizzo email destinatario
	 * @param oggetto oggetto della mail
	 * @param messaggio messaggio della mail
	 */
	public Mailer (String indirizzoDestinazione, String oggetto, String messaggio) {
		this.host = "smtp.gmail.com";
		this.password = "LidoZanzibar01";
		this.indirizzoDestinazione = indirizzoDestinazione;
		this.oggetto = oggetto;
		this.messaggio = messaggio;
		this.pdf = null;
		this.attachment_title = null;
	}

	/**
	 * Construttore della classe con allegato.
	 * @param indirizzoDestinazione indirizzo email destinatario
	 * @param oggetto oggetto della email
	 * @param messaggio messaggio della email
	 * @param pdf pdf allegato
	 */
	public Mailer (String indirizzoDestinazione, String oggetto, String messaggio, byte[] pdf,String attachment_title) {
		this.host = "smtp.gmail.com";
		this.password = "LidoZanzibar01";
		this.indirizzoDestinazione = indirizzoDestinazione;
		this.oggetto = oggetto;
		this.messaggio = messaggio;
		this.pdf = pdf;
		this.attachment_title = attachment_title;
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

		Message msg = new MimeMessage(session);

		msg.setFrom(new InternetAddress("Lido Zanzibar <"+indirizzoEmail+">"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(indirizzoDestinazione));
		msg.setSubject(oggetto);
		msg.setContent(messaggio, "text/html");

		// creates message part
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(messaggio, "text/html");

		// creates multi-part
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);

		if(pdf!=null){
			MimeBodyPart att = new MimeBodyPart();
			ByteArrayDataSource bds = new ByteArrayDataSource(pdf, "application/pdf");
			bds.setName(attachment_title);
			att.setDataHandler(new DataHandler(bds));
			att.setFileName(bds.getName()+".pdf");
			multipart.addBodyPart(att);
			msg.setContent(multipart);
		}
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