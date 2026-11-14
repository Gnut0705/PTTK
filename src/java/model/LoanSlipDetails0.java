// File: src/model/LoanSlipDetails0.java
package model;

public class LoanSlipDetails0 {
    private int id;
    private String status;
    private String note;
    private LoanSlip0 loanSlip;
    private Document0 document;

    public LoanSlipDetails0() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public LoanSlip0 getLoanSlip() { return loanSlip; }
    public void setLoanSlip(LoanSlip0 loanSlip) { this.loanSlip = loanSlip; }
    public Document0 getDocument() { return document; }
    public void setDocument(Document0 document) { this.document = document; }
}