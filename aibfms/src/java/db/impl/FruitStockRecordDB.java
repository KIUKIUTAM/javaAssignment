package db.impl;

import entity.FruitStockRecord;
import entity.Bakery;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;

public class FruitStockRecordDB extends BaseDB {
    BakeryDB bakeryDB;
    public FruitStockRecordDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
        bakeryDB = new BakeryDB(jdbcUrl, username, password);
    }


    public boolean addRecord(int fruitId, int bakeryId, double quantityKg, 
                           java.sql.Date expiredDate) {
        String sql = "INSERT INTO fruit_stock_record (fruit_id, bakery_id, quantity_kg, expired_date) "
                   + "VALUES (?, ?, ?, ?)";
        return executeUpdate(sql, fruitId, bakeryId, quantityKg, expiredDate);
    }

    public FruitStockRecord getRecordById(int id) {
        String sql = "SELECT * FROM fruit_stock_record WHERE id=?";
        return executeQuerySingle(sql, this::mapRecord, id);
    }

    public List<FruitStockRecord> getRecordsByBakeryId(int bakeryId) {
        String sql = "SELECT * FROM fruit_stock_record WHERE bakery_id=?";
        return executeQuery(sql, this::mapRecord, bakeryId);
    }

    public List<FruitStockRecord> getExpiringSoonRecords(int days) {
        String sql = "SELECT * FROM fruit_stock_record WHERE expired_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL ? DAY)";
        return executeQuery(sql, this::mapRecord, days);
    }

    public List<FruitStockRecord> getAllRecords() {
        String sql = "SELECT * FROM fruit_stock_record";
        return executeQuery(sql, this::mapRecord);
    }


    // Returns all stock records that are not borrowed, not from the current bakery (self), and in the same city as the bakery store (not fruit)
    public List<FruitStockRecord> getAllRecordsExcludingBorrowedAndSelfSameBakeryCity(int selfBakeryStoreId) {
        Bakery bakery = bakeryDB.getBakeryById(selfBakeryStoreId);
        if (bakery == null) {
            System.err.println("[FruitStockRecordDB] Bakery not found for ID: " + selfBakeryStoreId);
            return java.util.Collections.emptyList();
        }
        String sql = "SELECT fsr.* FROM fruit_stock_record fsr " +
                     "JOIN bakery b ON fsr.bakery_id = b.id " +
                     "WHERE fsr.borrow_record IS NULL AND fsr.bakery_id <> ? AND fsr.quantity_kg > 0 AND b.city_id = ?";
        return executeQuery(sql, this::mapRecord, selfBakeryStoreId, bakery.getCityId());
    }

    public boolean updateRecord(FruitStockRecord record) {
        String sql = "UPDATE fruit_stock_record SET fruit_id=?, bakery_id=?, quantity_kg=?, "
                   + "expired_date=?, borrow_record=? WHERE id=?";
        return executeUpdate(sql, record.getFruitId(), record.getBakeryId(), 
                           record.getQuantityKg(), record.getExpiredDate(), 
                           record.getBorrowRecord(), record.getId());
    }

    public boolean deleteRecord(int id) {
        String sql = "DELETE FROM fruit_stock_record WHERE id=?";
        return executeUpdate(sql, id);
    }

    private FruitStockRecord mapRecord(ResultSet rs) throws SQLException {
        FruitStockRecord record = new FruitStockRecord();
        record.setId(rs.getInt("id"));
        record.setFruitId(rs.getInt("fruit_id"));
        record.setBakeryId(rs.getInt("bakery_id"));
        record.setQuantityKg(rs.getDouble("quantity_kg"));
        record.setExpiredDate(rs.getDate("expired_date"));
        record.setBorrowRecord(rs.getInt("borrow_record"));
        record.setCreatedAt(rs.getTimestamp("created_at"));
        record.setUpdatedAt(rs.getTimestamp("updated_at"));
        return record;
    }
}