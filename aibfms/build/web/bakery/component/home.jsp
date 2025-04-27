<%@ taglib prefix="stock" uri="/WEB-INF/tld/stock" %>
<%
    String bakeryUserId = (String) session.getAttribute("bakeryUserId");
%>
<stock:stockTable bakeryUserId="<%= bakeryUserId %>" />