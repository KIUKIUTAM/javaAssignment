<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header bg-primary text-white">
          <h4 class="mb-0">Create User</h4>
        </div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/createUser" method="post">
            <div class="mb-3">
              <label for="userId" class="form-label">User ID</label>
              <input type="text" class="form-control" id="userId" name="userId" required>
            </div>
            <div class="mb-3">
              <label for="name" class="form-label">Name</label>
              <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
              <label for="role" class="form-label">Role</label>
              <input type="text" class="form-control" id="role" name="role" value="Warehouse" readonly>
            </div>
            <button type="submit" class="btn btn-primary w-100">Create User</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>