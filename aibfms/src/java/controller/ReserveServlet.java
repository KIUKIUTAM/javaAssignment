package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import service.ReserveService;

/**
 * Servlet implementation class ReserveServlet
 */
@WebServlet(name = "ReserveServlet", urlPatterns = {"/createReserveOrder"})
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
        if ("reserve".equals(action)) {
            
        try {
            int fruitId = Integer.parseInt(request.getParameter("fruitId"));
            String bakeryUserId = request.getParameter("bakeryUserId");
            double quantity = Double.parseDouble(request.getParameter("quantity"));
            boolean success = reserveService.addReserveRecord(fruitId, bakeryUserId,quantity);
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\":true,\"message\":\"Reservation successful.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Reservation failed.\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
        }else if ("StoreConfirm".equals(action)) {
            
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = reserveService.updateReserveRecord(id, 6); // 6 means Completed
            if (success) {
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\":true,\"message\":\"Order confirmed successfully.\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\":false,\"message\":\"Failed to confirm order.\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"success\":false,\"message\":\"Error: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
        }
    }
}
