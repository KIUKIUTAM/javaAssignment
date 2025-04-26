/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db.impl;


import entity.City;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import db.BaseDB;

public class CityDB extends BaseDB {

    public CityDB(String jdbcUrl, String username, String password) {
        super(jdbcUrl, username, password);
    }

    public boolean addCity(String city, String country) {
        String sql = "INSERT INTO cities (city, country) VALUES (?, ?)";
        return executeUpdate(sql, city, country);
    }

    public City getCityById(int id) {
        String sql = "SELECT * FROM cities WHERE id=?";
        return executeQuerySingle(sql, this::mapCity, id);
    }

    public List<City> getAllCities() {
        String sql = "SELECT * FROM cities";
        return executeQuery(sql, this::mapCity);
    }

    public boolean updateCity(City city) {
        String sql = "UPDATE cities SET city=?, country=? WHERE id=?";
        return executeUpdate(sql, city.getCity(), city.getCountry(), city.getId());
    }

    public boolean deleteCity(int id) {
        String sql = "DELETE FROM cities WHERE id=?";
        return executeUpdate(sql, id);
    }

    private City mapCity(ResultSet rs) throws SQLException {
        City city = new City();
        city.setId(rs.getInt("id"));
        city.setCity(rs.getString("city"));
        city.setCountry(rs.getString("country"));
        return city;
    }
}