<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="./component/header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Warehouse System</title>
    </head>
    <body>
        <!-- Layout: sidebar full height -->
        <div class="container-fluid p-0" style="min-height: 100vh;">
            <div class="row g-0" style="min-height: 100vh;">
                <!-- Sidebar -->
                <div class="col-auto bg-light border-end" id="sidebar-wrapper" style="min-width: 200px; min-height: 100vh;">
                    <div class="p-3">
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/home.jsp')">Home</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/reserve.jsp')">Store Reserve</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/approve.jsp')">Approve</button>
                        <button class="btn btn-outline-primary w-100 mb-3" onclick="loadContent('./component/createUser.jsp')">Create User</button>
                    </div>
                </div>
            
                <div class="col flex-grow-1 p-3" id="content">
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
        loadContent('./component/home.jsp')
        function loadContent(url) {
            $("#content").load(url);
        }
        </script>
               <script>
                $(document).ready(function() {
                
                    const urlParams = new URLSearchParams(window.location.search);
                    const loadComp = urlParams.get('loadComponent');
                    
                    if (loadComp) {
                        loadContent('./component/' + loadComp + '.jsp');
                    }
                });
            </script>
    </body>
</html>