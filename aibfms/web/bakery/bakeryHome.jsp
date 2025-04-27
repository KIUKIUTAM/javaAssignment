<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="./component/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bakery store System</title>
    </head>
    <body>
        <!-- Layout: sidebar full height -->
        <div class="container-fluid p-0" style="min-height: 100vh;">
            <div class="row g-0" style="min-height: 100vh;">
                <!-- Sidebar -->
                <div class="col-auto bg-light border-end" id="sidebar-wrapper" style="min-width: 200px; min-height: 100vh;">
                    <div class="p-3">
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/home.jsp')">Home</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/reserve.jsp')">Reserve</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/storeStock.jsp')">Stock Level</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/borrow.jsp')">Borrow</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/createUser.jsp')">Create User</button>
                    </div>
                </div>
            
                <div class="col flex-grow-1 p-3" id="content">
             
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
        function loadContent(url) {
            $("#content").load(url);
        }
        </script>
    </body>
</html>