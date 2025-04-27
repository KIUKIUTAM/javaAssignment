package service;

import db.impl.StaffDB;
import entity.Staff;
import java.util.List;

public class StaffService {
    StaffDB staffDB;
    
    public StaffService() {
        String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
        String user = "root";
        String password = "root";
        staffDB = new StaffDB(jdbcUrl, user, password);
    }

    public List<Staff> getAllStaff() {
        return staffDB.getAllStaff();
    }

    public Staff getStaffById(String userId) {
        return staffDB.getStaffByUserId(userId);
    }

    public boolean addStaff(Staff staff) {
        if (staffDB.getStaffByUserId(staff.getUserId()) != null) {
            return false;
        }
        return staffDB.addStaff(staff);
    }

    public boolean updateStaff(Staff staff) {
        return staffDB.updateStaff(staff);
    }

    public boolean deleteStaff(String userId) {
        return staffDB.editStaffRole(userId, "none");
    }
}
