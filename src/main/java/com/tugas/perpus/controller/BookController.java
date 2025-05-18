/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.controller;

import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.model.Book;
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
public class BookController {
  public List<Book> getBooksFromDatabase() {
    List<Book> books = new ArrayList<>();
    Connection connection = DatabaseConnection.getConnection();

    if (connection != null) {
      String query = "SELECT b.id, b.title, b.stock, b.author, b.publisher, c.id AS category_id, c.name AS category_name " +
                     "FROM books b " +
                     "JOIN categories c ON b.category_id = c.id";
      try (PreparedStatement statement = connection.prepareStatement(query);
           ResultSet resultSet = statement.executeQuery()) {

        while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String title = resultSet.getString("title");
          int stock = resultSet.getInt("stock");
          String author = resultSet.getString("author");
          String publisher = resultSet.getString("publisher");
          int categoryId = resultSet.getInt("category_id");
          String categoryName = resultSet.getString("category_name");

          Category category = new Category(categoryId, categoryName);
          books.add(new Book(id, title, category, stock, author, publisher));
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    return books;
  }

  public String insertBook(String title, int categoryId, int stock, String author, String publisher) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "INSERT INTO books (title, category_id, stock, author, publisher) VALUES (?, ?, ?, ?, ?)";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, title);
        statement.setInt(2, categoryId);
        statement.setInt(3, stock);
        statement.setString(4, author);
        statement.setString(5, publisher);
        statement.executeUpdate();
        return null; // success
      } catch (SQLException e) {
        return "Error saat menambah buku: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public String updateBook(int id, String title, int categoryId, int stock, String author, String publisher) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "UPDATE books SET title=?, category_id=?, stock=?, author=?, publisher=? WHERE id=?";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, title);
        statement.setInt(2, categoryId);
        statement.setInt(3, stock);
        statement.setString(4, author);
        statement.setString(5, publisher);
        statement.setInt(6, id);
        int rows = statement.executeUpdate();
        if (rows > 0) {
          return null;
        } else {
          return "Buku dengan ID " + id + " tidak ditemukan.";
        }
      } catch (SQLException e) {
        return "Error saat mengedit buku: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public Book getBookById(int id) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "SELECT b.id, b.title, b.stock, b.author, b.publisher, c.id AS category_id, c.name AS category_name FROM books b JOIN categories c ON b.category_id = c.id WHERE b.id = ?";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);
        try (ResultSet resultSet = statement.executeQuery()) {
          if (resultSet.next()) {
            String title = resultSet.getString("title");
            int stock = resultSet.getInt("stock");
            String author = resultSet.getString("author");
            String publisher = resultSet.getString("publisher");
            int categoryId = resultSet.getInt("category_id");
            String categoryName = resultSet.getString("category_name");
            Category category = new Category(categoryId, categoryName);
            return new Book(id, title, category, stock, author, publisher);
          }
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    return null;
  }

  public String deleteBook(int id) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "DELETE FROM books WHERE id = ?";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);
        int rows = statement.executeUpdate();
        if (rows > 0) {
          return null;
        } else {
          return "Buku dengan ID " + id + " tidak ditemukan.";
        }
      } catch (SQLException e) {
        return "Error saat menghapus buku: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }
}