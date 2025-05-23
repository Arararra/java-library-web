package com.tugas.perpus.controller;

import com.tugas.perpus.model.Fine;
import com.tugas.perpus.model.User;
import com.tugas.perpus.model.Transaction;
import com.tugas.perpus.util.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class FineController {
    public List<Fine> getFinesFromDatabase(User user) {
        List<Fine> fines = new ArrayList<>();
        Connection connection = DatabaseConnection.getConnection();
        if (connection != null) {
            String query = "SELECT f.id as fine_id, f.transaction_id, f.status, t.borrow_date, t.due_date, t.return_date, t.user_id " +
                    "FROM fines f JOIN transactions t ON f.transaction_id = t.id";
            if (user != null && "member".equals(user.getRole())) {
                query += " WHERE t.user_id = ?";
            }
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                if (user != null && "member".equals(user.getRole())) {
                    statement.setInt(1, user.getId());
                }
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int fineId = resultSet.getInt("fine_id");
                        int transactionId = resultSet.getInt("transaction_id");
                        int status = resultSet.getInt("status");
                        LocalDate borrowDate = resultSet.getDate("borrow_date").toLocalDate();
                        LocalDate dueDate = resultSet.getDate("due_date").toLocalDate();
                        Date returnDateSql = resultSet.getDate("return_date");
                        LocalDate returnDate = returnDateSql != null ? returnDateSql.toLocalDate() : null;
                        Transaction trx = new Transaction(transactionId, null, null, borrowDate, dueDate);
                        trx.setReturnDate(returnDate);
                        Fine fine = new Fine(fineId, trx);
                        fine.setStatus(status);
                        // Hitung total denda
                        long daysLate = 0;
                        if (status == 1 && returnDate != null && returnDate.isAfter(dueDate)) {
                            daysLate = ChronoUnit.DAYS.between(dueDate, returnDate);
                        } else if (status == 0 && LocalDate.now().isAfter(dueDate)) {
                            daysLate = ChronoUnit.DAYS.between(dueDate, LocalDate.now());
                        }
                        long totalDenda = daysLate > 0 ? daysLate * 10000 : 0;
                        fine.setTotalDenda(totalDenda);
                        fines.add(fine);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return fines;
    }

    public String payFine(int fineId) {
        Connection connection = DatabaseConnection.getConnection();
        if (connection == null) {
            return "Koneksi ke database gagal.";
        }
        try {
            // Ambil transaction_id dari fine
            int transactionId = -1;
            String selectQuery = "SELECT transaction_id FROM fines WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, fineId);
                try (ResultSet rs = selectStmt.executeQuery()) {
                    if (rs.next()) {
                        transactionId = rs.getInt("transaction_id");
                    } else {
                        return "Denda tidak ditemukan.";
                    }
                }
            }
            // Update status fine menjadi 1
            String updateFine = "UPDATE fines SET status = 1 WHERE id = ?";
            try (PreparedStatement updateStmt = connection.prepareStatement(updateFine)) {
                updateStmt.setInt(1, fineId);
                updateStmt.executeUpdate();
            }
            // Selesaikan transaksi (set return_date dan update stok buku)
            TransactionController trxController = new TransactionController();
            String err = trxController.finishTransaction(transactionId);
            if (err != null && !err.contains("sudah selesai")) {
                return err;
            }
            return null;
        } catch (SQLException e) {
            return "Error saat membayar denda: " + e.getMessage();
        }
    }
}
