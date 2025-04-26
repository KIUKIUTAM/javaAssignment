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

    public boolean addFruit(String fruitName, int shelfLife, int cityId) {
        String sql = "INSERT INTO fruits (fruit_name, shelf_life, city_id) VALUES (?, ?, ?)";
        return executeUpdate(sql, fruitName, shelfLife, cityId);
    }

    public Fruit getFruitById(int id) {
        String sql = "SELECT * FROM fruits WHERE id=?";
        return executeQuerySingle(sql, this::mapFruit, id);
    }

    public List<Fruit> getFruitsByCity(int cityId) {
        String sql = "SELECT * FROM fruits WHERE city_id=?";
        return executeQuery(sql, this::mapFruit, cityId);
    }

    public List<Fruit> getAllFruits() {
        String sql = "SELECT * FROM fruits";
        return executeQuery(sql, this::mapFruit);
    }

    public boolean updateFruit(Fruit fruit) {
        String sql = "UPDATE fruits SET fruit_name=?, shelf_life=?, city_id=? WHERE id=?";
        return executeUpdate(sql, fruit.getFruitName(), fruit.getShelfLife(), 
                           fruit.getCityId(), fruit.getId());
    }

    public boolean deleteFruit(int id) {
        String sql = "DELETE FROM fruits WHERE id=?";
        return executeUpdate(sql, id);
    }

    public List<Map<String, Object>> getAllFruitsWithCity(){
        String sql = "Select * FROM fruits,cities WHERE fruits.city_id = cities.id";
        return executeQueryToMapList(sql);
    }

    private Fruit mapFruit(ResultSet rs) throws SQLException {
        Fruit fruit = new Fruit();
        fruit.setId(rs.getInt("id"));
        fruit.setFruitName(rs.getString("fruit_name"));
        fruit.setShelfLife(rs.getInt("shelf_life"));
        fruit.setCityId(rs.getInt("city_id"));
        return fruit;
    }


}