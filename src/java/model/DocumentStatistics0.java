// File: src/model/DocumentStatistics0.java
package model;

public class DocumentStatistics0 extends Document0 {
    private int numberOfTimesBorrowed;

    public DocumentStatistics0() {
        super();
    }

    public int getNumberOfTimesBorrowed() { return numberOfTimesBorrowed; }
    public void setNumberOfTimesBorrowed(int numberOfTimesBorrowed) {
        this.numberOfTimesBorrowed = numberOfTimesBorrowed;
    }
}