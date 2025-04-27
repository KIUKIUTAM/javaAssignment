<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Creation Result</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex flex-column justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="card shadow p-4" style="max-width: 400px; width: 100%;">
            <h2 class="mb-4 text-center">${message}</h2>
            <form action="${pageContext.request.contextPath}/warehouse/warehouseHome.jsp">
                <button type="submit" class="btn btn-primary w-100">Go to Home</button>
            </form>
        </div>
    </div>
    <!-- Bootstrap JS (optional, for interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
