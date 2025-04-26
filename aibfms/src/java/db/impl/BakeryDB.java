package db.impl;

import entity.Bakery;
import java.sql.ResultSet;
import java.sql.SQLException;
import db.BaseDB;

public class BakeryDB extends BaseDB {
    public BakeryDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public Bakery getBakeryById(int bakeryId) {
        String sql = "SELECT * FROM bakery WHERE id = ?";
        return executeQuerySingle(sql, this::mapBakery, bakeryId);
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
