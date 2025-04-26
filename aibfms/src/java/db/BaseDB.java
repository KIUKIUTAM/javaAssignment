package db;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaseDB {
    protected String jdbcUrl;
    protected String username;
    protected String password;
    
    public BaseDB(String jdbcUrl, String username, String password) {
        this.jdbcUrl = jdbcUrl;
        this.username = username;
        this.password = password;
    }

    protected Connection getConnection() throws SQLException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            throw new IOException("MySQL JDBC Driver not found", ex);
        }
        return DriverManager.getConnection(jdbcUrl, username, password);
    }

    protected void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            System.err.println("Error closing database resources: " + ex.getMessage());
        }
    }

    protected void closeResources(Connection conn, Statement stmt) {
        closeResources(conn, stmt, null);
    }

    protected boolean executeUpdate(String sql, Object... params) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            
            int rowsAffected = pstmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException | IOException ex) {
            System.err.println("Error executing update: " + ex.getMessage());
        } finally {
            closeResources(conn, pstmt);
        }
        
        return success;
    }

    protected <T> List<T> executeQuery(String sql, ResultSetMapper<T> mapper, Object... params) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<T> results = new ArrayList<>();
        
        try {
            conn = getConnection();
            pstmt = conn.prepareStatement(sql);
            
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            
            rs = pstmt.executeQuery();
            while (rs.next()) {
                results.add(mapper.map(rs));
            }
        } catch (SQLException | IOException ex) {
            System.err.println("Error executing query: " + ex.getMessage());
        } finally {
            closeResources(conn, pstmt, rs);
        }
        
        return results;
    }

    protected <T> T executeQuerySingle(String sql, ResultSetMapper<T> mapper, Object... params) {
        List<T> results = executeQuery(sql, mapper, params);
        return results.isEmpty() ? null : results.get(0);
    }

    

    protected boolean dropTable(String tableName) {
        String sql = "DROP TABLE IF EXISTS " + tableName;
        return executeUpdate(sql);
    }

    /**
     * Execute a SQL query and return the result as a List of Map<String, Object>.
     * Each map represents a row, with column names as keys and column values as values.
     * Resources are automatically closed.
     */
    public List<Map<String, Object>> executeQueryToMapList(String sql, Object... params) {
        List<Map<String, Object>> resultList = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            for (int i = 0; i < params.length; i++) {
                pstmt.setObject(i + 1, params[i]);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    for (int i = 1; i <= columnCount; i++) {
                        row.put(metaData.getColumnLabel(i), rs.getObject(i));
                    }
                    resultList.add(row);
                }
            }
        } catch (SQLException | IOException ex) {
            System.err.println("Error executing query to map list: " + ex.getMessage());
        }
        return resultList;
    }

    public interface ResultSetMapper<T> {
        T map(ResultSet rs) throws SQLException;
    }
}