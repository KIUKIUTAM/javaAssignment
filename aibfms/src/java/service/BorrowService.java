package service;

import db.impl.FruitBorrowRecordDB;
import entity.FruitBorrowRecord;
import entity.FruitStockRecord;
import db.impl.FruitStockRecordDB;
import db.impl.StaffDB;
import java.util.List;

public class BorrowService {
    FruitBorrowRecordDB borrowDB;
    FruitStockRecordDB stockDB;

    StaffDB staffDB;
    public BorrowService(String jdbcUrl, String username, String password) {
        borrowDB = new FruitBorrowRecordDB(jdbcUrl, username, password);
        stockDB = new FruitStockRecordDB(jdbcUrl, username, password);
        staffDB = new StaffDB(jdbcUrl, username, password);
    }

    public boolean addBorrowRecord(int stockId, String bakeryUserId, int borrowBakeryId) {
        int bakeryStoreId = staffDB.getStaffByUserId(bakeryUserId).getStoreId();
        return borrowDB.addRecord(stockId, bakeryStoreId, borrowBakeryId, 0);
    }

    public List<FruitBorrowRecord> getRecordsByBakeryId(String bakeryUserId) {
        int bakeryStoreId = staffDB.getStaffByUserId(bakeryUserId).getStoreId();
        return borrowDB.getRecordsByBakeryId(bakeryStoreId);
    }

    public List<FruitBorrowRecord> getRecordsByBorrowBakeryId(String bakeryUserId) {
        int bakeryStoreId = staffDB.getStaffByUserId(bakeryUserId).getStoreId();
        return borrowDB.getRecordsByBorrowBakeryId(bakeryStoreId);
    }
    public List<FruitStockRecord> getAllStockRecordsExcludingBorrowedAndSelfSameBakeryCity(String bakeryUserId) {
        int bakeryStoreId = staffDB.getStaffByUserId(bakeryUserId).getStoreId();
        return stockDB.getAllRecordsExcludingBorrowedAndSelfSameBakeryCity(bakeryStoreId);
    }

    public boolean updateRecordStateById(int id, int state) {
        FruitBorrowRecord record = getRecordById(id);
        record.setState(state);
        return borrowDB.updateRecord(record);
    }

    public FruitBorrowRecord getRecordById(int id) {
        return borrowDB.getRecordById(id);
    }

    public void updateStockBorrowId(int stockId, int storeId) {
        FruitStockRecord record = stockDB.getRecordById(stockId);
        int orgId = record.getBakeryId();
        record.setBorrowRecord(orgId);
        record.setBakeryId(storeId);
        stockDB.updateRecord(record);
    }

}