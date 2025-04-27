function initializeCharts(data) {
    // 初始化月度趨勢圖表
    const monthlyCtx = document.getElementById('monthlyTrendChart').getContext('2d');
    const monthlyData = data.monthlyConsumption;
    
    new Chart(monthlyCtx, {
        type: 'line',
        data: {
            labels: monthlyData.map(item => item.month),
            datasets: [{
                label: 'Monthly Consumption',
                data: monthlyData.map(item => item.total_consumption),
                borderColor: 'rgb(75, 192, 192)',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Monthly Consumption Trends'
                }
            }
        }
    });

    // 初始化城市消耗分布圖表
    const cityCtx = document.getElementById('cityConsumptionChart').getContext('2d');
    const cityData = data.cityConsumption;
    
    new Chart(cityCtx, {
        type: 'bar',
        data: {
            labels: cityData.map(item => item.city),
            datasets: [{
                label: 'City Consumption',
                data: cityData.map(item => item.total_consumption),
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                    'rgba(75, 192, 192, 0.5)',
                    'rgba(153, 102, 255, 0.5)'
                ]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Consumption by City'
                }
            }
        }
    });

    // 初始化 DataTable
    $(document).ready(function() {
        $('#consumptionTable').DataTable({
            dom: 'Bfrtip',
            buttons: [
                'copy', 'csv', 'excel', 'pdf', 'print'
            ]
        });
    });
} 