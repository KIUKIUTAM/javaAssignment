<%@ page import="java.util.List" %>
<%@ page import="entity.FruitBorrowRecord" %>
<%@ page import="entity.FruitStockRecord" %>
<%@ page import="entity.Fruit" %>
<%@ page import="db.impl.FruitDB" %>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/bakery_management?useSSL=false";
    String username = "root";
    String password = "root";
    service.BorrowService borrowService = new service.BorrowService(jdbcUrl, username, password);
    List<FruitBorrowRecord> borrowRecords = borrowService.getRecordsByBakeryId((String) session.getAttribute("bakeryUserId"));
    List<FruitBorrowRecord> borrowedFromMeRecords = borrowService.getRecordsByBorrowBakeryId((String) session.getAttribute("bakeryUserId"));
    List<FruitStockRecord> availableStock = borrowService.getAllStockRecordsExcludingBorrowedAndSelfSameBakeryCity((String)session.getAttribute("bakeryUserId"));
    FruitDB fruitDB = new FruitDB(jdbcUrl, username, password);
    List<Fruit> allFruits = fruitDB.getAllFruits();
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
%>
<!-- Modal Trigger Button -->
<button type="button" class="btn btn-success my-3" data-bs-toggle="modal" data-bs-target="#borrowModal">Borrow Fruit From Other Bakery</button>
<div class="accordion mt-4" id="borrowAccordion">
  <!-- First Accordion: My Borrow Requests -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingOne">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        My Borrow Requests
      </button>
    </h2>
    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#borrowAccordion">
      <div class="accordion-body">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Stock ID</th>
              <th>Bakery ID</th>
              <th>Borrowed From Bakery ID</th>
              <th>State</th>
            </tr>
          </thead>
          <tbody>
          <% for(FruitBorrowRecord row : borrowRecords) { %>
            <tr>
              <td><%= row.getId() %></td>
              <td><%= row.getStockId() %></td>
              <td><%= row.getBakeryId() %></td>
              <td><%= row.getBorrowBakeryId() %></td>
              <td>
                <% if(row.getState() == 0) { %>
                  Wait for Approve
                <% } else if(row.getState() == 1) { %>
                  Approve
                <% } else if(row.getState() == 2) { %>
                  Reject
                <% } else { %>
                  <%= row.getState() %>
                <% } %>
              </td>
            </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <!-- Second Accordion: Requests From Other Bakeries (Borrowed From Me) -->
  <div class="accordion-item">
    <h2 class="accordion-header" id="headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        Requests From Other Bakeries (Borrowed From Me)
      </button>
    </h2>
    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#borrowAccordion">
      <div class="accordion-body">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Stock ID</th>
              <th>Bakery ID</th>
              <th>Borrowed From Bakery ID</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
          <% for(FruitBorrowRecord row : borrowedFromMeRecords) {
               if(row.getState() != 0) continue; %>
            <tr>
              <td><%= row.getId() %></td>
              <td><%= row.getStockId() %></td>
              <td><%= row.getBakeryId() %></td>
              <td><%= row.getBorrowBakeryId() %></td>
              <td>
                  <button class="btn btn-success btn-sm" onclick="approveBorrowRequest(<%= row.getId() %>, <%= row.getBakeryId() %>)">Approve</button>
                  <button class="btn btn-danger btn-sm" onclick="rejectBorrowRequest(<%= row.getId() %>, <%= row.getBakeryId() %>)">Reject</button>
              </td>
            </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Borrow Modal -->
<div class="modal fade" id="borrowModal" tabindex="-1" aria-labelledby="borrowModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="borrowModalLabel">Available Fruits to Borrow</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div style="max-height: 350px; overflow-y: auto;">
          <table class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Stock ID</th>
                <th>Fruit Name</th>
                <th>Bakery ID</th>
                <th>Quantity (Kg)</th>
                <th>Expiry Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            <% for(FruitStockRecord stock : availableStock) {
                Fruit fruit = allFruits.stream().filter(f -> f.getId() == stock.getFruitId()).findFirst().orElse(null);
            %>
              <tr>
                <td><%= stock.getId() %></td>
                <td><%= fruit != null ? fruit.getFruitName() : "Unknown" %></td>
                <td><%= stock.getBakeryId() %></td>
                <td><%= stock.getQuantityKg() %></td>
                <td><%= stock.getExpiredDate() %></td>
                <td>
                  <button class="btn btn-primary btn-sm" onclick="borrowFruit(<%= stock.getId() %>,  <%= stock.getBakeryId() %>)">Borrow</button>
                </td>
              </tr>
            <% } %>
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
function borrowFruit(stockId, borrowBakeryId) {
    var contextPath = '<%= request.getContextPath() %>';
    fetch(contextPath + '/createBorrowFruit', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          bakeryUserId: '<%= (String)session.getAttribute("bakeryUserId") %>',
          stockId: stockId,
          borrowBakeryId: borrowBakeryId
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert(data.message);
            // Optionally reload the page to show updated records
            window.location.reload();
          } else {
            alert('Failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred: ' + error.message);
    });
    
}

function approveBorrowRequest(borrowId, bakeryStoreId) {
  if(!confirm('approve this borrow request?')) return;
  var contextPath = '<%= request.getContextPath() %>';
  var bakeryUserId = '<%= bakeryUserId != null ? bakeryUserId : "" %>';
  fetch(contextPath + '/approveBorrowRequest', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ 
      borrowId: borrowId,
      bakeryStoreId : bakeryStoreId,
      state: 1
     })
  })
  .then(response => response.json())
  .then(data => {
    if(data.success) {
      alert('Approved!');
      window.location.reload();
    } else {
      alert('Failed: ' + data.message);
    }
  })
  .catch(err => {
    alert('Error: ' + err.message);
  });
}

// Similar improvements for rejectBorrowRequest



function rejectBorrowRequest(borrowId) {
  if(!confirm('Reject this borrow request?')) return;
  var contextPath = '<%= request.getContextPath() %>';
  fetch(contextPath + '/approveBorrowRequest', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ 
      bakeryUserId: '<%= (String)session.getAttribute("bakeryUserId") %>',
      borrowId: borrowId,
      state: 2
     })
  })
  .then(response => response.json())
  .then(data => {
    if(data.success) {
      alert('Rejected!');
      window.location.reload();
    } else {
      alert('Failed: ' + data.message);
    }
  })
  .catch(err => {
    alert('Error: ' + err.message);
  });
}

</script>