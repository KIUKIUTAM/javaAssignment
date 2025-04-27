<%@ page import="java.util.List,java.util.Map" %>

<h1>Reserve Management</h1>

<jsp:useBean id="reserveService" class="service.ReserveService" scope="page" />
<%
    List<Map<String, Object>> fruits = reserveService.getAllFruitsWithDetails();
    List<Map<String, Object>> myReserveRecords = reserveService.getAllReserveRecords();
%>

<!-- Bootstrap container -->
<div class="container">
    <div class="table-responsive">
        <table class="table table-sm table-striped table-bordered align-middle mb-0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Fruit ID</th>
                    <th>Fruit Name</th>
                    <th>Quantity (Kg)</th>
                    <th>State</th>
                    <th>Create Date</th>
                    <th>Arrival Date</th>
                    <th>Origin To Warehouse (km)</th>
                    <th>Warehouse To Store (km)</th>
                </tr>
            </thead>
            <tbody>
                <% for(Map<String, Object> row : myReserveRecords) { 
                    int state = Integer.parseInt(String.valueOf(row.get("state")));
                    String createDate = String.valueOf(row.get("create_date"));
                    String deliveryDate = String.valueOf(row.get("arrival_date"));
                %>
                <tr>
                    <td><%= row.get("id") %></td>
                    <td><%= row.get("fruit_id") %></td>
                    <td><%= row.get("fruit_name") %></td>
                    <td><%= row.get("quantity") %></td>
                    <td>
                        <% 
                        String stateStr = "";
                        String stateColor = "";
                        switch(state) {
                            case 0: stateStr = "Pending"; stateColor = "bg-secondary"; break;
                            case 1: stateStr = "Approved"; stateColor = "bg-primary"; break;
                            case 2: stateStr = "Sending to centre warehouse"; stateColor = "bg-info"; break;
                            case 3: stateStr = "Arrived at centre warehouse"; stateColor = "bg-warning"; break;
                            case 4: stateStr = "Sending to bakery store"; stateColor = "bg-info"; break;
                            case 5: stateStr = "Arrived at bakery store"; stateColor = "bg-warning"; break;
                            case 6: stateStr = "Completed"; stateColor = "bg-success"; break;
                            case 98: stateStr = "Rejected"; stateColor = "bg-danger"; break;
                            case 99: stateStr = "Cancelled"; stateColor = "bg-danger"; break;
                            default: stateStr = "Unknown"; stateColor = "bg-dark"; break;
                        }
                        %>
                        <span class="badge <%= stateColor %>"><%= stateStr %></span>
                    </td>
                    <td><%= createDate %></td>
                    <td><%= (deliveryDate == null || deliveryDate.equals("null")) ? "Not start" : deliveryDate %></td>
                    <td><%= row.get("origin_to_warehouse") == null ? "Not start" : row.get("origin_to_warehouse") %></td>
                    <td><%= row.get("warehouse_to_store") == null ? "Not start" : row.get("warehouse_to_store") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>


<!-- Bootstrap CSS/JS (if not already included) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
