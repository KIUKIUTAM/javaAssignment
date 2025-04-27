/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.impl.BakeryDB;
import entity.Bakery;
import java.util.List;
import java.util.Map;


/**
 *
 * @author Vincent
 */
public class BakeryStoreService {
    
    
    BakeryDB bakeryDB;

    // Default constructor for JSP useBean
    public BakeryStoreService() {
        // Set your DB connection info here
        bakeryDB = new BakeryDB("jdbc:mysql://localhost:3306/bakery_management?useSSL=false", "root", "root");
    }


    public List<Bakery> getAllBakeries() {
        return bakeryDB.getAllBakeries();
    }

    public List<Map<String, Object>> getCityByBakeryUserId(String bakeryUserId) {
        return bakeryDB.getCityByBakeryUserId(bakeryUserId);
    }


}
