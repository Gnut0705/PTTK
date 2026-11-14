// File: src/model/ReaderCard0.java
package model;

import java.sql.Date;

public class ReaderCard0 {
    private int id;
    private String cardCode;
    private Date cardIssuanceDate;
    private Date expiry;

    public ReaderCard0() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getCardCode() { return cardCode; }
    public void setCardCode(String cardCode) { this.cardCode = cardCode; }
    public Date getCardIssuanceDate() { return cardIssuanceDate; }
    public void setCardIssuanceDate(Date cardIssuanceDate) { this.cardIssuanceDate = cardIssuanceDate; }
    public Date getExpiry() { return expiry; }
    public void setExpiry(Date expiry) { this.expiry = expiry; }
}