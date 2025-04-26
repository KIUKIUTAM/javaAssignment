package controller;

import service.BorrowService;
import db.impl.FruitDB;
import db.impl.FruitStockRecordDB;
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

@WebServlet("/borrowServlet")
public class BorrowServlet extends HttpServlet {
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
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
    }
}
