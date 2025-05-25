package com.tugas.perpus.servlet;

import com.tugas.perpus.model.User;
import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.util.PasswordHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/password-reset")
public class PasswordResetServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("setting.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String error = null;
        String success = null;
        if (oldPassword == null || newPassword == null || oldPassword.isEmpty() || newPassword.isEmpty()) {
            error = "Semua field harus diisi.";
        } else {
            Connection conn = DatabaseConnection.getConnection();
            if (conn != null) {
                try (PreparedStatement stmt = conn.prepareStatement("SELECT password FROM users WHERE id = ?")) {
                    stmt.setInt(1, user.getId());
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            String currentHash = rs.getString("password");
                            if (!PasswordHelper.verifyPassword(oldPassword, currentHash)) {
                                error = "Password lama salah.";
                            } else {
                                try (PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET password = ? WHERE id = ?")) {
                                    updateStmt.setString(1, PasswordHelper.hashPassword(newPassword));
                                    updateStmt.setInt(2, user.getId());
                                    updateStmt.executeUpdate();
                                    success = "Password berhasil diubah.";
                                }
                            }
                        } else {
                            error = "User tidak ditemukan.";
                        }
                    }
                } catch (Exception e) {
                    error = "Terjadi kesalahan: " + e.getMessage();
                }
            } else {
                error = "Koneksi ke database gagal.";
            }
        }
        if (error != null) {
            request.setAttribute("errorMessage", error);
        }
        if (success != null) {
            request.setAttribute("successMessage", success);
        }
        request.getRequestDispatcher("setting.jsp").forward(request, response);
    }
}
