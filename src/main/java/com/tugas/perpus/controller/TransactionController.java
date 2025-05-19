package com.tugas.perpus.controller;

import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.model.Transaction;
import com.tugas.perpus.model.Book;
import com.tugas.perpus.model.Member;
import com.tugas.perpus.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;

public class TransactionController {
    public List<Transaction> getTransactionsFromDatabase() {
        List<Transaction> transactions = new ArrayList<>();
        Connection connection = DatabaseConnection.getConnection();

        if (connection != null) {
            String query = "SELECT t.id, u.id as user_id, u.name as user_name, b.id as book_id, b.title as book_title, t.borrow_date, t.due_date, t.return_date, t.status " +
                           "FROM transactions t " +
                           "JOIN users u ON t.user_id = u.id " +
                           "JOIN books b ON t.book_id = b.id";
            try (PreparedStatement statement = connection.prepareStatement(query);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    int userId = resultSet.getInt("user_id");
                    String userName = resultSet.getString("user_name");
                    int bookId = resultSet.getInt("book_id");
                    String bookTitle = resultSet.getString("book_title");
                    Date borrowDate = resultSet.getDate("borrow_date");
                    Date dueDate = resultSet.getDate("due_date");
                    Date returnDate = resultSet.getDate("return_date");
                    int status = resultSet.getInt("status");

                    Book book = new Book(bookId, bookTitle, null, 0, null, null); // Set title
                    User user = new Member(userId, userName, null, null, null); // Set name
                    LocalDate borrowLocal = borrowDate != null ? borrowDate.toLocalDate() : null;
                    LocalDate dueLocal = dueDate != null ? dueDate.toLocalDate() : null;
                    LocalDate returnLocal = returnDate != null ? returnDate.toLocalDate() : null;
                    Transaction trx = new Transaction(id, user, book, borrowLocal, dueLocal, status);
                    trx.setReturnDate(returnLocal); // Set tanggal kembali yang benar
                    transactions.add(trx);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return transactions;
    }

    public String insertTransaction(int userId, int bookId, Date borrowDate, Date dueDate, Date returnDate, int status) {
        Connection connection = DatabaseConnection.getConnection();
        if (connection != null) {
            String query = "INSERT INTO transactions (user_id, book_id, borrow_date, due_date, return_date, status) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, userId);
                statement.setInt(2, bookId);
                statement.setDate(3, borrowDate);
                statement.setDate(4, dueDate);
                statement.setDate(5, returnDate);
                statement.setInt(6, status);
                statement.executeUpdate();
                return null; // success
            } catch (SQLException e) {
                return "Error saat menambah transaksi: " + e.getMessage();
            }
        } else {
            return "Koneksi ke database gagal.";
        }
    }

    public String updateTransaction(int id, int userId, int bookId, Date borrowDate, Date dueDate, Date returnDate, int status) {
        Connection connection = DatabaseConnection.getConnection();
        if (connection != null) {
            String query = "UPDATE transactions SET user_id=?, book_id=?, borrow_date=?, due_date=?, return_date=?, status=? WHERE id=?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, userId);
                statement.setInt(2, bookId);
                statement.setDate(3, borrowDate);
                statement.setDate(4, dueDate);
                statement.setDate(5, returnDate);
                statement.setInt(6, status);
                statement.setInt(7, id);
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    return null;
                } else {
                    return "Transaksi dengan ID " + id + " tidak ditemukan.";
                }
            } catch (SQLException e) {
                return "Error saat mengedit transaksi: " + e.getMessage();
            }
        } else {
            return "Koneksi ke database gagal.";
        }
    }

    public Transaction getTransactionById(int id) {
        Connection connection = DatabaseConnection.getConnection();
        if (connection != null) {
            String query = "SELECT t.id, u.id as user_id, u.name as user_name, b.id as book_id, b.title as book_title, t.borrow_date, t.due_date, t.return_date, t.status " +
                           "FROM transactions t " +
                           "JOIN users u ON t.user_id = u.id " +
                           "JOIN books b ON t.book_id = b.id " +
                           "WHERE t.id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        int userId = resultSet.getInt("user_id");
                        String userName = resultSet.getString("user_name");
                        int bookId = resultSet.getInt("book_id");
                        String bookTitle = resultSet.getString("book_title");
                        Date borrowDate = resultSet.getDate("borrow_date");
                        Date dueDate = resultSet.getDate("due_date");
                        Date returnDate = resultSet.getDate("return_date");
                        int status = resultSet.getInt("status");
                        Book book = new Book(bookId, bookTitle, null, 0, null, null); // Set title
                        User user = new Member(userId, userName, null, null, null); // Set name
                        LocalDate borrowLocal = borrowDate != null ? borrowDate.toLocalDate() : null;
                        LocalDate dueLocal = dueDate != null ? dueDate.toLocalDate() : null;
                        LocalDate returnLocal = returnDate != null ? returnDate.toLocalDate() : null;
                        Transaction trx = new Transaction(id, user, book, borrowLocal, dueLocal, status);
                        trx.setReturnDate(returnLocal); // Set tanggal kembali yang benar
                        return trx;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public String deleteTransaction(int id) {
        Connection connection = DatabaseConnection.getConnection();
        if (connection != null) {
            String query = "DELETE FROM transactions WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, id);
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    return null;
                } else {
                    return "Transaksi dengan ID " + id + " tidak ditemukan.";
                }
            } catch (SQLException e) {
                return "Error saat menghapus transaksi: " + e.getMessage();
            }
        } else {
            return "Koneksi ke database gagal.";
        }
    }
}
