package com.iraci.utils;

import java.io.ByteArrayOutputStream;
import java.util.Map;

import com.iraci.model.*;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.FontSelector;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class InvoiceGenerator {
    /**
     * Metodo per la creazione del PDF della fattura
     * @param baos ByteArrayOutputStream contenente il PDF finale
     * @param invoice Fattura di cui si necessità il PDF
     */
    public static void createInovice (ByteArrayOutputStream baos, Invoice invoice){
        try {
            Document document = new Document();
            PdfWriter writer = PdfWriter.getInstance(document, baos);

            // Inserisce l'immagine del lido nella fattura
            Image image = Image.getInstance("src/img/logo.jpg");
            image.scaleAbsolute(540f, 72f);

            // Crea l'intestazione della fattura, inserendo il numero di fattura,
            // il numero della prenotazione o dell'ordine e la data
            PdfPTable irdTable = new PdfPTable(2);
            irdTable.addCell(getIRDCell("Fattura N°"));
            irdTable.addCell(getIRDCell("Data"));
            irdTable.addCell(getIRDCell(String.format("%08d", invoice.getInvoiceID())));
            irdTable.addCell(getIRDCell(invoice.getDate().toString()));

            PdfPTable irhTable = new PdfPTable(3);
            irhTable.setWidthPercentage(100);

            irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
            irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
            if (invoice.isBookInvoice())
                irhTable.addCell(getIRHCell("Fattura Prenotazione N°" + String.format("%08d", invoice.getBookID()), PdfPCell.ALIGN_RIGHT));
            else
                irhTable.addCell(getIRHCell("Fattura Ordine N°" + String.format("%08d", invoice.getOrderID()), PdfPCell.ALIGN_RIGHT));
            irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
            irhTable.addCell(getIRHCell("", PdfPCell.ALIGN_RIGHT));
            PdfPCell invoiceTable = new PdfPCell(irdTable);
            invoiceTable.setBorder(0);
            irhTable.addCell(invoiceTable);

            // Aggiunge intestatario fattura con i dati rispettivi
            FontSelector fs = new FontSelector();
            Font font = FontFactory.getFont(FontFactory.TIMES_ROMAN, 13, Font.BOLD);
            fs.addFont(font);
            Phrase bill = fs.process("Fattura a"); // customer information
            Paragraph name = new Paragraph(invoice.getName() + " " + invoice.getSurname());
            name.setIndentationLeft(20);
            Paragraph contact = new Paragraph(invoice.getFiscalcode().toUpperCase());
            contact.setIndentationLeft(20);
            Paragraph address = new Paragraph(invoice.getAddress() + ", " + invoice.getCAP() + " " + invoice.getCity() + " " + invoice.getProvince().toUpperCase() + ", " + invoice.getRegion());
            address.setIndentationLeft(20);

            // Crea l'intestazione della tabella contenente i prodotti o i servizi offerti
            PdfPTable billTable = new PdfPTable(6);
            billTable.setWidthPercentage(100);
            billTable.setWidths(new float[]{1, 2, 5, 2, 1, 2});
            billTable.setSpacingBefore(30.0f);
            billTable.addCell(getBillHeaderCell("Index"));
            billTable.addCell(getBillHeaderCell("Oggetto"));
            billTable.addCell(getBillHeaderCell("Descrizione"));
            billTable.addCell(getBillHeaderCell("Prezzo"));
            billTable.addCell(getBillHeaderCell("N°"));
            billTable.addCell(getBillHeaderCell("Totale"));

            // Variabili di appoggio sul numero di prodotti e la quantità degli stessi
            int i = 0, qty, padding_max;

            // Inserimento campi della fattura di una prenotazione
            if (invoice.isBookInvoice()) {
                qty = invoice.getBook().getPostations().size();
                double price = invoice.getBook().getPrice();
                padding_max = 15;

                for (i = 0; i < invoice.getBook().getPostations().size(); i++) {
                    Postation post = invoice.getBook().getPostations().get(i);
                    billTable.addCell(getBillRowCell((i + 1) + ""));
                    billTable.addCell(getBillRowCell("Postazione"));
                    billTable.addCell(getBillRowCell("Ombrellone con 2 sdraio \n Fila " + post.getRow() + ", Posto " + post.getNumber()));
                    billTable.addCell(getBillRowCell(String.format("%.2f", post.getPrice())));
                    billTable.addCell(getBillRowCell("1"));
                    billTable.addCell(getBillRowCell(String.format("%.2f", post.getPrice())));
                    price -= post.getPrice();
                }

                if (invoice.getBook().getExtra_chair() > 0) {
                    qty++;
                    billTable.addCell(getBillRowCell((i + 1) + ""));
                    billTable.addCell(getBillRowCell("Sdraio"));
                    billTable.addCell(getBillRowCell("Sdraio Extra"));
                    billTable.addCell(getBillRowCell(String.format("%.2f", price / invoice.getBook().getExtra_chair())));
                    billTable.addCell(getBillRowCell(invoice.getBook().getExtra_chair() + ""));
                    billTable.addCell(getBillRowCell(String.format("%.2f", price)));
                }
            } else {
                // Inserimento campi della fattura di un ordine di ristorazione
                padding_max = 8;
                qty = invoice.getOrder().getSize();

                for (Map.Entry<Product, Detail> entry : invoice.getOrder().getProducts().entrySet()) {
                    billTable.addCell(getBillRowCell((i + 1) + ""));
                    billTable.addCell(getBillRowCell(entry.getKey().getName()));
                    billTable.addCell(getBillRowCell(entry.getKey().getCategory()));
                    billTable.addCell(getBillRowCell(String.format("%.2f", entry.getKey().getPrice())));
                    billTable.addCell(getBillRowCell(entry.getValue().getQuantity() + ""));
                    billTable.addCell(getBillRowCell(String.format("%.2f", entry.getKey().getPrice() * entry.getValue().getQuantity())));
                    i++;
                }
            }

            // Effettua il padding per il completamento della pagina
            for (i = 0; i < (padding_max - qty); i++) {
                billTable.addCell(getBillRowCell(" "));
                billTable.addCell(getBillRowCell(""));
                billTable.addCell(getBillRowCell(" "));
                billTable.addCell(getBillRowCell(""));
                billTable.addCell(getBillRowCell(" "));
                billTable.addCell(getBillRowCell(""));
            }

            // Inserimento Footer del PDF contenente il prezzo totale e, in caso di prenotazione
            // aggiunge la quantità di IVA versata
            PdfPTable validity = new PdfPTable(1);
            validity.setWidthPercentage(100);
            validity.addCell(getValidityCell(" "));
            validity.addCell(getValidityCell(""));
            validity.addCell(getValidityCell(" "));
            validity.addCell(getValidityCell(" "));
            PdfPCell summaryL = new PdfPCell(validity);
            summaryL.setColspan(3);
            summaryL.setPadding(1.0f);
            billTable.addCell(summaryL);

            PdfPTable accounts = new PdfPTable(2);
            accounts.setWidthPercentage(100);

            if (invoice.isBookInvoice()) {
                accounts.addCell(getAccountsCell("Totale"));
                accounts.addCell(getAccountsCellR(String.format("%.2f", invoice.getBook().getPrice() * 0.78)));
                accounts.addCell(getAccountsCell("Tasse(22%)"));
                accounts.addCell(getAccountsCellR(String.format("%.2f", invoice.getBook().getPrice() * 0.22)));
                accounts.addCell(getAccountsCell("Totale Pagato"));
                accounts.addCell(getAccountsCellR(String.format("%.2f", invoice.getBook().getPrice())));
            } else {
                accounts.addCell(getAccountsCell("Totale Pagato"));
                accounts.addCell(getAccountsCellR(String.format("%.2f", invoice.getOrder().getTotal())));
            }
            PdfPCell summaryR = new PdfPCell(accounts);
            summaryR.setColspan(3);
            billTable.addCell(summaryR);

            PdfPTable describer = new PdfPTable(1);
            describer.setWidthPercentage(100);
            describer.addCell(getdescCell(" "));

            // Apre il documento e inserisce tutti i campi precedentemente creati e aggiunge
            // il titolo, l'oggetto, le keywords del PDF, l'autore e il creatore
            document.open();

            document.add(image);
            document.add(irhTable);
            document.add(bill);
            document.add(name);
            document.add(contact);
            document.add(address);
            document.add(billTable);
            document.add(describer);
            if (invoice.isBookInvoice()){
                document.addTitle("Fattura prenotazione " + String.format("%08d", invoice.getBookID()));
                document.addSubject("Fattura prenotazione");
                document.addKeywords("Invoice, PDF, Fattura, Prenotazione");
            }else{
                document.addTitle("Fattura ordine "+String.format("%08d", invoice.getOrderID()));
                document.addSubject("Fattura ordine");
                document.addKeywords("Invoice, PDF, Fattura, Ordine");
            }
            document.addAuthor("Lido Zanzibar");
            document.addCreator("Lido Zanzibar Manage System");

            document.close();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @param alignment allineamento
     * @return Blocco del PDF
     */
    public static PdfPCell getIRHCell(String text, int alignment) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 15);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell(phrase);
        cell.setPadding(5);
        cell.setHorizontalAlignment(alignment);
        cell.setBorder(PdfPCell.NO_BORDER);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getIRDCell(String text) {
        PdfPCell cell = new PdfPCell (new Paragraph (text));
        cell.setHorizontalAlignment (Element.ALIGN_CENTER);
        cell.setPadding (5.0f);
        cell.setBorderColor(BaseColor.LIGHT_GRAY);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getBillHeaderCell(String text) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 11);
        font.setColor(BaseColor.GRAY);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell (phrase);
        cell.setHorizontalAlignment (Element.ALIGN_CENTER);
        cell.setPadding (5.0f);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getBillRowCell(String text) {
        PdfPCell cell = new PdfPCell (new Paragraph (text));
        cell.setHorizontalAlignment (Element.ALIGN_CENTER);
        cell.setPadding (5.0f);
        cell.setBorderWidthBottom(0);
        cell.setBorderWidthTop(0);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getBillFooterCell(String text) {
        PdfPCell cell = new PdfPCell (new Paragraph (text));
        cell.setHorizontalAlignment (Element.ALIGN_CENTER);
        cell.setPadding (5.0f);
        cell.setBorderWidthBottom(0);
        cell.setBorderWidthTop(0);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getValidityCell(String text) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
        font.setColor(BaseColor.GRAY);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell (phrase);
        cell.setBorder(0);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getAccountsCell(String text) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell (phrase);
        cell.setBorderWidthRight(0);
        cell.setBorderWidthTop(0);
        cell.setPadding (5.0f);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getAccountsCellR(String text) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell (phrase);
        cell.setBorderWidthLeft(0);
        cell.setBorderWidthTop(0);
        cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
        cell.setPadding (5.0f);
        cell.setPaddingRight(20.0f);
        return cell;
    }

    /**
     * Metodo per la creazione di un campo della fattura
     * @param text testo
     * @return Blocco del PDF
     */
    public static PdfPCell getdescCell(String text) {
        FontSelector fs = new FontSelector();
        Font font = FontFactory.getFont(FontFactory.HELVETICA, 10);
        font.setColor(BaseColor.GRAY);
        fs.addFont(font);
        Phrase phrase = fs.process(text);
        PdfPCell cell = new PdfPCell (phrase);
        cell.setHorizontalAlignment (Element.ALIGN_CENTER);
        cell.setBorder(0);
        return cell;
    }
}