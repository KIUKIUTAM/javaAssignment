<%@ page import="java.util.List,java.util.Map" %>

<h1>Reserve</h1>

<jsp:useBean id="reserveService" class="service.ReserveService" scope="page" />
<%
    List<Map<String, Object>> fruitsWithCity = reserveService.getAllFruitsWithCity();
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
    List<Map<String, Object>> myReserveRecords = reserveService.getReserveRecordsByBakeryId(bakeryUserId);
%>

<!-- Bootstrap container for consistent horizontal margin -->
<div class="container">
  <!-- Add horizontal margin to the accordion -->
  <div class="accordion mx-3" id="fruitAccordion">
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingOne">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
          Fruits List
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#fruitAccordion">
        <div class="accordion-body">
          <div style="max-height: 360px; overflow-y: auto;">
            <table class="table table-sm table-striped table-bordered align-middle mb-0">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>City</th>
                  <th>Shelf Life(Day)</th>
                  <th>Reserve</th>
                </tr>
              </thead>
              <tbody>
              <% for(Map<String, Object> row : fruitsWithCity) { %>
                <tr>
                  <td><%= row.get("id") %></td>
                  <td><%= row.get("fruit_name") %></td>
                  <td><%= row.get("city") %></td>
                  <td><%= row.get("shelf_life") %></td>
                  <td>
                    <button type="button" class="btn btn-primary btn-sm" onclick="reserveFruit(<%= row.get("id") != null ? row.get("id") : 0 %>)">Reserve</button>
                  </td>
                </tr>
              <% } %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

    <!-- Second Accordion: My Reserve Records -->
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingTwo">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          Store Reserve Records
        </button>
      </h2>
      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#fruitAccordion">
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
                  <th>Delivery Time</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
              <% for(Map<String, Object> row : myReserveRecords) { 
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
                    String rawDate2 = String.valueOf(row.get("delivery_date"));
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
                    <% int state = (row.get("state") != null) ? Integer.parseInt(row.get("state").toString()) : -1;
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
                    <button class="btn btn-primary btn-sm" onclick="confirmFruit(<%= row.get("id") %>)" <%= state != 5 ? "disabled" : "" %>>Confirm</button>
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
function reserveFruit(fruitId) {
    var contextPath = '<%= request.getContextPath() %>';
    var quantity = prompt("Enter quantity (Kg):");
    if (quantity == null || quantity.trim() === "") {
        alert("Quantity cannot be empty");
        return;
    }
    var bakeryUserId = '<%= bakeryUserId != null ? bakeryUserId : "" %>';
    fetch(contextPath + '/createReserveOrder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            fruitId: fruitId,
            bakeryUserId: <%= bakeryUserId %>,
            quantity: quantity,
            action: 'reserve'
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
            window.parent.loadContent('./component/reserve.jsp');
          } else {
            alert('Failed: ' + data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred: ' + error.message);
    });
}

function confirmFruit(id) {
    var contextPath = '<%= request.getContextPath() %>';
    fetch(contextPath + '/confirmReserveOrder', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
            id: id,
            action: 'StoreConfirm'
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
            window.parent.loadContent('./component/reserve.jsp');
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
