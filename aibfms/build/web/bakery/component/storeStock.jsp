<%@ page import="service.StockSerice" %>
<%@ page import="entity.FruitStockRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String username = "root";
    String password = "root";
    StockSerice stockService = new StockSerice(jdbcUrl, username, password);
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
    List<FruitStockRecord> stockList = stockService.getStockRecordsByBakeryId(bakeryUserId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Fruit Stock List</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Fruit Stock List</h2>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Stock ID</th>
                <th>Fruit ID</th>
                <th>Quantity (kg)</th>
                <th>Expired Date</th>
                <th>Borrow Record</th>
                <th>Created At</th>
                <th>Updated At</th>
            </tr>
        </thead>
        <tbody>
        <% for(FruitStockRecord stock : stockList) { %>
            <tr>
                <td><%= stock.getId() %></td>
                <td><%= stock.getFruitId() %></td>
                <td><%= stock.getQuantityKg() %></td>
                <td><%= stock.getExpiredDate() %></td>
                <td><%= stock.getBorrowRecord() %></td>
                <td><%= stock.getCreatedAt() %></td>
                <td><%= stock.getUpdatedAt() %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>