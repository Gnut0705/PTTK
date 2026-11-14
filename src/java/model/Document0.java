// File: src/model/Document0.java
package model;

public class Document0 {
    private int id;
    private String documentCode;
    private String name;
    private String author;
    private String publisher;
    private int yearOfPublication;
    private int quantity;
    private String typeOfDocument;

    public Document0() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getDocumentCode() { return documentCode; }
    public void setDocumentCode(String documentCode) { this.documentCode = documentCode; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }
    public int getYearOfPublication() { return yearOfPublication; }
    public void setYearOfPublication(int yearOfPublication) { this.yearOfPublication = yearOfPublication; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getTypeOfDocument() { return typeOfDocument; }
    public void setTypeOfDocument(String typeOfDocument) { this.typeOfDocument = typeOfDocument; }
}