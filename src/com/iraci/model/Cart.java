package com.iraci.model;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Questa classe è la rappresentazione del carrello
 * @author Davide Iraci
 */
public class Cart {
    // Mappa dei prodotti con le relative quantità e note che il cliente ha inserito nel carrello
    // (ogni prodotto è una chiave e la relativa quantità e le note sono il valore corrispondente a quella chiave).
    private final Map<Product, Detail> products;

    /**
     * Costruttore della classe senza parametri.
     */
    public Cart() {
        this.products = new LinkedHashMap<>();
    }

    /**
     * Costruttore della classe con parametri.
     * @param products prodotti
     */
    public Cart(Map<Product, Detail> products) {
        this.products = products;
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano un carrello.
     */
    public Map<Product, Detail> getProducts() {
        return products;
    }

    /**
     * Aggiunge un prodotto al carrello.
     * @param product prodotto
     * @param quantity quantità
     * @param note note
     */
    public void addProduct(Product product, int quantity, String note) {
        Product p=searchProduct(product.getBarcode());
        if(p!=null) {
            Detail Detail=products.get(p);
            if(note!=null) {
                if(Detail.getNote()==null) {
                    Detail.setNote(note);
                }else {
                    Detail.setNote(Detail.getNote()+"\n"+quantity+" "+note);
                }

            }
            Detail.setQuantity(quantity+Detail.getQuantity());
        }else
            products.put(product, new Detail(quantity,note));
    }

    /**
     * Ritorna il prodotto se è già presente nel carrello altrimenti ritorna null
     * @param idProduct id prodotto
     */
    public Product searchProduct(int idProduct) {
        for (Product p : products.keySet()) {
            if(p.getBarcode() == idProduct)
                return p;
        }
        return null;
    }

    /**
     * Restituisce il costo totale dei prodotti nel carrello.
     * @return totale
     */
    public double getTotal() {
        double tot = 0;
        for (Product p : products.keySet()) {
            tot += p.getPrice() * products.get(p).getQuantity();
        }
        return tot;
    }

    /**
     * Rimuove tutti i prodotti dal carrello.
     */
    public void clearCart() {
        products.clear();
    }

    /**
     * Restituisce i prodotti ordinati, il loro prezzo e le loro quantità. Questa funzione viene
     * chiamata per mostrare i dettagli dell'ordine nel corpo della mail inviata al cliente a 
     * seguito del pagamento di tutti gli ordini nel carrello.
     * @return listaAcquisti
     */
    public String getProductsString() {
        StringBuilder cart = new StringBuilder("<table>");
        double tot = 0;
        for (Product p : products.keySet()) {
            cart.append("<tr><td>").append(p.getName()).append("</td><td>x").append(products.get(p).getQuantity()).append("</td><td>").append(p.getPrice() * products.get(p).getQuantity()).append("0&euro;</td></tr>");
            tot += p.getPrice() * products.get(p).getQuantity();
        }
        cart.append("<tr><td colspan=\"3\"><hr /></td></tr><tr><td>Totale: ").append(tot).append("0&euro;</td></tr></table>");
        return cart.toString();
    }

    /**
     * Ritorna la stringa contenente l'array dei prodotti del carrello, formattati per essere inviati tramite JSON
     * @return stringa JSON
     */
    public String toajaxString() {
        StringBuilder cart = new StringBuilder("[");
        double tot = 0, quantity=0;
        for (Product p : products.keySet()) {
            cart.append("{\"barcode\":").append(p.getBarcode()).append(",\"name\":\"").append(p.getName()).append("\",\"category\":\"").append(p.getCategory()).append("\",\"quantity\":").append(products.get(p).getQuantity()).append(", \"price\": ").append(p.getPrice()).append(",\"note\":\"").append(products.get(p).getNote()).append("\"},");
            tot += p.getPrice() * products.get(p).getQuantity();
            quantity+=products.get(p).getQuantity();
        }
        return cart.substring(0, cart.length() - 1)+"] , \"TOTAL\" : \""+String.format("%.2f",tot) + "\", \"PRODUCTNUMBER\" : \"" + quantity+"\" ";
    }

    /**
     * Effettua la concatenazione string degli attributi
     * @return stringa
     */
    @Override
    public String toString() {
        StringBuilder cart = new StringBuilder();
        double tot = 0;
        for (Product p : products.keySet()) {
            cart.append("Prodotto: ").append(p.getName()).append(", Quantità: ").append(products.get(p).getQuantity()).append(", Prezzo: ").append(String.format("%.2f", p.getPrice() * products.get(p).getQuantity())).append("€").append(", Note: ").append(products.get(p).getNote()).append(";\n");
            tot += p.getPrice() * products.get(p).getQuantity();
        }
        cart.append("TOTALE: ").append(String.format("%.2f", tot)).append("€;");
        return cart.toString();
    }

    /**
     * Rimuove un prodotto dal carrello.
     * @param idProduct id prodotto
     */
    public void removeProduct(int idProduct) {
        Product p = searchProduct(idProduct);
        if(p != null)
            products.remove(p);
    }

    /**
     * Restituisce il numero dei prodotti nel carrello
     */
    public int getSize() {
        return products.keySet().size();
    }

    /**
     * Modifica la quantità di un'Detail.
     * @param idProduct id prodotto
     * @param quantity quantità desiderata
     */
    public void setQuantity(int idProduct, int quantity) {
        Product p = searchProduct(idProduct);
        if(p != null)
            products.get(p).setQuantity(quantity);
    }

    /**
     * Modifica la quantità di un'Detail.
     * @param idProduct id prodotto
     */
    public int getQuantity(int idProduct) {
        Product p = searchProduct(idProduct);
        if(p != null)
            return products.get(p).getQuantity();
        return -1;
    }
}
