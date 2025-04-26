import db.impl.StaffDB;

import db.impl.FruitDB;
import service.LoginService;
import entity.Staff;
import enums.LoginType;
import db.impl.FruitStockRecordDB;
import service.BorrowService;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Vincent
 */
public class test {
    
    
    
    public static void main(String[] args){
        String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management";
        String user = "root";
        String password = "root";
        BorrowService borrowService = new BorrowService(jdbcUrl,user,password);
        System.out.println(borrowService.updateRecordStateById(2,2));


    }

}
