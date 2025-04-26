package controller;

import db.impl.FruitDB;
import db.impl.FruitStockRecordDB;
import service.BorrowService;
import entity.Fruit;
import entity.FruitStockRecord;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * Servlet implementation class createBorrowFruit
 */
@WebServlet("/createBorrowFruit")
public class createBorrowFruit extends HttpServlet {
    private BorrowService borrowService;
    private FruitDB fruitDB;
    private FruitStockRecordDB stockDB;

    @Override
    public void init() throws ServletException {
        // These values should match your JDBC config
        String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
        String dbUser = "root";
        String dbPass = "root";
        borrowService = new BorrowService(jdbcUrl, dbUser, dbPass);
        fruitDB = new FruitDB(jdbcUrl, dbUser, dbPass);
        stockDB = new FruitStockRecordDB(jdbcUrl, dbUser, dbPass);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String stockIdParam = request.getParameter("stockId");
        String bakeryUserId = request.getParameter("bakeryUserId");
        String borrowBakeryIdParam = request.getParameter("borrowBakeryId");
        if (stockIdParam == null || bakeryUserId == null || borrowBakeryIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Missing required parameters\"}");
            return;
        }
        try {
            int stockId = Integer.parseInt(stockIdParam);
            int borrowBakeryId = Integer.parseInt(borrowBakeryIdParam);
            boolean success = borrowService.addBorrowRecord(stockId, bakeryUserId, borrowBakeryId);
            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Borrow request approved successfully.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to approve borrow request or duplicate borrow request for this stock item.\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid numeric parameter\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }
    }
}
