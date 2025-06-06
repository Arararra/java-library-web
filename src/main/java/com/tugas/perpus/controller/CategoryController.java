package com.tugas.perpus.controller;

import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

  public Category getCategoryById(int id) {
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String query = "SELECT id, name FROM categories WHERE id = ?";

      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);

        try (ResultSet resultSet = statement.executeQuery()) {
          if (resultSet.next()) {
            String name = resultSet.getString("name");
            return new Category(id, name);
          }
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    return null;
  }

  public String updateCategory(int id, String name) {
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String query = "UPDATE categories SET name = ? WHERE id = ?";
      
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, name);
        statement.setInt(2, id);

        int rowsUpdated = statement.executeUpdate();
        if (rowsUpdated > 0) {
          return null; // No error message, operation successful
        } else {
          return "Kategori dengan ID " + id + " tidak ditemukan";
        }
      } catch (SQLException e) {
        return "Error saat memperbarui kategori: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public String deleteCategory(int id) {
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String query = "DELETE FROM categories WHERE id = ?";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);

        int rowsDeleted = statement.executeUpdate();
        if (rowsDeleted > 0) {
          return null; // No error message, operation successful
        } else {
          return "Kategori dengan ID " + id + " tidak ditemukan";
        }
      } catch (SQLException e) {
        return "Error saat menghapus kategori: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }
}
