package db.impl;

import entity.Bakery;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;
import java.util.Map;


public class BakeryDB extends BaseDB {
    public BakeryDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public Bakery getBakeryById(int bakeryId) {
        String sql = "SELECT * FROM bakery WHERE id = ?";
        return executeQuerySingle(sql, this::mapBakery, bakeryId);
    }

    // Get all bakeries
    public List<Bakery> getAllBakeries() {
        String sql = "SELECT * FROM bakery";
        return executeQuery(sql, this::mapBakery);
    }


    public List<Map<String, Object>> getCityByBakeryUserId(String bakeryUserId) {
        String sql = "Select * from cities c  ,bakery b,staff  WHERE c.id = b.city_id AND staff.store_id = b.id AND staff.user_id = ?";
        return executeQueryToMapList(sql, bakeryUserId);
    }

    private Bakery mapBakery(ResultSet rs) throws SQLException {
        Bakery bakery = new Bakery();
        bakery.setId(rs.getInt("id"));
        bakery.setName(rs.getString("name"));
        bakery.setLocation(rs.getString("location"));
        bakery.setCityId(rs.getInt("city_id"));
        return bakery;
    }
}
