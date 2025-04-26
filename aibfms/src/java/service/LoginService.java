/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import db.impl.StaffDB;
import entity.Staff;
import enums.LoginType;

/**
 *
 * @author Vincent
 */
public class LoginService {
    
    StaffDB staffDB;
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String user = "root";
    String password = "root";
    public LoginService(){
        staffDB = new StaffDB(jdbcUrl, user, password);
    }

    public Staff loginValidate(String userId, String password, LoginType type) {
        // Convert LoginType enum to lowercase string for DB
        String role = type.getDisplayName().toLowerCase();
        return staffDB.getStaffByCredentials(userId, password, role);
    }
}
