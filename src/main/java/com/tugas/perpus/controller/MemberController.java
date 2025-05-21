package com.tugas.perpus.controller;

import com.tugas.perpus.model.Member;
import com.tugas.perpus.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MemberController {
  public List<Member> getMembersFromDatabase() {
    List<Member> members = new ArrayList<>();
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "SELECT id, name, email, phone, address, role FROM users WHERE role = 'member'";
      try (PreparedStatement statement = connection.prepareStatement(query);
           ResultSet resultSet = statement.executeQuery()) {
        while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String name = resultSet.getString("name");
          String email = resultSet.getString("email");
          String phone = resultSet.getString("phone");
          String address = resultSet.getString("address");
          String role = resultSet.getString("role");
          Member member = new Member(id, name, email, phone, address);
          member.setRole(role);
          members.add(member);
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    return members;
  }

  public String insertMember(String name, String email, String address, String phone, String role) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      // Cek email dan telepon unik
      String checkQuery = "SELECT COUNT(*) FROM users WHERE email = ? OR phone = ?";
      try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
        checkStmt.setString(1, email);
        checkStmt.setString(2, phone);
        try (ResultSet rs = checkStmt.executeQuery()) {
          if (rs.next() && rs.getInt(1) > 0) {
            return "Email atau nomor telepon sudah digunakan oleh user lain.";
          }
        }
      } catch (SQLException e) {
        return "Error saat validasi email/telepon: " + e.getMessage();
      }
      // Insert jika unik
      String query = "INSERT INTO users (name, email, address, phone, role) VALUES (?, ?, ?, ?, ?)";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, name);
        statement.setString(2, email);
        statement.setString(3, address);
        statement.setString(4, phone);
        statement.setString(5, role);
        statement.executeUpdate();
        return null;
      } catch (SQLException e) {
        return "Error saat menambah member: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public Member getMemberById(int id) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "SELECT id, name, email, phone, address, role FROM users WHERE id = ? AND role = 'member'";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);
        try (ResultSet resultSet = statement.executeQuery()) {
          if (resultSet.next()) {
            String name = resultSet.getString("name");
            String email = resultSet.getString("email");
            String phone = resultSet.getString("phone");
            String address = resultSet.getString("address");
            String role = resultSet.getString("role");
            Member member = new Member(id, name, email, phone, address);
            member.setRole(role);
            return member;
          }
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    return null;
  }

  public String updateMember(int id, String name, String email, String address, String phone, String role) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      // Validasi email dan telepon unik, kecuali untuk user ini sendiri
      String checkQuery = "SELECT COUNT(*) FROM users WHERE (email = ? OR phone = ?) AND id <> ?";
      try (PreparedStatement checkStmt = connection.prepareStatement(checkQuery)) {
        checkStmt.setString(1, email);
        checkStmt.setString(2, phone);
        checkStmt.setInt(3, id);
        try (ResultSet rs = checkStmt.executeQuery()) {
          if (rs.next() && rs.getInt(1) > 0) {
            return "Email atau nomor telepon sudah digunakan oleh user lain.";
          }
        }
      } catch (SQLException e) {
        return "Error saat validasi email/telepon: " + e.getMessage();
      }
      // Update jika unik
      String query = "UPDATE users SET name=?, email=?, address=?, phone=?, role=? WHERE id=? AND role = 'member'";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, name);
        statement.setString(2, email);
        statement.setString(3, address);
        statement.setString(4, phone);
        statement.setString(5, role);
        statement.setInt(6, id);
        int rows = statement.executeUpdate();
        if (rows > 0) {
          return null;
        } else {
          return "Member dengan ID " + id + " tidak ditemukan.";
        }
      } catch (SQLException e) {
        return "Error saat mengedit member: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public String deleteMember(int id) {
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query = "DELETE FROM users WHERE id = ? AND role = 'member'";
      try (PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setInt(1, id);
        int rows = statement.executeUpdate();
        if (rows > 0) {
          return null;
        } else {
          return "Member dengan ID " + id + " tidak ditemukan.";
        }
      } catch (SQLException e) {
        return "Error saat menghapus member: " + e.getMessage();
      }
    } else {
      return "Koneksi ke database gagal.";
    }
  }

  public List<Member> getEligibleMembersForBorrow() {
    List<Member> members = new ArrayList<>();
    Connection connection = DatabaseConnection.getConnection();
    if (connection != null) {
      String query =
        "SELECT u.id, u.name, u.email, u.phone, u.address, u.role " +
        "FROM users u " +
        "WHERE u.role = 'member' AND (" +
        // Tidak ada transaksi sama sekali
        "NOT EXISTS (SELECT 1 FROM transactions t WHERE t.user_id = u.id) " +
        "OR " +
        // Semua transaksi sudah dikembalikan (tidak ada transaksi return_date IS NULL)
        "(NOT EXISTS (SELECT 1 FROM transactions t2 WHERE t2.user_id = u.id AND t2.return_date IS NULL))" +
        ")";
      try (PreparedStatement statement = connection.prepareStatement(query);
           ResultSet resultSet = statement.executeQuery()) {
        while (resultSet.next()) {
          int id = resultSet.getInt("id");
          String name = resultSet.getString("name");
          String email = resultSet.getString("email");
          String phone = resultSet.getString("phone");
          String address = resultSet.getString("address");
          String role = resultSet.getString("role");
          Member member = new Member(id, name, email, phone, address);
          member.setRole(role);
          members.add(member);
        }
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }
    return members;
  }
}
