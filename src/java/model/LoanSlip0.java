// File: src/model/LoanSlip0.java
package model;

import java.sql.Date;

public class LoanSlip0 {
    private int id;
    private Date borrowingDate;
    private Date dueDate;
    private Reader0 reader;
    private Librarian0 librarian;

    public LoanSlip0() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getBorrowingDate() { return borrowingDate; }
    public void setBorrowingDate(Date borrowingDate) { this.borrowingDate = borrowingDate; }
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    public Reader0 getReader() { return reader; }
    public void setReader(Reader0 reader) { this.reader = reader; }
    public Librarian0 getLibrarian() { return librarian; }
    public void setLibrarian(Librarian0 librarian) { this.librarian = librarian; }
}