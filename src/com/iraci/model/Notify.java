package model;

import java.io.Serializable;

/**
 * Classe che contiene i dati di una notifica.
 * @author Marco La Martina
 */
public class Notify implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	/**
	 * Intero che identifica il tipo di notifica ( 0 per le info, 1 per le notifiche di successo e 2 per gli errori
	 */
	private int flag;
	
	/**
	 * Testo della notifica.
	 */
	private String text;
	
	/**
	 * Titolo della notifica.
	 */
	private String title;
	
	/**
	 * Costruttore della classe senza parametri.
	 */
	public Notify() {
		super();
	}
	
	/**
	 * Costruttore della classe con parametri.
	 * @param flag
	 * @param title
	 * @param text
	 */
	public Notify(int flag, String title, String text ) {
		this.flag=flag;
		this.text=text;
		this.title=title;
	}
	
	/* Metodi get per accedere dall'esterno ai dati che identificano un cliente. */

	public String getTitle() {
		return this.title;
	}
	
	public String getText() {
		return this.text;
	}
	
	public int getFlag() {
		return this.flag;
	}
}

