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
            <form method="post" action="${pageContext.request.contextPath}/fruitManagementServlet" id="fruitForm" class="needs-validation" novalidate>
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
                        <a href="${pageContext.request.contextPath}/fruitManagementServlet" class="btn btn-secondary">Cancel</a>
                    <% } %>
                    
                    <button type="reset" class="btn btn-outline-secondary">Reset</button>
                </div>
            </form>
        </div>
        
        <div class="table-container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>Fruit List</h4>
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
                                <button class="btn btn-sm btn-warning edit-btn" data-bs-toggle="modal" data-bs-target="#editModal" 
                                   data-id="<%= fruit.get("id") %>"
                                   data-fruitname="<%= fruit.get("fruit_name") %>"
                                   data-shelflife="<%= fruit.get("shelf_life") %>"
                                   data-cityname="<%= fruit.get("city_name") %>"
                                   data-usadistance="<%= fruit.get("usa_warehouse_distance") %>"
                                   data-japandistance="<%= fruit.get("japan_warehouse_distance") %>"
                                   data-hkdistance="<%= fruit.get("hk_warehouse_distance") %>">
                                   Edit
                                </button>
                                <a href="${pageContext.request.contextPath}/fruitManagementServlet?action=delete&id=<%= fruit.get("id") %>" class="btn btn-sm btn-danger" 
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
    
    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Fruit</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form method="post" action="${pageContext.request.contextPath}/fruitManagementServlet" id="editModalForm" class="needs-validation" novalidate>
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" id="editId">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="editFruitName" class="form-label">Fruit Name</label>
                                <input type="text" class="form-control" id="editFruitName" name="fruitName" required>
                                <div class="invalid-feedback">
                                    Please enter a fruit name.
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label for="editShelfLife" class="form-label">Shelf Life (days)</label>
                                <input type="number" class="form-control" id="editShelfLife" name="shelfLife" min="1" max="365" required>
                                <div class="invalid-feedback">
                                    Please enter a valid shelf life (1-365 days).
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="editCityName" class="form-label">City Name</label>
                            <input type="text" class="form-control" id="editCityName" name="cityName" required>
                            <div class="invalid-feedback">
                                Please enter a city name.
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label for="editUsaDistance" class="form-label">USA Warehouse Distance</label>
                                <input type="number" step="0.01" class="form-control" id="editUsaDistance" name="usaDistance" min="0" required>
                                <div class="invalid-feedback">
                                    Please enter a valid distance.
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="editJapanDistance" class="form-label">Japan Warehouse Distance</label>
                                <input type="number" step="0.01" class="form-control" id="editJapanDistance" name="japanDistance" min="0" required>
                                <div class="invalid-feedback">
                                    Please enter a valid distance.
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label for="editHkDistance" class="form-label">Hong Kong Warehouse Distance</label>
                                <input type="number" step="0.01" class="form-control" id="editHkDistance" name="hkDistance" min="0" required>
                                <div class="invalid-feedback">
                                    Please enter a valid distance.
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="saveChanges">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
    
            $('#fruitTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'copy', 'csv', 'excel', 'pdf', 'print'
                ]
            });
   
            $('.edit-btn').on('click', function() {
                var id = $(this).data('id');
                var fruitName = $(this).data('fruitname');
                var shelfLife = $(this).data('shelflife');
                var cityName = $(this).data('cityname');
                var usaDistance = $(this).data('usadistance');
                var japanDistance = $(this).data('japandistance');
                var hkDistance = $(this).data('hkdistance');
                
           
                $('#editId').val(id);
                $('#editFruitName').val(fruitName);
                $('#editShelfLife').val(shelfLife);
                $('#editCityName').val(cityName);
                $('#editUsaDistance').val(usaDistance);
                $('#editJapanDistance').val(japanDistance);
                $('#editHkDistance').val(hkDistance);
            });
            
            $('#saveChanges').on('click', function() {
                $('#editModalForm').submit();
            });
            
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
        });
    </script>
</body>
</html>
