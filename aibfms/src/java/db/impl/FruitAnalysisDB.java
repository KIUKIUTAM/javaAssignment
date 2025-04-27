package db.impl;

import db.BaseDB;
import java.util.List;
import java.util.Map;

public class FruitAnalysisDB extends BaseDB {
    
    public FruitAnalysisDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }
    
    public List<Map<String, Object>> getBakeryFruitConsumption(int year) {
        String sql = """
            SELECT 
                b.name AS bakery_name,
                f.fruit_name,
                SUM(fs.quantity_kg) AS total_consumed
            FROM 
                fruit_stock_record fs
            JOIN 
                bakery b ON fs.bakery_id = b.id
            JOIN 
                fruits f ON fs.fruit_id = f.id
            WHERE 
                fs.updated_at >= ? AND fs.updated_at <= ?
            GROUP BY 
                b.name, f.fruit_name
        """;
        return executeQueryToMapList(sql, year + "-01-01", year + "-12-31");
    }
    
    public List<Map<String, Object>> getBakeryFruitReservation(int year) {
        String sql = """
            SELECT 
                b.name AS bakery_name,
                f.fruit_name,
                SUM(fr.quantity) AS total_reserved,
                fr.state
            FROM 
                fruit_reserve_record fr
            JOIN 
                bakery b ON fr.bakery_id = b.id
            JOIN 
                fruits f ON fr.fruit_id = f.id
            WHERE 
                fr.create_date >= ? AND fr.create_date <= ?
            GROUP BY 
                b.name, f.fruit_name, fr.state
        """;
        return executeQueryToMapList(sql, year + "-01-01", year + "-12-31");
    }
    
    public List<Map<String, Object>> getMonthlyFruitConsumption() {
        String sql = """
            SELECT 
                DATE_FORMAT(fs.updated_at, '%Y-%m') AS month,
                b.name AS bakery_name,
                f.fruit_name,
                SUM(fs.quantity_kg) AS monthly_consumed
            FROM 
                fruit_stock_record fs
            JOIN 
                bakery b ON fs.bakery_id = b.id
            JOIN 
                fruits f ON fs.fruit_id = f.id
            GROUP BY 
                month, b.name, f.fruit_name
            ORDER BY 
                month
        """;
        return executeQueryToMapList(sql);
    }
    
    public List<Map<String, Object>> getCityFruitConsumption() {
        String sql = """
            SELECT 
                c.city,
                f.fruit_name,
                SUM(fs.quantity_kg) AS total_consumed
            FROM 
                fruit_stock_record fs
            JOIN 
                bakery b ON fs.bakery_id = b.id
            JOIN 
                cities c ON b.city_id = c.id
            JOIN 
                fruits f ON fs.fruit_id = f.id
            GROUP BY 
                c.city, f.fruit_name
        """;
        return executeQueryToMapList(sql);
    }
}
