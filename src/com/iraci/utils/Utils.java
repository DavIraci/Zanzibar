package com.iraci.utils;

import com.iraci.DataBase.DataBase;
import com.iraci.model.Postation;

//import javax.swing.text.Document;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Collection;
import java.util.List;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.codec.Base64;

public class Utils {


    public static String verificaDatiForm(String nome, String cognome, String email, String password, String confPassword, String cellulare, String telefono, String nascita) {
        if( (nome == null || cognome == null || email == null || password == null || confPassword == null || cellulare == null || nascita == null) || (nome.replaceAll("\\s+","").contentEquals("") || cellulare.replaceAll("\\s+","").contentEquals("") || cognome.replaceAll("\\s+","").contentEquals("") ||
                email.replaceAll("\\s+","").contentEquals("") || password.replaceAll("\\s+","").contentEquals("") || nascita.replaceAll("\\s+","").contentEquals("")) )
            return "I campi sono tutti richiesti.";


        String regex = "^[A-Za-zèùàòé][a-zA-Z'èùàòé ]*$";
        if(!nome.matches(regex))
            return "Il nome non rispetta il formato richiesto.";

        if(!cognome.matches(regex))
            return "Il cognome non rispetta il formato richiesto.";

        regex = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+[.][a-zA-Z0-9-.]+$";
        if(!email.matches(regex))
            return "L'email non rispetta il formato richiesto.";

        regex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";
        if(!password.matches(regex))
            return "La password non rispetta il formato richiesto.";

        if(!password.equals(confPassword))
            return "Le password non corrispondono.";

        regex = "\\d{4}-\\d{2}-\\d{2}";
        if(!nascita.matches(regex))
            return "La data di nascita non rispetta il formato richiesto.";

        regex = "[0-9]{10}";
        if( (!telefono.replaceAll("\\s+","").contentEquals("") && !telefono.matches(regex)) || !cellulare.matches(regex))
            return "Il telefono non rispetta il formato richiesto.";

        return null;
    }

    public static boolean occupiedCheck(List<Postation> posts, LocalDate date, String period) throws SQLException {
        boolean occupied = false;
        List<Postation> post_occupied= DataBase.takeBooking(date, period);

        for(int i=0; i<posts.size(); i++){
            if(post_occupied.contains(posts.get(i))){
                occupied=true;
                break;
            }
        }
        return occupied;
    }

    public static void generateInvoide(ByteArrayOutputStream baos, int BookID){
        //init document
        Document document = new Document(PageSize.A4, 60, 30, 140, 90);
        document.setMarginMirroring(false);

        try {
            //init pdf writer
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            writer.setBoxSize("art", new com.itextpdf.text.Rectangle(36, 54, 559, 788));


            //open the document
            document.open();

            //add title and body
            document.addTitle("Fattura ordine "+String.format("%08d", BookID));
            document.addSubject("Fattura");
            document.addKeywords("Invoice, PDF, Fattura");
            document.addAuthor("Lido Zanzibar");
            document.addCreator("Lido Zanzibar");
            document.add(new Paragraph("Prova prenotazione numero: "+ String.format("%08d", BookID)));

            //document.addHeader(text+".pdf", "application/pdf");

            //close document and pdf writer
            document.close();
            writer.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


        /*OutputStream os = response.getOutputStream();

        PdfWriter writer;
        PdfDocument pdf = new PdfDocument( writer);
        Document document = new Document();
        getInstance(Document document, OutputStream os)

            document.setMarginMirroring(false);

            //init pdf writer
            writer = PdfWriter.getInstance(document, baos);
            writer.setBoxSize("art", new com.itextpdf.text.Rectangle(36, 54, 559, 788));

            //add header and footer
            HeaderFooter event = new HeaderFooter(header, footer, absolutLogoPath);
            writer.setPageEvent(event);

            //open the document
            document.open();

            //add title and body
            addTitle(document, acc)
            addBody(document, acc, body, vat, writer);

            //close document and pdf writer
            document.close();

        writer.close();
    }*/
}
