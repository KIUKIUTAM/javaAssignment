package controller;

import entity.Staff;
import db.impl.StaffDB;
import db.impl.BakeryDB;
import entity.Bakery;
import entity.Fruit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import service.FruitService;
import service.LoginService;
import java.io.PrintWriter;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet(urlPatterns = {"/fruitManagementServlet"})
public class FruitManagementServlet extends HttpServlet {
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        manage(request,response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        manage(request,response);
    }
    
    
    protected void manage(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        String action = request.getParameter("action");
        String name;
        Integer shelfLife;
        String cityName;
        Float usaDistance;
        Float japanDistance;
        Float hkDistance;
        PrintWriter out = response.getWriter();

        name = (request.getParameter("fruitName") == null) ? null : request.getParameter("fruitName");
        shelfLife = (request.getParameter("shelfLife") == null) ? null : Integer.parseInt(request.getParameter("shelfLife"));
        cityName = (request.getParameter("cityName") == null) ? null : request.getParameter("cityName");
        usaDistance = (request.getParameter("usaDistance") == null) ? null : Float.parseFloat(request.getParameter("usaDistance"));
        japanDistance = (request.getParameter("japanDistance") == null) ? null : Float.parseFloat(request.getParameter("japanDistance"));
        hkDistance = (request.getParameter("hkDistance") == null) ? null : Float.parseFloat(request.getParameter("hkDistance"));
        FruitService fruitService = new FruitService();
        if (action == null) {
            String forwardJsp = "/management/component/fruitManagement.jsp";
            request.getRequestDispatcher(forwardJsp).forward(request, response);
            return;
        }

        switch(action){
            case "add" -> {
                try{
                    Fruit fruit = new Fruit();
                    fruit.setFruitName(name);
                    fruit.setShelfLife(shelfLife);
                    fruit.setCityName(cityName);
                    fruit.setUsaWarehouseDistance(usaDistance);
                    fruit.setJapanWarehouseDistance(japanDistance);
                    fruit.setHkWarehouseDistance(hkDistance);
                    boolean success = fruitService.create(fruit);
                    String msg = success ? "Fruit created successfully!" : "Failed to create fruit. Please try again.";
                    request.setAttribute("message", msg);
                    out.println("<script>");
                        out.println("window.location.href = '" + request.getContextPath() + "/management/managementHome.jsp?loadComponent=fruitManagement';");
                        out.println("</script>");
                        out.flush();
                    } catch (Exception e){
                        out.println("<script>");
                        out.println("window.location.href = '" + request.getContextPath() + "/management/managementHome.jsp?loadComponent=fruitManagement';");
                        out.println("</script>");
                        out.flush();
                    }
            }
            case "update" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                Fruit fruit = fruitService.read(id);
                fruit.setFruitName(name);
                fruit.setShelfLife(shelfLife);
                fruit.setCityName(cityName);
                fruit.setUsaWarehouseDistance(usaDistance);
                fruit.setJapanWarehouseDistance(japanDistance);
                fruit.setHkWarehouseDistance(hkDistance);
                fruitService.update(fruit);
                String msg = "Fruit updated successfully!";
                request.setAttribute("message", msg);
                out.println("<script>");
                out.println("window.location.href = '" + request.getContextPath() + "/management/managementHome.jsp?loadComponent=fruitManagement';");
                out.println("</script>");
                out.flush();
            }
            case "delete" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                fruitService.delete(id);
                String msg = "Fruit deleted successfully!";
                request.setAttribute("message", msg);
                
                out.println("<script>");
                out.println("window.location.href = '" + request.getContextPath() + "/management/managementHome.jsp?loadComponent=fruitManagement';");
                out.println("</script>");
                out.flush();
            }
            default -> {
                out.println("<script>");
                out.println("window.location.href = '" + request.getContextPath() + "/management/managementHome.jsp?loadComponent=fruitManagement';");
                out.println("</script>");
                out.flush();
            }
        }
    }
}
