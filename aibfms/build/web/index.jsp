<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>System Login</title>
    <!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            margin-top: 100px;
        }
        .login-btn {
            width: 250px;
            height: 100px;
            margin: 20px;
            font-size: 1.2rem;
        }
        .modal-loading-overlay {
          position: absolute;
          top: 0; left: 0; right: 0; bottom: 0;
          background: rgba(255,255,255,0.7);
          z-index: 10;
          display: flex;
          align-items: center;
          justify-content: center;
          display: none;
        }
        .modal-loading-overlay.active {
          display: flex;
        }
    </style>
</head>
<body>
<% 
    String loginError = (String) request.getAttribute("loginError");
    String loginType = request.getParameter("type");
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
    String warehouseUserId = (String) session.getAttribute("warehouseUserId");
    String managementUserId = (String) session.getAttribute("managementUserId");
%>
<% if (loginError != null && loginType != null) { %>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    var modalId = '';
    if ('<%= loginType %>' === '1') modalId = '#bakeryModal';
    if ('<%= loginType %>' === '2') modalId = '#warehouseModal';
    if ('<%= loginType %>' === '3') modalId = '#managementModal';
    if (modalId && window.bootstrap) {
      var modal = new bootstrap.Modal(document.querySelector(modalId));
      modal.show();
    }
  });
</script>
<% } %>
<div class="container login-container text-center">
    <h1 class="mb-5">Welcome to Acer International Bakery</h1>
    <img src="resources/images/bread_Icon.webp"  alt="bread"/>
    <div class="row justify-content-center">
        <div class="col-md-4">
            <% if (bakeryUserId != null) { %>
                <button type="button" class="btn btn-primary login-btn" onclick="window.location.href='bakery/bakeryHome.jsp'">
                    Bakery Shop Staff:<br> 
                    <%= bakeryUserId %>
                </button>
            <% } else { %>
                <button type="button" class="btn btn-primary login-btn" data-bs-toggle="modal" data-bs-target="#bakeryModal">
                    Bakery Shop Staff Login
                </button>
            <% } %>
        </div>
        <div class="col-md-4">
            <% if (warehouseUserId != null) { %>
                <button type="button" class="btn btn-success login-btn" onclick="window.location.href='warehouse/warehouseHome.jsp'">
                    Warehouse Staff:<br>
                    <%= warehouseUserId %>
                </button>
            <% } else { %>
                <button type="button" class="btn btn-success login-btn" data-bs-toggle="modal" data-bs-target="#warehouseModal">
                    Warehouse Staff Login
                </button>
            <% } %>
        </div>
        <div class="col-md-4">
            <% if (managementUserId != null) { %>
                <button type="button" class="btn btn-warning login-btn" onclick="window.location.href='management/managementHome.jsp'">
                    Senior Management:<br>
                    <%= managementUserId %>
                </button>
            <% } else { %>
                <button type="button" class="btn btn-warning login-btn" data-bs-toggle="modal" data-bs-target="#managementModal">
                    Senior Management Login
                </button>
            <% } %>
        </div>
    </div>
</div>


<div class="modal fade" id="bakeryModal" tabindex="-1" aria-labelledby="bakeryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="bakeryModalLabel">Bakery Shop Staff Login</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body position-relative">
                <div class="modal-loading-overlay" id="bakeryLoading">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <% if (loginError != null && request.getParameter("type") != null && request.getParameter("type").equals("1")) { %>
                  <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= loginError %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                <% } %>
                <form action="loginServlet?type=1" method="post" onsubmit="return showLoginButtonLoading('bakery')">
                    <div class="mb-3">
                        <label for="bakeryUsername" class="form-label">Staff Id</label>
                        <input type="text" class="form-control" id="bakeryUsername" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label for="bakeryPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="bakeryPassword" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100" id="bakeryLoginBtn">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="warehouseModal" tabindex="-1" aria-labelledby="warehouseModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title" id="warehouseModalLabel">Warehouse Staff Login</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body position-relative">
                <div class="modal-loading-overlay" id="warehouseLoading">
                    <div class="spinner-border text-success" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <% if (loginError != null && request.getParameter("type") != null && request.getParameter("type").equals("2")) { %>
                  <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= loginError %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                <% } %>
                <form action="loginServlet?type=2" method="post" onsubmit="return showLoginButtonLoading('warehouse')">
                    <div class="mb-3">
                        <label for="warehouseUsername" class="form-label">Staff Id</label>
                        <input type="text" class="form-control" id="warehouseUsername" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label for="warehousePassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="warehousePassword" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100" id="warehouseLoginBtn">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="managementModal" tabindex="-1" aria-labelledby="managementModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h5 class="modal-title" id="managementModalLabel">Senior Management Login</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body position-relative">
                <div class="modal-loading-overlay" id="managementLoading">
                    <div class="spinner-border text-warning" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
                <% if (loginError != null && request.getParameter("type") != null && request.getParameter("type").equals("3")) { %>
                  <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <%= loginError %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                  </div>
                <% } %>
                <form action="loginServlet?type=3" method="post" onsubmit="return showLoginButtonLoading('management')">
                    <div class="mb-3">
                        <label for="managementUsername" class="form-label">Staff Id</label>
                        <input type="text" class="form-control" id="managementUsername" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label for="managementPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="managementPassword" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-warning w-100" id="managementLoginBtn">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Bootstrap 5 JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<script>
function showLoginButtonLoading(type) {
  var btnId = type + 'LoginBtn';
  var btn = document.getElementById(btnId);
  if (btn) {
    var spinnerClass = 'spinner-border spinner-border-sm';
    btn.innerHTML = '<span class="' + spinnerClass + '" role="status" aria-hidden="true"></span> Verification...';
    btn.disabled = true;
    setTimeout(function() {
      btn.closest('form').submit();
    }, 500);
    return false;
  }
  return true;
}
</script>

</body>
</html>