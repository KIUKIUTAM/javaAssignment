package controller;

import entity.Staff;
import db.impl.StaffDB;
import db.impl.BakeryDB;
import entity.Bakery;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import service.LoginService;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet(urlPatterns = {"/createUser"})
public class CreateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String storeIdParam = request.getParameter("storeId");
        
        Integer storeId = null;
        PrintWriter out = response.getWriter();
        if (storeIdParam != null && !storeIdParam.isEmpty() ) {
            Integer storeIdTemp = Integer.parseInt(storeIdParam);
            try {
                if(storeIdTemp<=20 && storeIdTemp>=1){
                    storeId = storeIdTemp;
                }
            } catch (NumberFormatException ignored) {}
        }
        try{

        Staff staff = new Staff();
        staff.setUserId(userId);
        staff.setName(name);
        staff.setPassword(password);
        staff.setRole(role);
        staff.setStoreId(storeId);

        LoginService loginService = new LoginService();
        boolean success = loginService.registerStaff(staff);
        String msg = success ? "User created successfully!" : "Failed to create user. Please try again.";
        request.setAttribute("message", msg);
        String forwardJsp;
        if ("bakery".equalsIgnoreCase(role)) {
            forwardJsp = "/bakery/component/userCreated.jsp";
        } else {
            forwardJsp = "/warehouse/component/userCreated.jsp";
        }
        request.getRequestDispatcher(forwardJsp).forward(request, response);
        return;
        } catch (Exception e){
            request.setAttribute("message", e.getMessage());
            String forwardJsp;
            if ("bakery".equalsIgnoreCase(role)) {
                forwardJsp = "/bakery/component/userCreated.jsp";
            } else if("warehouse".equalsIgnoreCase(role)){
                forwardJsp = "/warehouse/component/userCreated.jsp";
            }else{
                forwardJsp = "/index.jsp";
            }
            request.getRequestDispatcher(forwardJsp).forward(request, response);
            return;
        }
    }
}
