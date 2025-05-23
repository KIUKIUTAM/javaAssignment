<%@ page import="service.StockService" %>
<%@ page import="entity.FruitStockRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Date" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String username = "root";
    String password = "root";
    StockService stockService = new StockService();
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
    List<FruitStockRecord> stockList = stockService.getStockRecordsByBakeryId(bakeryUserId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Fruit Stock Management</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .stock-warning { color: #dc3545; }
        .stock-ok { color: #198754; }
        .expired-warning { background-color: #fff3cd; }
        .table-hover tbody tr:hover {
            background-color: rgba(0,0,0,.075);
        }
        .card {
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
        }
        .dataTables_wrapper .dataTables_length select {
            width: 80px;
        }
        .search-input {
            margin-bottom: 10px;
        }
        .dt-buttons {
            margin-bottom: 15px;
        }
        .dt-button {
            background-color: #6c757d !important;
            border-color: #6c757d !important;
            color: white !important;
        }
        .dt-button:hover {
            background-color: #5a6268 !important;
            border-color: #545b62 !important;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container-fluid py-4">
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0">
                    <i class="fas fa-warehouse me-2"></i>Fruit Stock Management
                </h5>
            </div>
            <div class="card-body">
                <!-- Summary Cards -->
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card border-left-primary h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Stock Items</div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= stockList.size() %></div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Stock Table -->
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="stockTable" width="100%">
                        <thead class="table-light">
                            <tr>
                                <th>Stock ID</th>
                                <th>Fruit ID</th>
                                <th>Quantity (kg)</th>
                                <th>Status</th>
                                <th>Expired Date</th>
                                <th>Borrow From</th>
                                <th>Created At</th>
                                <th>Updated At</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for(FruitStockRecord stock : stockList) { 
                            boolean isExpired = stock.getExpiredDate() != null && 
                                              stock.getExpiredDate().before(new Date(System.currentTimeMillis()));
                            String statusClass = isExpired ? "stock-warning" : "stock-ok";
                            String rowClass = isExpired ? "expired-warning" : "";
                        %>
                            <tr class="<%= rowClass %>">
                                <td><%= stock.getId() %></td>
                                <td><%= stock.getFruitId() %></td>
                                <td>
                                    <span class="<%= stock.getQuantityKg() < 5 ? "stock-warning" : "stock-ok" %>">
                                        <%= stock.getQuantityKg() %>
                                        <% if(stock.getQuantityKg() < 5) { %>
                                            <i class="fas fa-exclamation-triangle"></i>
                                        <% } %>
                                    </span>
                                </td>
                                <td>
                                    <span class="<%= statusClass %>">
                                        <%= isExpired ? "Expired" : "Active" %>
                                    </span>
                                </td>
                                <td><%= stock.getExpiredDate() %></td>
                                <td><%= stock.getBorrowRecord() %></td>
                                <td><%= stock.getCreatedAt() %></td>
                                <td><%= stock.getUpdatedAt() %></td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Required JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>

    <script>
        $(document).ready(function() {
            var table = $('#stockTable').DataTable({
                responsive: true,
                order: [[0, 'desc']],
                searching: true,
                pageLength: 10,
                dom: 'Bfrtip',
                buttons: [
                    'copy', 'excel', 'pdf', 'print'
                ],
                language: {
                    lengthMenu: "Show _MENU_ entries per page",
                    info: "Showing _START_ to _END_ of _TOTAL_ stock records",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous" 
                    }
                }
            });


            $('.search-input').on('keyup change', function() {
                var column = $(this).data('column');
                var value = $(this).val();
                table.column(column).search(value).draw();
            });

        
            $('#clearFilters').on('click', function() {
                $('.search-input').val('');
                table.search('').columns().search('').draw();
            });
        });

        function viewDetails(stockId) {
          
            alert('Viewing details for stock ID: ' + stockId);
        }

        function editStock(stockId) {
    
            alert('Editing stock ID: ' + stockId);
        }
    </script>

    <!-- Add DataTables Buttons CSS and JS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.bootstrap5.min.css">

    <!-- DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.5/js/dataTables.bootstrap5.min.js"></script>


</body>
</html>