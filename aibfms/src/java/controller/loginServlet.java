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

/**
 *
 * @author Vincent
 */
@WebServlet(name = "loginServlet", urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {

    LoginService loginService;

    @Override
    public void init() {
        loginService = new LoginService();
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
            session.setMaxInactiveInterval(30 * 60);
            switch (staff.getRole()) {
                case "bakery" -> {
                    session.setAttribute("bakeryUserId", staff.getUserId());
                    session.setAttribute("role", staff.getRole());
                    session.setAttribute("storeId", staff.getStoreId());
                    response.sendRedirect("bakery/bakeryHome.jsp");
                    return;
                }
                case "warehouse" -> {
                    session.setAttribute("warehouseUserId", staff.getUserId());
                    session.setAttribute("role", staff.getRole());
                    response.sendRedirect("warehouse/warehouseHome.jsp");
                    return;
                }
                case "management" -> {
                    session.setAttribute("managementUserId", staff.getUserId());
                    session.setAttribute("role", staff.getRole());
                    response.sendRedirect("management/managementHome.jsp");
                    return;
                }
            }
        }
        request.setAttribute("loginError", "Invalid credentials");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
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
