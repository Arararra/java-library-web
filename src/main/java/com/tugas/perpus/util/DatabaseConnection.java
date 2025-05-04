/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.util;

/**
 *
 * @author LENOVO
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
  private static final String URL = "jdbc:mysql://localhost:8888/database_name";
  private static final String USER = "root";
  private static final String PASSWORD = "";

  private static Connection connection;

  public static Connection getConnection() {
    if (connection == null) {
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("Database connection established successfully.");
      } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        System.out.println("Failed to establish database connection.");
      }
    }
    return connection;
  }

  public static void closeConnection() {
    if (connection != null) {
      try {
        connection.close();
        connection = null;
        System.out.println("Database connection closed.");
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
  }
}