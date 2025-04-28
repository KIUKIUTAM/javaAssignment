/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import entity.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import service.LoginService;
import enums.LoginType;
import java.util.Map;
import service.BakeryStoreService;

/**
 *
 * @author Vincent
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

    LoginService loginService;
    BakeryStoreService bakeryStoreService;
    @Override
    public void init() {
        loginService = new LoginService();
        bakeryStoreService = new BakeryStoreService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String userId = request.getParameter("userId");
        String rawPassword = request.getParameter("password");
        int type = Integer.parseInt(request.getParameter("type"));
        LoginType typeE = convertType(type);
        Staff staff = loginService.loginValidate(userId, rawPassword, typeE);
        if (staff != null) {
            session.setMaxInactiveInterval(60 * 60 * 24);
            switch (staff.getRole()) {
                case "bakery" -> {
                    session.setAttribute("bakeryUserId", staff.getUserId());
                    session.setAttribute("storeId", staff.getStoreId());
                    session.setAttribute("country", bakeryStoreService.getCityByBakeryUserId(staff.getUserId()).get(0).get("country"));
                    
                    response.sendRedirect("bakery/bakeryHome.jsp");
                }
                case "warehouse" -> {
                    session.setAttribute("warehouseUserId", staff.getUserId());
                    response.sendRedirect("warehouse/warehouseHome.jsp");                
                }
                case "management" -> {
                    session.setAttribute("managementUserId", staff.getUserId());
                    response.sendRedirect("management/managementHome.jsp");       
                }
                default ->{
                    request.setAttribute("loginError", "Invalid credentials");
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                }
            }
        }
        else{
            request.setAttribute("loginError", "Invalid credentials");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    private enums.LoginType convertType(int type) {
        switch (type) {
            case 1 -> {
                return enums.LoginType.BAKERY;
            }
            case 2 -> {
                return enums.LoginType.WAREHOUSE;
            }
            case 3 -> {
                return enums.LoginType.MANAGEMENT;
            }
        }
        return null;
    }
}
