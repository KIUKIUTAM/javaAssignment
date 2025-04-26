package db.impl;

import entity.FruitBorrowRecord;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;

public class FruitBorrowRecordDB extends BaseDB {

    public FruitBorrowRecordDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public boolean addRecord(int stockId, int bakeryId, int borrowBakeryId, int state) {
        String sql = "INSERT INTO fruit_borrow_record (stock_id, bakery_id, borrow_bakery_id, state) VALUES (?, ?, ?, ?)";
        return executeUpdate(sql, stockId, bakeryId, borrowBakeryId, state);
    }

    public FruitBorrowRecord getRecordById(int id) {
        String sql = "SELECT * FROM fruit_borrow_record WHERE id=?";
        return executeQuerySingle(sql, this::mapRecord, id);
    }

    public List<FruitBorrowRecord> getRecordsByState(int state) {
        String sql = "SELECT * FROM fruit_borrow_record WHERE state=?";
        return executeQuery(sql, this::mapRecord, state);
    }

    public List<FruitBorrowRecord> getAllRecords() {
        String sql = "SELECT * FROM fruit_borrow_record";
        return executeQuery(sql, this::mapRecord);
    }

    public List<FruitBorrowRecord> getRecordsByBakeryId(int bakeryId) {
        String sql = "SELECT * FROM fruit_borrow_record WHERE bakery_id = ?";
        return executeQuery(sql, this::mapRecord, bakeryId);
    }

    public List<FruitBorrowRecord> getRecordsByBorrowBakeryId(int borrowBakeryId) {
        String sql = "SELECT * FROM fruit_borrow_record WHERE borrow_bakery_id = ?";
        return executeQuery(sql, this::mapRecord, borrowBakeryId);
    }

    public FruitBorrowRecord getRecordByStoreId(int stockId) {
        String sql = "SELECT * FROM fruit_borrow_record WHERE stock_id = ? LIMIT 1";
        return executeQuerySingle(sql, this::mapRecord, stockId);
    }

    public boolean updateRecord(FruitBorrowRecord record) {
        String sql = "UPDATE fruit_borrow_record SET stock_id=?, bakery_id=?, borrow_bakery_id=?, state=? WHERE id=?";
        return executeUpdate(sql, record.getStockId(), record.getBakeryId(), record.getBorrowBakeryId(),record.getState(),record.getId());
    }

    public boolean deleteRecord(int id) {
        String sql = "DELETE FROM fruit_borrow_record WHERE id=?";
        return executeUpdate(sql, id);
    }

    private FruitBorrowRecord mapRecord(ResultSet rs) throws SQLException {
        FruitBorrowRecord record = new FruitBorrowRecord();
        record.setId(rs.getInt("id"));
        record.setStockId(rs.getInt("stock_id"));
        record.setBakeryId(rs.getInt("bakery_id"));
        record.setBorrowBakeryId(rs.getInt("borrow_bakery_id"));
        record.setState(rs.getInt("state"));
        return record;
    }
}