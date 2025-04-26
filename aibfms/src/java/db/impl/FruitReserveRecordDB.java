package db.impl;

import entity.FruitReserveRecord;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import db.BaseDB;

public class FruitReserveRecordDB extends BaseDB {

    public FruitReserveRecordDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public boolean addRecord(int fruitId, int bakeryId, int state, double quantity) {
        String sql = "INSERT INTO fruit_reserve_record (fruit_id, bakery_id, state, quantity) VALUES (?, ?, ?, ?)";
        return executeUpdate(sql, fruitId, bakeryId, state, quantity);
    }

    public FruitReserveRecord getRecordById(int id) {
        String sql = "SELECT * FROM fruit_reserve_record WHERE id=?";
        return executeQuerySingle(sql, this::mapRecord, id);
    }

    public List<Map<String, Object>> getRecordsByState(int state) {
        String sql = "SELECT * FROM fruit_reserve_record WHERE state=?";
        return executeQueryToMapList(sql, state);
    }

    public List<Map<String, Object>> getAllRecords() {
        String sql = "SELECT r.*, f.fruit_name FROM fruit_reserve_record r JOIN fruits f ON r.fruit_id = f.id";
        return executeQueryToMapList(sql);
    }

    public List<Map<String, Object>> getRecordsByBakeryId(int bakeryId) {
        String sql = "SELECT r.*, f.fruit_name FROM fruit_reserve_record r JOIN fruits f ON r.fruit_id = f.id WHERE r.bakery_id=?";
        return executeQueryToMapList(sql, bakeryId);
    }

    public List<Map<String, Object>> getRecordsByFruitId(int fruitId) {
        String sql = "SELECT r.*, f.fruit_name FROM fruit_reserve_record r JOIN fruits f ON r.fruit_id = f.id WHERE r.fruit_id=?";
        return executeQueryToMapList(sql, fruitId);
    }

    public boolean updateRecord(int id, int state) {
        String sql = "UPDATE fruit_reserve_record SET state=? WHERE id=?";
        return executeUpdate(sql, state, id);
    }

    public boolean deleteRecord(int id) {
        String sql = "DELETE FROM fruit_reserve_record WHERE id=?";
        return executeUpdate(sql, id);
    }

    public boolean updateRecord(FruitReserveRecord record) {
        String sql = "UPDATE fruit_reserve_record SET fruit_id=?, bakery_id=?, state=?, quantity=?"
                + "approve_date=?, delivery_date=? WHERE id=?";
        return executeUpdate(sql, record.getFruitId(), record.getBakeryId(), 
                           record.getState(),record.getQuantity(), record.getApproveDate(), 
                           record.getDeliveryDate(), record.getId());
    }

    private FruitReserveRecord mapRecord(ResultSet rs) throws SQLException {
        FruitReserveRecord record = new FruitReserveRecord();
        record.setId(rs.getInt("id"));
        record.setFruitId(rs.getInt("fruit_id"));
        record.setBakeryId(rs.getInt("bakery_id"));
        record.setState(rs.getInt("state"));
        record.setQuantity(rs.getDouble("quantity"));
        record.setCreateDate(rs.getTimestamp("create_date"));
        record.setApproveDate(rs.getTimestamp("approve_date"));
        record.setDeliveryDate(rs.getTimestamp("delivery_date"));
        return record;
    }
}