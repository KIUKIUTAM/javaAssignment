package service;

import db.impl.FruitDB;
import db.impl.FruitReserveRecordDB;
import db.impl.FruitStockRecordDB;
import db.impl.StaffDB;
import entity.Staff;

import java.util.List;
import java.util.Map;
import java.sql.Date;
import java.time.LocalDate;

public class ReserveService {
    
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String user = "root";
    String password = "root";
    
    FruitDB fruitDB;
    FruitReserveRecordDB reserveDB;
    FruitStockRecordDB stockDB;
    StaffDB staffDB;

    public ReserveService(){
        fruitDB = new FruitDB(jdbcUrl,user,password);
        reserveDB = new FruitReserveRecordDB(jdbcUrl,user,password);
        stockDB = new FruitStockRecordDB(jdbcUrl, user, password);
        staffDB = new StaffDB(jdbcUrl, user, password);
    }

    public List<Map<String, Object>> getAllFruitsWithCity(){
        return fruitDB.getAllFruitsWithCity();
    }

    public boolean addStockRecord( int fruitId, int bakeryId, double quantityKg){
        Date expiredDate = expiredDateCal(fruitId);
        return stockDB.addRecord(fruitId, bakeryId, quantityKg, expiredDate);
    }
    
    public boolean addReserveRecord( int fruitId, String userId, double quantityKg){
        Staff staff = staffDB.getStaffByUserId(userId);
        if (staff == null || staff.getStoreId() == null) {
            // Optionally log or handle the case where staff is not found
            return false;
        }
        return reserveDB.addRecord(fruitId, staff.getStoreId(),0, quantityKg);
    }

    public List<Map<String, Object>> getReserveRecordsByBakeryId(String userId){
        Staff staff = staffDB.getStaffByUserId(userId);
        if (staff == null || staff.getStoreId() == null) {
            // Optionally log or handle the case where staff is not found
            return List.of();
        }
        return reserveDB.getRecordsByBakeryId(staff.getStoreId());
    }

    public List<Map<String, Object>> getReserveRecordsByFruitId(int fruitId) {
        return reserveDB.getRecordsByFruitId(fruitId);
    }

    public List<Map<String, Object>> getAllReserveRecords() {
        return reserveDB.getAllRecords();
    }

    public boolean updateReserveRecord(int id, int state) {
        return reserveDB.updateRecord(id, state);
    }

    public boolean deleteReserveRecord(int id) {
        return reserveDB.deleteRecord(id);
    }

    private Date expiredDateCal(int fruitId){
        var fruit = fruitDB.getFruitById(fruitId);
        int shelfLife = fruit.getShelfLife();
        LocalDate today = LocalDate.now();
        LocalDate expired = today.plusDays(shelfLife);
        return Date.valueOf(expired);
    }
}
