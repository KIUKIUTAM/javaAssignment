
import java.util.List;

import service.BorrowService;
import db.impl.StaffDB;
import entity.Staff;
import service.BakeryStoreService;
import entity.Bakery;
import service.StockService;
import java.util.Map;
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
//        BorrowService borrowService = new BorrowService(jdbcUrl,user,password);
//        System.out.println(borrowService.updateRecordStateById(2,2));
//        StaffDB staffDB = new StaffDB(jdbcUrl,user,password);
//        List<Staff> staffList = staffDB.getAllStaff();
//        System.out.println(staffList);
//        List<Bakery> bakeryList = new BakeryStoreService().getAllBakeries();
        StockService stockSerice = new StockService();
        List<Map<String,Object>> stockRecords = stockSerice.getStockRecordsGroupByFruitByBakeryId("ss123");
        System.out.println(stockRecords);
        System.out.println(System.currentTimeMillis());
    }
}
