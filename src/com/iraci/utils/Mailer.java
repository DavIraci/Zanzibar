package com.iraci.utils;

import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.swing.text.Document;
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
	private String attachment_title;
	private byte[] pdf;
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
		this.pdf = null;
		this.attachment_title = null;
	}

	/**
	 * Construttore della classe con allegato.
	 * @param indirizzoDestinazione
	 * @param oggetto
	 * @param messaggio
	 * @param pdf
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
		
		/*// Compone il messaggio della mail.
		MimeMessage msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress("Lido Zanzibar <"+indirizzoEmail+">"));
		msg.addRecipient(Message.RecipientType.TO, new InternetAddress(indirizzoDestinazione));
		msg.setSubject(oggetto);
		msg.setContent(messaggio, "text/html");

		if(pdf!=null){
			Message message = new MimeMessage(session);
			Multipart multipart = new MimeMultipart();

			// creates body part for the message
			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(message, "text/html");

			// creates body part for the attachment
			MimeBodyPart attachPart = new MimeBodyPart();

			// code to add attachment...will be revealed later

			// adds parts to the multipart
			multipart.addBodyPart(messageBodyPart);
			multipart.addBodyPart(attachPart);

			// sets the multipart as message's content
			message.setContent(multipart);
		}*/

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