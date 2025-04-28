<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Staff"%>
<%@page import="service.StaffService"%>
<%@page import="entity.Bakery" %>
<%@page import="service.BakeryStoreService" %>
<%
    BakeryStoreService bakeryStoreService = new BakeryStoreService();
    List<Bakery> bakeries = bakeryStoreService.getAllBakeries();
    StaffService staffService = new StaffService();
    List<Staff> staffList = staffService.getAllStaff();
%>
<div class="container mt-4">
    <h2>Account Management</h2>
    <div class="mb-3">
        <button class="btn btn-success" onclick="showAddStaffModal()">
            <i class="bi bi-plus-circle"></i> Add New Staff
        </button>
    </div>
    
    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover" id="staffTable">
            <thead class="table-dark">
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Store ID</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% for(Staff s : staffList) { 
                if(!"none".equalsIgnoreCase(s.getRole())) { %>
                <tr>
                    <td><%= s.getUserId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getRole() %></td>
                    <td><%= s.getStoreId() != null ? s.getStoreId() : "N/A" %></td>
                    <td>
                        <div class="btn-group" role="group">
                            <button class="btn btn-sm btn-primary me-2" 
                                    onclick="editStaff('<%= s.getUserId() %>')"
                                    data-bs-toggle="tooltip" title="Edit">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" 
                                    onclick="confirmDeleteStaff('<%= s.getUserId() %>')"
                                    data-bs-toggle="tooltip" title="Delete">
                                <i class="bi bi-trash"></i>
                            </button>
                        </div>
                    </td>
                </tr>
            <% } 
            } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Staff Modal -->
<div class="modal fade" id="addStaffModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Staff</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addStaffForm" onsubmit="return handleAddStaff(event)">
                    <input type="hidden" name="action" value="add">
                    <div class="mb-3">
                        <label for="addUserId" class="form-label">User ID</label>
                        <input type="text" class="form-control" id="addUserId" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label for="addName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="addName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="addPassword" class="form-label">Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="addPassword" name="password" required>
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('addPassword')">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="addRole" class="form-label">Role</label>
                        <select class="form-control" id="addRole" name="role" onchange="toggleStoreField('add')" required>
                            <option value="">Choose a role</option>
                            <option value="management">Management</option>
                            <option value="warehouse">Warehouse</option>
                            <option value="bakery">Bakery</option>
                        </select>
                    </div>
                    <div class="mb-3" id="addStoreField" style="display: none;">
                        <label for="addStoreId" class="form-label">store</label>
                        <select class="form-control" id="addStoreId" name="storeId">
                            <option value="">Choose a store</option>
                            <% for(Bakery bakery : bakeries) { %>
                                <option value="<%= bakery.getId() %>"><%= bakery.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Add Staff</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit Staff Modal -->
<div class="modal fade" id="editStaffModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Staff</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editStaffForm" onsubmit="return handleEditStaff(event)">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editUserId" name="userId">
                    <div class="mb-3">
                        <label for="editName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">New Password</label>
                        <div class="input-group">
                            <input type="password" class="form-control" id="editPassword" name="password">
                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('editPassword')">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                        <small class="form-text text-muted">Leave empty to keep current password</small>
                    </div>
		<div class="mb-3">
			<label for="editRole" class="form-label">role</label>
			<select class="form-control" id="editRole" name="role" onchange="toggleStoreField('edit')" required>
				<option value="">Choose a role</option>
				<option value="management">Management</option>
				<option value="warehouse">Warehouse</option>
				<option value="bakery">Bakery</option>
                            <option value="none">None</option>
                        </select>
                    </div>
                    <div class="mb-3" id="editStoreField" style="display: none;">
                        <label for="editStoreId" class="form-label">store</label>
                        <select class="form-control" id="editStoreId" name="storeId">
                            <option value="">Choose a store</option>
                            <% for(Bakery bakery : bakeries) { %>
                                <option value="<%= bakery.getId() %>"><%= bakery.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Update Staff</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Toast Container -->
<div class="toast-container position-fixed bottom-0 end-0 p-3">
    <div id="toast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto" id="toast-title"></strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="toast-message"></div>
    </div>
</div>

<!-- Required Libraries -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    $('#staffTable').DataTable({
        responsive: true,
        dom: '<"top"lf>rt<"bottom"ip>',
        language: {
            search: "_INPUT_",
            searchPlaceholder: "Search staff..."
        }
    });
    $('[data-bs-toggle="tooltip"]').tooltip();
});

function showAddStaffModal() {
    $('#addStaffForm')[0].reset();
    $('#addStaffModal').modal('show');
}

function handleAddStaff(event) {
    event.preventDefault();
    const form = document.getElementById('addStaffForm');
    const formData = $(form).serialize();
    
    if ($('#addRole').val() !== 'bakery') {
        $('#addStoreId').val('');
    }
    
    console.log('Serialized data:', formData);
    
    $.ajax({
        url: '${pageContext.request.contextPath}/StaffServlet',
        type: 'POST',
        data: formData,
        success: function(response) {
            if (response.success) {
                $('#addStaffModal').modal('hide');
                form.reset();
                loadStaffList();
                showToast('Success', 'Staff added successfully');
            } else {
                showToast('Error', response.message || 'Failed to add staff');
            }
        },
        error: function(xhr, status, error) {
            showToast('Error', 'An error occurred while adding staff');
            console.error('Error:', error);
        }
    });
    return false;
}

function editStaff(userId) {
    $.ajax({
        url: '${pageContext.request.contextPath}/StaffServlet',
        type: 'POST',
        data: { 
            action: 'getForEdit',
            userId: userId 
        },
        success: function(response) {
            if(response.success) {
                $('#editUserId').val(response.data.userId);
                $('#editName').val(response.data.name);
                $('#editRole').val(response.data.role);
                $('#editStoreId').val(response.data.storeId);
                toggleStoreField('edit'); 
                $('#editStaffModal').modal('show');
            } else {
                showToast('Error', response.message);
            }
        },
        error: function() {
            showToast('Error', 'Error loading staff data');
        }
    });
}

function handleEditStaff(event) {
    event.preventDefault();
    const form = document.getElementById('editStaffForm');
    const formData = $(form).serialize();
    
    if ($('#editRole').val() !== 'bakery') {
        $('#editStoreId').val('');
    }
    
    console.log('Serialized data:', formData);
    
    $.ajax({
        url: '${pageContext.request.contextPath}/StaffServlet',
        type: 'POST',
        data: formData,
        success: function(response) {
            if (response.success) {
                $('#editStaffModal').modal('hide');
                form.reset();
                loadStaffList();
                showToast('Success', 'Staff updated successfully');
            } else {
                showToast('Error', response.message || 'Failed to update staff');
            }
        },
        error: function(xhr, status, error) {
            showToast('Error', 'An error occurred while updating staff');
            console.error('Error:', error);
        }
    });
    return false;
}

function togglePassword(inputId) {
    const passwordInput = $(`#${inputId}`);
    const type = passwordInput.attr('type');
    passwordInput.attr('type', type === 'password' ? 'text' : 'password');
}

function confirmDeleteStaff(userId) {
    if(confirm('Are you sure you want to delete this staff member?')) {
        $.ajax({
            url: '${pageContext.request.contextPath}/StaffServlet',
            type: 'POST',
            data: { 
                action: 'delete',
                userId: userId 
            },
            success: function(response) {
                if(response.success) {
                    showToast('Success', response.message);
                    setTimeout(() => location.reload(), 1500);
                } else {
                    showToast('Error', response.message);
                }
            },
            error: function() {
                showToast('Error', 'Error deleting staff');
            }
        });
    }
}

function showToast(title, message) {
    const toast = $('#toast');
    $('#toast-title').text(title);
    $('#toast-message').text(message);
    const bsToast = new bootstrap.Toast(toast);
    bsToast.show();
}

function loadStaffList() {
    location.reload();
}

function toggleStoreField(prefix) {
    const roleSelect = document.getElementById(prefix + 'Role');
    const storeField = document.getElementById(prefix + 'StoreField');
    const storeSelect = document.getElementById(prefix + 'StoreId');
    
    if (roleSelect.value === 'bakery') {
        storeField.style.display = 'block';
        storeSelect.required = true;
    } else {
        storeField.style.display = 'none';
        storeSelect.required = false;
        storeSelect.value = '';
    }
}
</script>