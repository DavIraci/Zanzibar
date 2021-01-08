package com.iraci.model;

import java.util.LinkedHashMap;
import java.util.Map;

public class Cart {
    /**
     * Mappa dei prodotti con le relative quantità e note che il cliente ha inserito nel carrello
     * (ogni prodotto è una chiave e la relativa quantità e le note sono il valore corrispondente a quella
     * chiave).
     */
    private Map<Product, Order> products;

    /**
     * Costruttore della classe senza parametri.
     */
    public Cart() {
        this.products = new LinkedHashMap<Product, Order>();
    }

    /**
     * Costruttore della classe con parametri.
     * @param products
     */
    public Cart(Map<Product, Order> products) {
        this.products = products;
    }

    /**
     * Metodo get per accedere dall'esterno ai dati che caratterizzano un carrello.
     */
    public Map<Product, Order> getProducts() {
        return products;
    }

    /**
     * Aggiunge un prodotto al carrello.
     * @param product
     * @param quantity
     * @param note
     */
    public void addProduct(Product product, int quantity, String note) {
        Product p=searchProduct(product.getBarcode());
        if(p!=null) {
            System.out.println("Prodotto già presente nel carrello!");

            Order order=products.get(p);
            if(note!=null) {
                if(order.getNote()==null) {
                    order.setNote(note);
                }else {
                    order.setNote(order.getNote()+"\n"+quantity+" "+note);
                }

            }
            order.setQuantity(quantity+order.getQuantity());
        }else {
            System.out.println("Prodotto NON nel carrello!");
            products.put(product, new Order(quantity,note));
        }
    }

    /**
     * Ritorna il prodotto se è già presente nel carrello altrimenti ritorna null
     * @param idProduct
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
        String cart = "<table>";
        double tot = 0;
        for (Product p : products.keySet()) {
            cart += "<tr><td>"+p.getName() + "</td><td>x" + products.get(p).getQuantity() + "</td><td>" + p.getPrice() * products.get(p).getQuantity() + "0&euro;</td></tr>";
            tot += p.getPrice() * products.get(p).getQuantity();
        }
        cart += "<tr><td colspan=\"3\"><hr /></td></tr><tr><td>Totale: " + tot + "0&euro;</td></tr></table>";
        return cart;
    }

    public String toajaxString() {
        String cart = "[";
        double tot = 0, quantity=0;
        for (Product p : products.keySet()) {
            cart += "{\"barcode\":"+p.getBarcode() + ",\"name\":\""+p.getName() + "\",\"category\":\""+p.getCategory() + "\",\"quantity\":"+products.get(p).getQuantity() + ", \"price\": "+p.getPrice() + ",\"note\":\""+products.get(p).getNote() + "\"},";
            tot += p.getPrice() * products.get(p).getQuantity();
            quantity+=products.get(p).getQuantity();
        }
        return cart.substring(0, cart.length() - 1)+"] , \"TOTAL\" : \""+String.format("%.2f",tot) + "\", \"PRODUCTNUMBER\" : \"" + quantity+"\" ";
    }

    @Override
    public String toString() {
        String cart = "";
        double tot = 0;
        for (Product p : products.keySet()) {
            cart += "Prodotto: "+p.getName() + ", Quantità: " + products.get(p).getQuantity() + ", Prezzo: " + String.format("%.2f",p.getPrice() * products.get(p).getQuantity()) + "€"+ ", Note: " + products.get(p).getNote() +";\n";
            tot += p.getPrice() * products.get(p).getQuantity();
        }
        cart += "TOTALE: " + String.format("%.2f",tot) + "€;";
        return cart;
    }

    /**
     * Rimuove un prodotto dal carrello.
     * @param idProduct
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
     * Modifica la quantità di un'order.
     * @param idProduct
     * @param quantity
     */
    public void setQuantity(int idProduct, int quantity) {
        Product p = searchProduct(idProduct);
        if(p != null)
            products.get(p).setQuantity(quantity);
    }

    /**
     * Modifica la quantità di un'order.
     * @param idProduct
     * @param quantity
     */
    public int getQuantity(int idProduct) {
        Product p = searchProduct(idProduct);
        if(p != null)
            return products.get(p).getQuantity();
        return -1;
    }
}
