package db.impl;

import entity.CentreWarehouse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;

public class CentreWarehouseDB extends BaseDB {

    public CentreWarehouseDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public boolean addWarehouse(String name, String location) {
        String sql = "INSERT INTO centre_warehouse (name, location) VALUES (?, ?)";
        return executeUpdate(sql, name, location);
    }

    public CentreWarehouse getWarehouseById(int id) {
        String sql = "SELECT * FROM centre_warehouse WHERE id=?";
        return executeQuerySingle(sql, this::mapWarehouse, id);
    }

    public List<CentreWarehouse> getAllWarehouses() {
        String sql = "SELECT * FROM centre_warehouse";
        return executeQuery(sql, this::mapWarehouse);
    }

    public boolean updateWarehouse(CentreWarehouse warehouse) {
        String sql = "UPDATE centre_warehouse SET name=?, location=? WHERE id=?";
        return executeUpdate(sql, warehouse.getName(), warehouse.getLocation(), warehouse.getId());
    }

    public boolean deleteWarehouse(int id) {
        String sql = "DELETE FROM centre_warehouse WHERE id=?";
        return executeUpdate(sql, id);
    }

    private CentreWarehouse mapWarehouse(ResultSet rs) throws SQLException {
        CentreWarehouse warehouse = new CentreWarehouse();
        warehouse.setId(rs.getInt("id"));
        warehouse.setName(rs.getString("name"));
        warehouse.setLocation(rs.getString("location"));
        return warehouse;
    }
}