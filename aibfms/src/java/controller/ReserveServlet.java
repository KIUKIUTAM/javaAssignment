package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.FruitReserveRecord;
import java.io.IOException;
import java.io.PrintWriter;
import service.ReserveService;

/**
 * Servlet implementation class ReserveServlet
 */@WebServlet(name = "ReserveServlet", urlPatterns = {"/createReserveOrder"})
public class ReserveServlet extends HttpServlet {
    ReserveService reserveService;
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        reserveService = new ReserveService();
        
        if ("reserve".equals(action)) {  // Fixed string comparison
            try {
                int fruitId = Integer.parseInt(request.getParameter("fruitId"));
                String bakeryUserId = request.getParameter("bakeryUserId");
                double quantity = Double.parseDouble(request.getParameter("quantity"));
                double originToWarehouse = Double.parseDouble(request.getParameter("originToWarehouse"));
                boolean success = reserveService.addReserveRecord(fruitId, bakeryUserId, quantity,originToWarehouse);
                
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"Reservation successful.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Reservation failed.\"}");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Error1: " + e.getMessage() + "\"}");
            } finally {
                out.flush();
                out.close();
            }
        } else if ("StoreConfirm".equals(action)) {  
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success1 = reserveService.updateReserveRecord(id, 6); 
                // Check-in
                FruitReserveRecord record = reserveService.getRecordById(id);
                boolean success2 = reserveService.addStockRecord(record.getFruitId(), record.getBakeryId(), record.getQuantity());
                if( success2 && success1) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"Order confirmed successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Failed to confirm order.\"}");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Error2: " + e.getMessage() + "\"}");
            } finally {
                out.flush();
                out.close();
            }
        } else if ("updateState".equals(action)) {  
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int state = Integer.parseInt(request.getParameter("state"));
                String country = request.getParameter("country");
                boolean success = reserveService.updateReserveRecordByCountry(id, state, country); 
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"Order confirmed successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Failed to confirm order.\"}");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Error2: " + e.getMessage() + "\"}");
            } finally {
                out.flush();
                out.close();
            }
        } else if ("approveAllCountryOrders".equals(action)) {
            try {
                String country = request.getParameter("country");
                boolean success = reserveService.approveAllCountryOrders(country);
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"All orders approved successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Failed to approve all orders.\"}");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Error3: " + e.getMessage() + "\"}");
            }
        } else if ("updateState1".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int state = Integer.parseInt(request.getParameter("state"));
                boolean success = reserveService.updateReserveRecord(id, state); 
                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    out.print("{\"success\":true,\"message\":\"Order confirmed successfully.\"}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"success\":false,\"message\":\"Failed to confirm order.\"}");
                }
            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\":false,\"message\":\"Error2: " + e.getMessage() + "\"}");
            } finally {
                out.flush();
                out.close();
            }
        }
    }
}
