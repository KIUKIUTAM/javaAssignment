<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.FruitService"%>
<%@ page import="entity.Fruit"%>
<%@ page import="java.util.*"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
    FruitService fruitService = new FruitService();
    
    String action = request.getParameter("action");
    String message = "";
    String alertType = "info";
    
    // Process form submission
    if (action != null) {
        try {
            if (action.equals("add") || action.equals("update")) {
                String fruitName = request.getParameter("fruitName");
                String shelfLifeStr = request.getParameter("shelfLife");
                String cityName = request.getParameter("cityName");
                String usaDistanceStr = request.getParameter("usaDistance");
                String japanDistanceStr = request.getParameter("japanDistance");
                String hkDistanceStr = request.getParameter("hkDistance");
                
                // Validate inputs
                if (fruitName == null || fruitName.trim().isEmpty() ||
                    shelfLifeStr == null || shelfLifeStr.trim().isEmpty() ||
                    cityName == null || cityName.trim().isEmpty() ||
                    usaDistanceStr == null || usaDistanceStr.trim().isEmpty() ||
                    japanDistanceStr == null || japanDistanceStr.trim().isEmpty() ||
                    hkDistanceStr == null || hkDistanceStr.trim().isEmpty()) {
                    message = "All fields are required";
                    alertType = "danger";
                } else {
                    int shelfLife = Integer.parseInt(shelfLifeStr);
                    float usaDistance = Float.parseFloat(usaDistanceStr);
                    float japanDistance = Float.parseFloat(japanDistanceStr);
                    float hkDistance = Float.parseFloat(hkDistanceStr);
                    
                    boolean success = false;
                    
                    if (action.equals("add")) {
                        Fruit fruit = new Fruit();
                        fruit.setFruitName(fruitName);
                        fruit.setShelfLife(shelfLife);
                        fruit.setCityName(cityName);
                        fruit.setUsaWarehouseDistance(usaDistance);
                        fruit.setJapanWarehouseDistance(japanDistance);
                        fruit.setHkWarehouseDistance(hkDistance);
                        
                        success = fruitService.create(fruit);
                        message = success ? "Fruit added successfully" : "Failed to add fruit";
                        alertType = success ? "success" : "danger";
                    } else {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Fruit fruit = new Fruit();
                        fruit.setId(id);
                        fruit.setFruitName(fruitName);
                        fruit.setShelfLife(shelfLife);
                        fruit.setCityName(cityName);
                        fruit.setUsaWarehouseDistance(usaDistance);
                        fruit.setJapanWarehouseDistance(japanDistance);
                        fruit.setHkWarehouseDistance(hkDistance);
                        
                        success = fruitService.update(fruit);
                        message = success ? "Fruit updated successfully" : "Failed to update fruit";
                        alertType = success ? "success" : "danger";
                    }
                }
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = fruitService.delete(id);
                message = success ? "Fruit deleted successfully" : "Failed to delete fruit";
                alertType = success ? "success" : "danger";
            }
        } catch (NumberFormatException e) {
            message = "Invalid number format: " + e.getMessage();
            alertType = "danger";
        } catch (Exception e) {
            message = "Error processing request: " + e.getMessage();
            alertType = "danger";
        }
    }
    
    // Get fruit for editing
    Fruit editFruit = null;
    if (action != null && action.equals("edit")) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            editFruit = fruitService.read(id);
            if (editFruit == null) {
                message = "Fruit not found";
                alertType = "warning";
            }
        } catch (NumberFormatException e) {
            message = "Invalid fruit ID";
            alertType = "danger";
        }
    }
    
    // Get all fruits
    List<Map<String, Object>> fruitList = new ArrayList<>();
    try {
        fruitList = fruitService.getAllFruitsWithDetails();
    } catch (Exception e) {
        message = "Error loading fruits: " + e.getMessage();
        alertType = "danger";
    }
    
    // Get sorting parameters
    String sortField = request.getParameter("sort");
    String sortDir = request.getParameter("dir");
    
    // Get search parameter
    String searchQuery = request.getParameter("search");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fruit Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <style>
        .container {
            margin-top: 30px;
        }
        .form-container {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .table-container {
            margin-top: 20px;
        }
        .alert {
            margin-bottom: 20px;
        }
        .dataTables_wrapper {
            padding: 20px 0;
        }
        .action-buttons {
            white-space: nowrap;
        }
        .input-validation-error {
            border-color: #dc3545;
        }
        .field-validation-error {
            color: #dc3545;
            font-size: 0.875em;
        }
        .btn-toolbar {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">Fruit Management System</h2>
        
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-<%= alertType %> alert-dismissible fade show">
                <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <div class="form-container">
            <h4><%= editFruit == null ? "Add New Fruit" : "Edit Fruit" %></h4>
            <form method="post" action="fruitManagement.jsp" id="fruitForm" class="needs-validation" novalidate>
                <input type="hidden" name="action" value="<%= editFruit == null ? "add" : "update" %>">
                <% if (editFruit != null) { %>
                    <input type="hidden" name="id" value="<%= editFruit.getId() %>">
                <% } %>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="fruitName" class="form-label">Fruit Name</label>
                        <input type="text" class="form-control" id="fruitName" name="fruitName" 
                               value="<%= editFruit == null ? "" : editFruit.getFruitName() %>" required>
                        <div class="invalid-feedback">
                            Please enter a fruit name.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="shelfLife" class="form-label">Shelf Life (days)</label>
                        <input type="number" class="form-control" id="shelfLife" name="shelfLife" min="1" max="365"
                               value="<%= editFruit == null ? "" : editFruit.getShelfLife() %>" required>
                        <div class="invalid-feedback">
                            Please enter a valid shelf life (1-365 days).
                        </div>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="cityName" class="form-label">City Name</label>
                    <input type="text" class="form-control" id="cityName" name="cityName" 
                           value="<%= editFruit == null ? "" : editFruit.getCityName() %>" required>
                    <div class="invalid-feedback">
                        Please enter a city name.
                    </div>
                </div>
                
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="usaDistance" class="form-label">USA Warehouse Distance</label>
                        <input type="number" step="0.01" class="form-control" id="usaDistance" name="usaDistance" min="0"
                               value="<%= editFruit == null ? "" : editFruit.getUsaWarehouseDistance() %>" required>
                        <div class="invalid-feedback">
                            Please enter a valid distance.
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="japanDistance" class="form-label">Japan Warehouse Distance</label>
                        <input type="number" step="0.01" class="form-control" id="japanDistance" name="japanDistance" min="0"
                               value="<%= editFruit == null ? "" : editFruit.getJapanWarehouseDistance() %>" required>
                        <div class="invalid-feedback">
                            Please enter a valid distance.
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label for="hkDistance" class="form-label">Hong Kong Warehouse Distance</label>
                        <input type="number" step="0.01" class="form-control" id="hkDistance" name="hkDistance" min="0"
                               value="<%= editFruit == null ? "" : editFruit.getHkWarehouseDistance() %>" required>
                        <div class="invalid-feedback">
                            Please enter a valid distance.
                        </div>
                    </div>
                </div>
                
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <%= editFruit == null ? "Add" : "Update" %>
                    </button>
                    
                    <% if (editFruit != null) { %>
                        <a href="fruitManagement.jsp" class="btn btn-secondary">Cancel</a>
                    <% } %>
                    
                    <button type="reset" class="btn btn-outline-secondary">Reset</button>
                </div>
            </form>
        </div>
        
        <div class="table-container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>Fruit List</h4>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-outline-primary" id="refreshData">
                        <i class="bi bi-arrow-clockwise"></i> Refresh
                    </button>
                </div>
            </div>
            
            <table id="fruitTable" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Fruit Name</th>
                        <th>Shelf Life (days)</th>
                        <th>City</th>
                        <th>USA Warehouse Distance</th>
                        <th>Japan Warehouse Distance</th>
                        <th>Hong Kong Warehouse Distance</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> fruit : fruitList) { %>
                        <tr>
                            <td><%= fruit.get("id") %></td>
                            <td><%= fruit.get("fruit_name") %></td>
                            <td><%= fruit.get("shelf_life") %></td>
                            <td><%= fruit.get("city_name") %></td>
                            <td><%= fruit.get("usa_warehouse_distance") %></td>
                            <td><%= fruit.get("japan_warehouse_distance") %></td>
                            <td><%= fruit.get("hk_warehouse_distance") %></td>
                            <td class="action-buttons">
                                <a href="fruitManagement.jsp?action=edit&id=<%= fruit.get("id") %>" class="btn btn-sm btn-warning">Edit</a>
                                <a href="fruitManagement.jsp?action=delete&id=<%= fruit.get("id") %>" class="btn btn-sm btn-danger" 
                                   onclick="return confirm('Are you sure you want to delete this fruit?');">
                                   Delete
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable with export buttons
            var table = $('#fruitTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn btn-sm btn-outline-secondary'
                    },
                    {
                        extend: 'csv',
                        className: 'btn btn-sm btn-outline-secondary'
                    },
                    {
                        extend: 'excel',
                        className: 'btn btn-sm btn-outline-secondary'
                    },
                    {
                        extend: 'pdf',
                        className: 'btn btn-sm btn-outline-secondary'
                    },
                    {
                        extend: 'print',
                        className: 'btn btn-sm btn-outline-secondary'
                    }
                ],
                responsive: true,
                ordering: true,
                searching: true,
                paging: true,
                pageLength: 10,
                lengthMenu: [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
            });
            
            // Client-side form validation
            (function() {
                'use strict';
                
                var forms = document.querySelectorAll('.needs-validation');
                
                Array.prototype.slice.call(forms).forEach(function(form) {
                    form.addEventListener('submit', function(event) {
                        if (!form.checkValidity()) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        
                        form.classList.add('was-validated');
                    }, false);
                });
            })();
            
            // Refresh button functionality
            $('#refreshData').click(function() {
                window.location.href = 'fruitManagement.jsp';
            });
            
            // Highlight table rows on hover
            $('#fruitTable tbody').on('mouseenter', 'tr', function() {
                $(this).addClass('table-active');
            }).on('mouseleave', 'tr', function() {
                $(this).removeClass('table-active');
            });
            
            // Show alert messages then fade out after 5 seconds
            $('.alert').delay(5000).fadeOut(500);
        });
    </script>
</body>
</html>
