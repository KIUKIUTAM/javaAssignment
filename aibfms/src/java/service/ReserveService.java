package service;

import db.impl.FruitDB;
import db.impl.FruitReserveRecordDB;
import db.impl.FruitStockRecordDB;
import db.impl.StaffDB;
import entity.Staff;

import java.util.List;
import java.util.Map;
import java.sql.Date;
import entity.FruitReserveRecord;
import java.text.SimpleDateFormat;
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

    public List<Map<String, Object>> getAllFruitsWithDetails(){
        return fruitDB.getAllFruitsWithDetails();
    }

    public boolean addStockRecord( int fruitId, int bakeryId, double quantityKg){
        Date expiredDate = expiredDateCal(fruitId);
        return stockDB.addRecord(fruitId, bakeryId, quantityKg, expiredDate);
    }
    
    public boolean addReserveRecord( int fruitId, String userId, double quantityKg, double originToWarehouse){
        Staff staff = staffDB.getStaffByUserId(userId);
        if (staff == null || staff.getStoreId() == null) {
            // Optionally log or handle the case where staff is not found
            return false;
        }
        try {
            FruitReserveRecord reserveRecord = reserveDB.addRecord(fruitId, staff.getStoreId() , 0 , quantityKg);
            reserveDB.updateOriginToWarehouse(reserveRecord.getId(), originToWarehouse);
            return true;
        } catch (Exception e) {
            return false;
        }
        
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
        System.out.println("Updating reserve record ID: " + id + " to state: " + state);
        try {
            // States that require arrival date calculation
            if (state == 2 || state == 4) {
                // Get the transport duration in seconds
                double transportSeconds = reserveDB.getRecordById(id).getOriginToWarehouse();
                System.out.println("Transport duration (seconds): " + transportSeconds);
                
                // Calculate arrival time (current time + transport duration)
                long arrivalTimeMillis = System.currentTimeMillis() + (long)(transportSeconds * 1000);
                Date arrivalDate = new Date(arrivalTimeMillis);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                System.out.println("Calculated arrival date: " + sdf.format(arrivalDate));
                
                // Update both arrival date and state
                boolean dateUpdated = reserveDB.updateArrivalDate(id, arrivalDate);
                System.out.println("Arrival date update status: " + dateUpdated);
                
                boolean stateUpdated = reserveDB.updateRecord(id, state);
                System.out.println("State update status: " + stateUpdated);
                
                return dateUpdated && stateUpdated;
            }
            // For other states, just update the state
            else {
                return reserveDB.updateRecord(id, state);
            }
        } catch (Exception e) {
            System.err.println("Error updating record ID " + id + " to state " + state + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReserveRecord(int id) {
        return reserveDB.deleteRecord(id);
    }

    public List<Map<String, Object>> getReserveRecordsByState(int state) {
        return reserveDB.getRecordsByState(state);
    }

    public FruitReserveRecord getRecordById(int id) {
        return reserveDB.getRecordById(id);
    }




    private Date expiredDateCal(int fruitId){
        var fruit = fruitDB.getFruitById(fruitId);
        int shelfLife = fruit.getShelfLife();
        LocalDate today = LocalDate.now();
        LocalDate expired = today.plusDays(shelfLife);
        return Date.valueOf(expired);
    }
}
