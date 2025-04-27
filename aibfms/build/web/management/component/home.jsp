<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="service.FruitAnalysisService"%>
<%@page import="java.util.*"%>
<%@page import="org.json.JSONArray"%>
<%
    FruitAnalysisService analysisService = new FruitAnalysisService();
    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
    
    List<Map<String, Object>> consumptionData = analysisService.getBakeryFruitConsumption(currentYear);
    List<Map<String, Object>> reservationData = analysisService.getBakeryFruitReservation(currentYear);
    List<Map<String, Object>> monthlyData = analysisService.getMonthlyFruitConsumption();
    List<Map<String, Object>> cityData = analysisService.getCityFruitConsumption();
%>

<div class="container-fluid mt-4">
    <div class="row">
        <!-- 圖表區域 -->
        <div class="col-12 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Fruit Consumption Overview</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <canvas id="monthlyChart"></canvas>
                        </div>
                        <div class="col-md-6">
                            <canvas id="cityChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 消耗統計表格 -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Bakery Fruit Consumption <%=currentYear%></h5>
                </div>
                <div class="card-body">
                    <table id="consumptionTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Bakery</th>
                                <th>Fruit</th>
                                <th>Total Consumed (kg)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Map<String, Object> row : consumptionData) { %>
                            <tr>
                                <td><%=row.get("bakery_name")%></td>
                                <td><%=row.get("fruit_name")%></td>
                                <td><%=row.get("total_consumed")%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 預訂統計表格 -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Fruit Reservations <%=currentYear%></h5>
                </div>
                <div class="card-body">
                    <table id="reservationTable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Bakery</th>
                                <th>Fruit</th>
                                <th>Total Reserved</th>
                                <th>State</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(Map<String, Object> row : reservationData) { %>
                            <tr>
                                <td><%=row.get("bakery_name")%></td>
                                <td><%=row.get("fruit_name")%></td>
                                <td><%=row.get("total_reserved")%></td>
                                <td><%=row.get("state")%></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 引入必要的 CSS -->
<link href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
<link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.bootstrap5.min.css" rel="stylesheet">

<!-- 引入必要的 JS -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.bootstrap5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
$(document).ready(function() {
    // 初始化 DataTables
    $('#consumptionTable').DataTable({
        dom: 'Bfrtip',
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        pageLength: 10,
        order: [[2, 'desc']]
    });

    $('#reservationTable').DataTable({
        dom: 'Bfrtip',
        buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
        pageLength: 10,
        order: [[2, 'desc']]
    });

    // 準備月度消耗圖表數據
    const monthlyData = JSON.parse('<%=new JSONArray(monthlyData).toString()%>');
    const monthLabels = [...new Set(monthlyData.map(item => item.month))];
    const bakeries = [...new Set(monthlyData.map(item => item.bakery_name))];
    
    const monthlyChartData = {
        labels: monthLabels,
        datasets: bakeries.map((bakery, index) => ({
            label: bakery,
            data: monthLabels.map(month => {
                const entry = monthlyData.find(item => 
                    item.month === month && item.bakery_name === bakery
                );
                return entry ? entry.monthly_consumed : 0;
            }),
            fill: false,
            borderColor: getColor(index),
            tension: 0.1
        }))
    };

    // 繪製月度消耗圖表
    new Chart(document.getElementById('monthlyChart'), {
        type: 'line',
        data: monthlyChartData,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Monthly Fruit Consumption by Bakery'
                },
                legend: {
                    position: 'bottom'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Consumption (kg)'
                    }
                }
            }
        }
    });

    // 準備城市消耗圖表數據
    const cityData = JSON.parse('<%=new JSONArray(cityData).toString()%>');
    const cities = [...new Set(cityData.map(item => item.city))];
    const fruits = [...new Set(cityData.map(item => item.fruit_name))];
    
    const cityChartData = {
        labels: cities,
        datasets: fruits.map((fruit, index) => ({
            label: fruit,
            data: cities.map(city => {
                const entry = cityData.find(item => 
                    item.city === city && item.fruit_name === fruit
                );
                return entry ? entry.total_consumed : 0;
            }),
            backgroundColor: getColor(index)
        }))
    };

    // 繪製城市消耗圖表
    new Chart(document.getElementById('cityChart'), {
        type: 'bar',
        data: cityChartData,
        options: {
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Fruit Consumption by City'
                },
                legend: {
                    position: 'bottom'
                }
            },
            scales: {
                x: {
                    stacked: true
                },
                y: {
                    stacked: true,
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Consumption (kg)'
                    }
                }
            }
        }
    });
});

// 顏色生成函數
function getColor(index) {
    const colors = [
        '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF',
        '#FF9F40', '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'
    ];
    return colors[index % colors.length];
}
</script>

