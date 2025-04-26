<%@ page import="enums.LoginType" %>
<%
    String warehouseUserId = (String) session.getAttribute("warehouseUserId");
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">

<!-- Bootstrap Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <span class="navbar-brand">Bakery Warehouse Stock System</span>
    <span class="navbar-text ms-auto" style="font-size: 1.4rem; font-weight: 600;">
      <label style="font-size:1.3rem;font-weight:600;">Id: &nbsp; <%= warehouseUserId %></label>
    </span>
    <div class="ms-3 d-flex">
      <a href="../index.jsp" class="btn btn-outline-light me-2">Back to login</a>
      <a href="../logoutServlet" class="btn btn-outline-warning">Logout</a>
    </div>
  </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
