/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.controller;

import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class CategoryController {
  public List<Category> getCategoriesFromDatabase() {
    List<Category> categories = new ArrayList<>();
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String query = "SELECT id, name FROM categories";
      try (PreparedStatement statement = connection.prepareStatement(query);
           ResultSet resultSet = statement.executeQuery()) {

        while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String name = resultSet.getString("name");
          categories.add(new Category(id, name));
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    return categories;
  }

  public String createCategory(String name) throws SQLException {
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String sql = "INSERT INTO categories (name) VALUES (?)";
      try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, name);
        stmt.executeUpdate();
        return null; // No error message, operation successful
      } catch (SQLException e) {
        return "Error saat menyimpan kategori: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }
}
