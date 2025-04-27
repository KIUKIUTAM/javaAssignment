package db.impl;

import entity.Fruit;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;
import java.util.Map;

public class FruitDB extends BaseDB {

    public FruitDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public boolean addFruit(String fruitName, int shelfLife, String cityName, 
                          float usaDistance, float japanDistance, float hkDistance) {
        String sql = "INSERT INTO fruits (fruit_name, shelf_life, city_name, " +
                    "usa_warehouse_distance, japan_warehouse_distance, hk_warehouse_distance) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        return executeUpdate(sql, fruitName, shelfLife, cityName, 
                           usaDistance, japanDistance, hkDistance);
    }

    public Fruit getFruitById(int id) {
        String sql = "SELECT * FROM fruits WHERE id=?";
        return executeQuerySingle(sql, this::mapFruit, id);
    }

    public List<Fruit> getAllFruits() {
        String sql = "SELECT * FROM fruits";
        return executeQuery(sql, this::mapFruit);
    }

    public boolean updateFruit(Fruit fruit) {
        String sql = "UPDATE fruits SET fruit_name=?, shelf_life=?, city_name=?, " +
                    "usa_warehouse_distance=?, japan_warehouse_distance=?, hk_warehouse_distance=? " +
                    "WHERE id=?";
        return executeUpdate(sql, fruit.getFruitName(), fruit.getShelfLife(), 
                           fruit.getCityName(), fruit.getUsaWarehouseDistance(),
                           fruit.getJapanWarehouseDistance(), fruit.getHkWarehouseDistance(),
                           fruit.getId());
    }

    public boolean deleteFruit(int id) {
        String sql = "DELETE FROM fruits WHERE id=?";
        return executeUpdate(sql, id);
    }

    public List<Map<String, Object>> getAllFruitsWithDetails() {
        String sql = "SELECT f.id, f.fruit_name, f.shelf_life, f.city_name, " +
                    "f.usa_warehouse_distance, f.japan_warehouse_distance, f.hk_warehouse_distance " +
                    "FROM fruits f " +
                    "ORDER BY f.fruit_name";
        return executeQueryToMapList(sql);
    }

    private Fruit mapFruit(ResultSet rs) throws SQLException {
        Fruit fruit = new Fruit();
        fruit.setId(rs.getInt("id"));
        fruit.setFruitName(rs.getString("fruit_name"));
        fruit.setShelfLife(rs.getInt("shelf_life"));
        fruit.setCityName(rs.getString("city_name"));
        fruit.setUsaWarehouseDistance(rs.getFloat("usa_warehouse_distance"));
        fruit.setJapanWarehouseDistance(rs.getFloat("japan_warehouse_distance"));
        fruit.setHkWarehouseDistance(rs.getFloat("hk_warehouse_distance"));
        return fruit;
    }
}