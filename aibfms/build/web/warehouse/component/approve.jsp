<%@ page import="java.util.List,java.util.Map" %>

<h1>Approve</h1>

<jsp:useBean id="reserveService" class="service.ReserveService" scope="page" />
<%
    List<Map<String, Object>> myReserveRecords = reserveService.getAllReserveRecords();
    
    %>

<!-- Bootstrap container for consistent horizontal margin -->
<div class="container">
  <!-- Add horizontal margin to the accordion -->
  <div class="accordion mx-3" id="fruitAccordion">

    <!-- Second Accordion: My Reserve Records -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Approve reserve lists
        </button>
      </h2>
      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#fruitAccordion">
        <div class="accordion-body">
          <button class="btn btn-primary mb-2" id="approveAllBtn" onclick="approveAllPendingOrders()">Approve All</button>
          <div style="max-height: 360px; overflow-y: auto;">
            <table class="table table-sm table-striped table-bordered align-middle mb-0">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Fruit ID</th>
                  <th>Fruit Name</th>
                  <th>Quantity (Kg)</th>
                  <th>State</th>
                  <th>Create Date</th>
                  <th>Arrival Date</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <% for(Map<String, Object> row : myReserveRecords) { 
                    int state = (row.get("state") != null) ? Integer.parseInt(row.get("state").toString()) : -1;
                    if(state != 0) continue;
                    String rawDate = String.valueOf(row.get("create_date"));
                    String createDate = rawDate;
                    try {
                        if (rawDate != null && !rawDate.equals("null")) {
                            java.time.LocalDateTime dt = java.time.LocalDateTime.parse(rawDate.replace(' ', 'T'));
                            createDate = dt.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                        } else {
                            createDate = "Error";
                        }
                    } catch(Exception e) {
                        createDate = rawDate;
                    }
                    String rawDate2 = String.valueOf(row.get("arrival_date"));
                    String deliveryDate = rawDate2;
                    try {
                      if (rawDate2 != null && !rawDate2.equals("null")) {
                          java.time.LocalDateTime dt = java.time.LocalDateTime.parse(rawDate2.replace(' ', 'T'));
                          deliveryDate = dt.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                      }
                  } catch(Exception e) {
                      deliveryDate = rawDate2;
                  }
              %>
                <tr>
                  <td><%= row.get("id") %></td>
                  <td><%= row.get("fruit_id") %></td>
                  <td><%= row.get("fruit_name") %></td>
                  <td><%= row.get("quantity") %></td>
                  <td>
                    <% 
                       String stateStr = "";
                       String stateColor = "";
                       switch(state) {
                           case 0: stateStr = "Pending"; stateColor = "bg-secondary"; break;
                           case 1: stateStr = "Approved"; stateColor = "bg-primary"; break;
                           case 2: stateStr = "Sending to centre warehouse"; stateColor = "bg-info"; break;
                           case 3: stateStr = "Arrived at centre warehouse"; stateColor = "bg-warning"; break;
                           case 4: stateStr = "Sending to bakery store"; stateColor = "bg-info"; break;
                           case 5: stateStr = "Arrived at bakery store"; stateColor = "bg-warning"; break;
                           case 6: stateStr = "Completed"; stateColor = "bg-success"; break;
                           case 98: stateStr = "Rejected"; stateColor = "bg-danger"; break;
                           case 99: stateStr = "Cancelled"; stateColor = "bg-danger"; break;
                           default: stateStr = "Unknown"; stateColor = "bg-dark"; break;
                       }
                    %>
                    <span class="badge <%= stateColor %>"><%= stateStr %></span>
                  </td>
                  <td>
                    <%= createDate %>
                  </td>
                  <td>
                    <span class="delivery-time" data-delivery="<%= (deliveryDate == null || deliveryDate.equals("null")) ? "" : deliveryDate %>">
                      <%= (deliveryDate == null || deliveryDate.equals("null")) ? "Not start" : deliveryDate %>
                      <% if ("Sending to centre warehouse".equals(stateStr)) { %>
                        <span class="text-info">(Sending to centre warehouse)</span>
                      <% } else if ("Sending to bakery store".equals(stateStr)) { %>
                        <span class="text-info">(Sending to bakery store)</span>
                      <% } %>
                    </span>
                  </td>
                  <td>
                    <button class="btn btn-success btn-sm" onclick="approveOrder(<%= row.get("id") %> , 2)" <%= state != 0  ? "disabled" : "" %>>Approve</button>
                  </td>
                </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      
    </div>
    <!-- Second DataTable: State == 3 -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingThree">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          Reserve Records (Arrived at centre warehouse) (check-in)
        </button>
      </h2>
      <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#fruitAccordion">
        <div class="accordion-body">
          <div style="max-height: 360px; overflow-y: auto;">
            <table class="table table-sm table-striped table-bordered align-middle mb-0">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Fruit ID</th>
                  <th>Fruit Name</th>
                  <th>Quantity (Kg)</th>
                  <th>State</th>
                  <th>Create Date</th>
                  <th>Arrival Date</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <% for(Map<String, Object> row : myReserveRecords) { 
                    int state = (row.get("state") != null) ? Integer.parseInt(row.get("state").toString()) : -1;
                    if(state != 3) continue;
                    String rawDate = String.valueOf(row.get("create_date"));
                    String createDate = rawDate;
                    try {
                        if (rawDate != null && !rawDate.equals("null")) {
                            java.time.LocalDateTime dt = java.time.LocalDateTime.parse(rawDate.replace(' ', 'T'));
                            createDate = dt.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                        } else {
                            createDate = "Error";
                        }
                    } catch(Exception e) {
                        createDate = rawDate;
                    }
                    String rawDate2 = String.valueOf(row.get("arrival_date"));
                    String deliveryDate = rawDate2;
                    try {
                      if (rawDate2 != null && !rawDate2.equals("null")) {
                          java.time.LocalDateTime dt = java.time.LocalDateTime.parse(rawDate2.replace(' ', 'T'));
                          deliveryDate = dt.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
                      }
                  } catch(Exception e) {
                      deliveryDate = rawDate2;
                  }
              %>
                <tr>
                  <td><%= row.get("id") %></td>
                  <td><%= row.get("fruit_id") %></td>
                  <td><%= row.get("fruit_name") %></td>
                  <td><%= row.get("quantity") %></td>
                  <td>
                    <% 
                       String stateStr = "";
                       String stateColor = "";
                       switch(state) {
                           case 0: stateStr = "Pending"; stateColor = "bg-secondary"; break;
                           case 1: stateStr = "Approved"; stateColor = "bg-primary"; break;
                           case 2: stateStr = "Sending to centre warehouse"; stateColor = "bg-info"; break;
                           case 3: stateStr = "Arrived at centre warehouse"; stateColor = "bg-warning"; break;
                           case 4: stateStr = "Sending to bakery store"; stateColor = "bg-info"; break;
                           case 5: stateStr = "Arrived at bakery store"; stateColor = "bg-warning"; break;
                           case 6: stateStr = "Completed"; stateColor = "bg-success"; break;
                           case 98: stateStr = "Rejected"; stateColor = "bg-danger"; break;
                           case 99: stateStr = "Cancelled"; stateColor = "bg-danger"; break;
                           default: stateStr = "Unknown"; stateColor = "bg-dark"; break;
                       }
                    %>
                    <span class="badge <%= stateColor %>"><%= stateStr %></span>
                  </td>
                  <td>
                    <%= createDate %>
                  </td>
                  <td>
                    <span class="delivery-time" data-delivery="<%= (deliveryDate == null || deliveryDate.equals("null")) ? "" : deliveryDate %>">
                      <%= (deliveryDate == null || deliveryDate.equals("null")) ? "Not start" : deliveryDate %>
                      <% if ("Sending to centre warehouse".equals(stateStr)) { %>
                        <span class="text-info">(Sending to centre warehouse)</span>
                      <% } else if ("Sending to bakery store".equals(stateStr)) { %>
                        <span class="text-info">(Sending to bakery store)</span>
                      <% } %>
                    </span>
                  </td>
                  <td>
                    <button class="btn btn-success btn-sm" onclick="approveOrder(<%= row.get("id") %> , 5)" <%= state != 3  ? "disabled" : "" %>>Approve</button>
                  </td>
                </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>

function approveOrder(id, state) {
    // Validate the ID first
    if (!id || isNaN(id)) {
        alert("Invalid reservation ID");
        return;
    }

    var contextPath = '<%= request.getContextPath() %>';
    
    // Confirm with the user before proceeding
    if (!confirm("Are you sure you want to confirm receipt of this order?")) {
        return;
    }

    fetch(contextPath + '/createReserveOrder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            id: id,
            action: 'updateState',
            state: state
        })
    })
    .then(response => {
        if (!response.ok) {
            // Try to get error message from response if possible
            return response.json().then(errData => {
                throw new Error(errData.message || 'Network response was not ok');
            }).catch(() => {
                throw new Error('Network response was not ok');
            });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            alert(data.message);
            // Reload the content to show updated status
            window.parent.loadContent('./component/approve.jsp');
        } else {
            alert('Failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred: ' + error.message);
    });
}

function approveAllPendingOrders() {
    var ids = [
        <% boolean first = true;
           for(Map<String, Object> row : myReserveRecords) { 
               int state = (row.get("state") != null) ? Integer.parseInt(row.get("state").toString()) : -1;
               if(state != 0) continue;
               if (!first) out.print(","); first = false;
        %><%= row.get("id") %><% } %>
    ];
    if(ids.length === 0) {
        alert('No pending orders to approve.');
        return;
    }
    if(confirm('Are you sure you want to approve all pending orders?')) {
        ids.forEach(function(id) {
          approveOrderNoAlert(id, 3);
        });
    }
    window.parent.loadContent('./component/approve.jsp');
}


function approveOrderNoAlert(id, state) {

    var contextPath = '<%= request.getContextPath() %>';
    
    fetch(contextPath + '/createReserveOrder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            id: id,
            action: 'updateState',
            state: state
        })
    })
    .then(response => {
        if (!response.ok) {
            // Try to get error message from response if possible
            return response.json().then(errData => {
                throw new Error(errData.message || 'Network response was not ok');
            }).catch(() => {
                throw new Error('Network response was not ok');
            });
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
        } else {
            alert('Failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred: ' + error.message);
    });
}
</script>

<!-- Bootstrap CSS/JS (if not already included) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
