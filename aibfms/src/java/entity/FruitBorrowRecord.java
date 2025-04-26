package entity;

import java.util.Date;

public class FruitBorrowRecord {
    private int id;
    private int stockId;
    private int bakeryId;
    private int borrowBakeryId;
    private int state;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStockId() {
        return stockId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }

    public int getBakeryId() {
        return bakeryId;
    }

    public void setBakeryId(int bakeryId) {
        this.bakeryId = bakeryId;
    }

    public int getBorrowBakeryId() {
        return borrowBakeryId;
    }

    public void setBorrowBakeryId(int borrowBakeryId) {
        this.borrowBakeryId = borrowBakeryId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

}
