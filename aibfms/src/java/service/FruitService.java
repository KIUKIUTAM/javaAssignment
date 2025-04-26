package service;

import db.impl.FruitDB;
import entity.Fruit;
import java.util.List;
import java.util.Map;

public class FruitService{
    private FruitDB fruitDB;
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String username = "root";
    String password = "root";



    public FruitService() {
        fruitDB = new FruitDB(jdbcUrl, username, password);
    }

    public boolean create(Fruit entity) {
        return fruitDB.addFruit(entity.getFruitName(), entity.getShelfLife(), entity.getCityId());
    }

    public Fruit read(int id) {
        return fruitDB.getFruitById(id);
    }

    public List<Fruit> readAll() {
        return fruitDB.getAllFruits();
    }

    public boolean update(Fruit entity) {
        return fruitDB.updateFruit(entity);
    }
    
    public boolean delete(int id) {
        return fruitDB.deleteFruit(id);
    }

    public List<Map<String, Object>> getAllFruitsWithCity() {
        return fruitDB.getAllFruitsWithCity();
    }
}
