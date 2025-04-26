package controller;

import db.impl.FruitDB;
import db.impl.FruitStockRecordDB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import entity.FruitStockRecord;

import java.io.IOException;
import service.BorrowService;

@WebServlet("/approveBorrowRequest")
public class approveBorrowRequest extends HttpServlet {
    private BorrowService borrowService;
    private FruitStockRecordDB stockDB;

    @Override
    public void init() throws ServletException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
        String dbUser = "root";
        String dbPass = "root";
        borrowService = new BorrowService(jdbcUrl, dbUser, dbPass);
        stockDB = new FruitStockRecordDB(jdbcUrl, dbUser, dbPass);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try {

            String borrowIdParam = request.getParameter("borrowId");
            String stateParam = request.getParameter("state");
            int bakeryStoreId = Integer.parseInt(request.getParameter("bakeryStoreId"));
            if (borrowIdParam == null || stateParam == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Missing required parameters\"}");
                return;
            }

            int borrowId = Integer.parseInt(borrowIdParam);
            int state = Integer.parseInt(stateParam);

            if (state != 1 && state != 2) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid state parameter\"}");
                return;
            }

            boolean updated = borrowService.updateRecordStateById(borrowId, state);
            if (state == 1) {
                int stockId = borrowService.getRecordById(borrowId).getStockId();
                borrowService.updateStockBorrowId(stockId, bakeryStoreId);
            }
            if (updated) {
                response.getWriter().write("{\"success\": true, \"message\": \"Borrow request updated successfully.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update borrow request\"}");
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
