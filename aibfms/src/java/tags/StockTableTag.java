package tags;

import service.StockService;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.text.DecimalFormat;

public class StockTableTag extends SimpleTagSupport {
    private String bakeryUserId;
    
    public void setBakeryUserId(String bakeryUserId) {
        this.bakeryUserId = bakeryUserId;
    }
    
    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        StockService stockService = new StockService();
        List<Map<String, Object>> records = stockService.getStockRecordsGroupByFruitByBakeryId(bakeryUserId);
        
        DecimalFormat df = new DecimalFormat("#,##0.00");
        
        StringBuilder html = new StringBuilder();
        html.append("<div class='container-fluid mx-3 my-4'>")
            .append("<div class='card shadow-sm'>")
            .append("<div class='card-header bg-primary text-white'>")
            .append("<h5 class='card-title mb-0'>Fruits Stock Report</h5>")
            .append("</div>")
            .append("<div class='card-body'>")
            .append("<div class='table-responsive'>")
            .append("<table class='table table-hover table-striped align-middle mb-0'>")
            .append("<thead class='table-light'>")
            .append("<tr class='text-center'>")
            .append("<th class='text-start'>Fruits Name</th>")
            .append("<th style='width: 30%'>Total Stock (kg)</th>")
            .append("</tr>")
            .append("</thead>")
            .append("<tbody>");
        
        for (Map<String, Object> record : records) {
            String fruitName = (String) record.get("fruit_name");
            Double totalStock = ((Number) record.get("total_stock_kg")).doubleValue();
            
            html.append("<tr class='text-center'>")
                .append("<td class='text-start'>")
                .append("<i class='bi bi-circle-fill me-2 text-success'></i>") // Bootstrap Icons
                .append(fruitName)
                .append("</td>")
                .append("<td>")
                .append("<span class='badge bg-primary rounded-pill px-3'>")
                .append(df.format(totalStock))
                .append(" kg</span>")
                .append("</td>")
                .append("</tr>");
        }
        
        // 計算總和
        double totalKg = records.stream()
            .mapToDouble(record -> ((Number) record.get("total_stock_kg")).doubleValue())
            .sum();
            
        html.append("</tbody>")
            .append("<tfoot class='table-dark'>")
            .append("<tr class='text-center fw-bold'>")
            .append("<td class='text-start'>Total</td>")
            .append("<td>")
            .append("<span class='badge bg-warning text-dark rounded-pill px-3'>")
            .append(df.format(totalKg))
            .append(" kg</span>")
            .append("</td>")
            .append("</tr>")
            .append("</tfoot>")
            .append("</table>")
            .append("</div>") // table-responsive end
            .append("</div>") // card-body end
            .append("</div>") // card end
            .append("</div>"); // container end
        
        out.println(html.toString());
    }
} 