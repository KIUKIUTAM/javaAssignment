package controller;

import entity.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.StaffService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "StaffServlet", urlPatterns = {"/StaffServlet"})
public class StaffServlet extends HttpServlet {

    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            sendJsonResponse(response, false, "No action specified");
            return;
        }

        try {
            switch (action) {
                case "add":
                    handleAddStaff(request, response);
                    break;
                case "update":
                    handleUpdateStaff(request, response);
                    break;
                case "getForEdit":
                    handleGetStaff(request, response);
                    break;
                case "delete":
                    handleDeleteStaff(request, response);
                    break;
                default:
                    sendJsonResponse(response, false, "Invalid action: " + action);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(response, false, "Error: " + e.getMessage());
        }
    }

    private void handleGetStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        Staff staff = staffService.getStaffById(userId);

        if (staff != null) {
            String jsonStaff = convertStaffToJson(staff);
            String jsonResponse = String.format("{\"success\":true,\"data\":%s}", jsonStaff);
            sendRawJsonResponse(response, jsonResponse);
        } else {
            sendJsonResponse(response, false, "Staff not found");
        }
    }

    private void handleAddStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Staff staff = new Staff();
        staff.setUserId(request.getParameter("userId"));
        staff.setName(request.getParameter("name"));
        staff.setPassword(request.getParameter("password"));
        staff.setRole(request.getParameter("role"));
        
        String storeIdStr = request.getParameter("storeId");
        if (storeIdStr != null && !storeIdStr.trim().isEmpty()) {
            try {
                staff.setStoreId(Integer.parseInt(storeIdStr));
            } catch (NumberFormatException e) {
                sendJsonResponse(response, false, "Invalid store ID format");
                return;
            }
        } else {
            staff.setStoreId(null);
        }

        if (staffService.addStaff(staff)) {
            sendJsonResponse(response, true, "Staff added successfully");
        } else {
            sendJsonResponse(response, false, "Failed to add staff. User ID may already exist.");
        }
    }

    private void handleUpdateStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String userId = request.getParameter("userId");
            if (userId == null || userId.trim().isEmpty()) {
                sendJsonResponse(response, false, "User ID is required");
                return;
            }

            Staff existingStaff = staffService.getStaffById(userId);
            if (existingStaff == null) {
                sendJsonResponse(response, false, "Staff not found");
                return;
            }

            Staff staff = new Staff();
            staff.setUserId(userId);
            staff.setName(request.getParameter("name"));
            staff.setRole(request.getParameter("role"));

            String password = request.getParameter("password");
            if (password != null && !password.trim().isEmpty()) {
                staff.setPassword(password);
            } else {
                staff.setPassword(existingStaff.getPassword());
            }

            String storeIdStr = request.getParameter("storeId");
            if (storeIdStr != null && !storeIdStr.trim().isEmpty()) {
                try {
                    int storeId = Integer.parseInt(storeIdStr);
                    if (storeId >= 1 && storeId <= 20) {
                        staff.setStoreId(storeId);
                    } else {
                        staff.setStoreId(null);
                    }
                } catch (NumberFormatException e) {
                    sendJsonResponse(response, false, "Invalid store ID format");
                    return;
                }
            } else {
                staff.setStoreId(null);
            }

            if (staffService.updateStaff(staff)) {
                sendJsonResponse(response, true, "Staff updated successfully");
            } else {
                sendJsonResponse(response, false, "Failed to update staff");
            }
        } catch (Exception e) {
            e.printStackTrace();
            sendJsonResponse(response, false, "Error updating staff: " + e.getMessage());
        }
    }

    private void handleDeleteStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("userId");
        if (staffService.deleteStaff(userId)) {
            sendJsonResponse(response, true, "Staff deleted successfully");
        } else {
            sendJsonResponse(response, false, "Failed to delete staff");
        }
    }

    private String convertStaffToJson(Staff staff) {
        return String.format(
            "{\"userId\":\"%s\",\"name\":\"%s\",\"role\":\"%s\",\"storeId\":%s}",
            escapeJson(staff.getUserId()),
            escapeJson(staff.getName()),
            escapeJson(staff.getRole()),
            staff.getStoreId() != null ? staff.getStoreId() : "null"
        );
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        String jsonResponse = String.format("{\"success\":%s,\"message\":\"%s\"}", 
            success ? "true" : "false", 
            escapeJson(message)
        );
        sendRawJsonResponse(response, jsonResponse);
    }

    private void sendRawJsonResponse(HttpServletResponse response, String jsonString) throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonString);
            out.flush();
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\b", "\\b")
                   .replace("\f", "\\f")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }

    @Override
    public String getServletInfo() {
        return "Staff Management Servlet";
    }
}