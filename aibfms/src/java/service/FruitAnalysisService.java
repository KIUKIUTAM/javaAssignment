package service;

import db.impl.FruitAnalysisDB;
import java.util.*;

public class FruitAnalysisService {
    private final FruitAnalysisDB fruitAnalysisDB;
    
    public FruitAnalysisService() {
        this.fruitAnalysisDB = new FruitAnalysisDB("jdbc:mysql://localhost:3306/bakery_management?useSSL=false", "root", "root");
    }
    

    public List<Map<String, Object>> getBakeryFruitConsumption(int year) {
        return fruitAnalysisDB.getBakeryFruitConsumption(year);
    }
    

    public List<Map<String, Object>> getBakeryFruitReservation(int year) {
        return fruitAnalysisDB.getBakeryFruitReservation(year);
    }
    

    public List<Map<String, Object>> getMonthlyFruitConsumption() {
        return fruitAnalysisDB.getMonthlyFruitConsumption();
    }
    

    public List<Map<String, Object>> getCityFruitConsumption() {
        return fruitAnalysisDB.getCityFruitConsumption();
    }
} 