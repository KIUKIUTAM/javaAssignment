package db.impl;

import entity.FruitReserveRecord;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import db.BaseDB;
import java.util.Date;

public class FruitReserveRecordDB extends BaseDB {

    public FruitReserveRecordDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public FruitReserveRecord addRecord(int fruitId, int bakeryId, int state, double quantity) {
        String sql = "INSERT INTO fruit_reserve_record (fruit_id, bakery_id, state, quantity) VALUES (?, ?, ?, ?)";
        if (executeUpdate(sql, fruitId, bakeryId, state, quantity)) {
            String getLastRecordSql = "SELECT * FROM fruit_reserve_record WHERE fruit_id = ? AND bakery_id = ? ORDER BY id DESC LIMIT 1";
            return executeQuerySingle(getLastRecordSql, this::mapRecord, fruitId, bakeryId);
        }
        return null;
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
        String sql = "UPDATE fruit_reserve_record SET fruit_id=?, bakery_id=?, state=?, quantity=? WHERE id=?";
        return executeUpdate(sql, record.getFruitId(), record.getBakeryId(), 
                           record.getState(), record.getQuantity(), record.getId());
    }


    public boolean updateOriginToWarehouse(int id, double originToWarehouse) {
        String sql = "UPDATE fruit_reserve_record SET origin_to_warehouse=? WHERE id=?";
        return executeUpdate(sql, originToWarehouse, id);
    }

    public boolean updateWarehouseToStore(int id, double warehouseToStore) {
        String sql = "UPDATE fruit_reserve_record SET warehouse_to_store=? WHERE id=?";
        return executeUpdate(sql, warehouseToStore, id);
    }

    public boolean updateArrivalDate(int id, Date arrivalDate) {
        String sql = "UPDATE fruit_reserve_record SET arrival_date=? WHERE id=?";
        return executeUpdate(sql, arrivalDate, id);
    }

    public boolean approveAllCountryOrders(String country) {
        String sql = "UPDATE fruit_reserve_record SET state=? WHERE country = ? AND state = 0";
        return executeUpdate(sql, 2, country);
    }

    public List<Map<String, Object>> getRecordsByCountry(String country) {
        String sql = "SELECT fr.id, fruit_id , fruit_name, bakery_id, state, quantity, create_date , arrival_date , origin_to_warehouse, country   FROM fruit_reserve_record fr, bakery b,cities c, fruits f WhERE fr.bakery_id = b.id AND b.city_id = c.id AND fr.fruit_id = f.id AND country = ? ;";
        return executeQueryToMapList(sql, country);
    }

    public boolean updateRecordByCountry(int id, int state, String country) {
        String sql = "UPDATE fruit_reserve_record f, bakery b, cities c SET f.state=? WHERE f.bakery_id = b.id AND b.city_id = c.id AND  f.id= ? AND c.country = ?";
        return executeUpdate(sql, state, id, country);
    }
        


    private FruitReserveRecord mapRecord(ResultSet rs) throws SQLException {
        FruitReserveRecord record = new FruitReserveRecord();
        record.setId(rs.getInt("id"));
        record.setFruitId(rs.getInt("fruit_id"));
        record.setBakeryId(rs.getInt("bakery_id"));
        record.setState(rs.getInt("state"));
        record.setQuantity(rs.getDouble("quantity"));
        record.setCreateDate(rs.getTimestamp("create_date"));
        Timestamp arrivalDate = rs.getTimestamp("arrival_date");
        if (arrivalDate != null) {
            record.setArrivalDate(new Date(arrivalDate.getTime()));
        }

        double originToWarehouse = rs.getDouble("origin_to_warehouse");
        if (!rs.wasNull()) {
            record.setOriginToWarehouse(originToWarehouse);
        }

        double warehouseToStore = rs.getDouble("warehouse_ro_store");
        if (!rs.wasNull()) {
            record.setWarehouseToStore(warehouseToStore);
        }
        
        return record;
    }
}