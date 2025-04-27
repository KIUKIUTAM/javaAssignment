package service;

import db.impl.FruitStockRecordDB;
import entity.FruitStockRecord;
import java.util.List;
import db.impl.StaffDB;
import entity.Staff;
import java.util.Map;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class StockService {
    private final FruitStockRecordDB stockDB;
    private final StaffDB staffDB;

    public StockService() {
        String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
        String user = "root";
        String password = "root";
        stockDB = new FruitStockRecordDB(jdbcUrl, user, password);
        staffDB = new StaffDB(jdbcUrl, user, password);
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
        return stockDB.getRecordsByBakeryId(staff.getStoreId());
    }

    public List<FruitStockRecord> getExpiringSoonRecords(int days) {
        return stockDB.getExpiringSoonRecords(days);
    }

    public List<FruitStockRecord> getAllStockRecords() {
        return stockDB.getAllRecords();
    }

    public List<Map<String, Object>> getStockRecordsGroupByFruitByBakeryId(String bakeryUserId) {
        Staff staff = staffDB.getStaffByUserId(bakeryUserId);
        return stockDB.getRecordsGroupByFruitByBakeryId(staff.getStoreId());
    }
} 