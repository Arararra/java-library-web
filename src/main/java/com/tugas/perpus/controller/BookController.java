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
}