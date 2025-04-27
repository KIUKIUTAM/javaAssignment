package entity;

import java.util.Date;

public class FruitReserveRecord {
    private int id;
    private int fruitId;
    private int bakeryId;
    private int state;
    private double quantity;
    private Date createDate;
    private Date arrivalDate;
    private Double originToWarehouse;  // Using Double to allow null
    private Double warehouseToStore;   // Using Double to allow null

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFruitId() {
        return fruitId;
    }

    public void setFruitId(int fruitId) {
        this.fruitId = fruitId;
    }

    public int getBakeryId() {
        return bakeryId;
    }

    public void setBakeryId(int bakeryId) {
        this.bakeryId = bakeryId;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public double getQuantity() {
        return quantity;
    }

    public void setQuantity(double quantity) {
        this.quantity = quantity;
    }
    
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getArrivalDate() {
        return arrivalDate;
    }

    public void setArrivalDate(Date arrivalDate) {
        this.arrivalDate = arrivalDate;
    }

    public Double getOriginToWarehouse() {
        return originToWarehouse;
    }

    public void setOriginToWarehouse(Double originToWarehouse) {
        this.originToWarehouse = originToWarehouse;
    }

    public Double getWarehouseToStore() {
        return warehouseToStore;
    }

    public void setWarehouseToStore(Double warehouseToStore) {
        this.warehouseToStore = warehouseToStore;
    }

}