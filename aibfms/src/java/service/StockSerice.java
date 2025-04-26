package service;

import db.impl.FruitStockRecordDB;
import entity.FruitStockRecord;
import java.util.List;
import db.impl.StaffDB;
import entity.Staff;

public class StockSerice {
    FruitStockRecordDB stockDB;
    StaffDB staffDB;


    public StockSerice(String jdbcUrl, String username, String password) {
        stockDB = new FruitStockRecordDB(jdbcUrl, username, password);
        staffDB = new StaffDB(jdbcUrl, username, password);
    }

    public boolean addStockRecord(int fruitId, int bakeryId, double quantityKg, java.sql.Date expiredDate) {
        return stockDB.addRecord(fruitId, bakeryId, quantityKg, expiredDate);
    }
    
    public FruitStockRecord getStockRecordById(int id) {
        return stockDB.getRecordById(id);
    }

    public List<FruitStockRecord> getStockRecordsByBakeryUserId(String bakeryUserId) {
        Staff staff = staffDB.getStaffByUserId(bakeryUserId);
        return stockDB.getRecordsByBakeryId(staff.getStoreId());
    }

    public List<FruitStockRecord> getStockRecordsByBakeryId(String bakeryUserId) {
        Staff staff = staffDB.getStaffByUserId(bakeryUserId);
        if (staff == null || staff.getStoreId() == null) {
            return List.of();
        }
        return stockDB.getRecordsByBakeryId(staff.getStoreId());
    }

    public List<FruitStockRecord> getExpiringSoonRecords(int days) {
        return stockDB.getExpiringSoonRecords(days);
    }

    public List<FruitStockRecord> getAllStockRecords() {
        return stockDB.getAllRecords();
    }
}
