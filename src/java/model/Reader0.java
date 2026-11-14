// File: src/model/Reader0.java
package model;

public class Reader0 extends Member0 {
    private String readerCode;
    private String address;
    private String email;
    private ReaderCard0 readerCard;

    public Reader0() {
        super();
    }

    public String getReaderCode() { return readerCode; }
    public void setReaderCode(String readerCode) { this.readerCode = readerCode; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public ReaderCard0 getReaderCard() { return readerCard; }
    public void setReaderCard(ReaderCard0 readerCard) { this.readerCard = readerCard; }
}