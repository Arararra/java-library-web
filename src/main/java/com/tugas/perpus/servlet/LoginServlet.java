package com.tugas.perpus.servlet;

import com.tugas.perpus.model.User;
import com.tugas.perpus.util.DatabaseConnection;
import com.tugas.perpus.util.PasswordHelper;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Connection conn = DatabaseConnection.getConnection();
        if (conn != null) {
            String sql = "SELECT * FROM users WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String hashedPassword = rs.getString("password");
                        if (PasswordHelper.verifyPassword(password, hashedPassword)) {
                            User user = new User(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getString("email"),
                                rs.getString("phone"),
                                rs.getString("address"),
                                rs.getString("role")
                            );
                            HttpSession session = request.getSession();
                            session.setAttribute("user", user);
                            response.sendRedirect(request.getContextPath());
                            return;
                        } else {
                            request.setAttribute("error", "Password salah!");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                            return;
                        }
                    } else {
                        request.setAttribute("error", "Email tidak ditemukan!");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Terjadi kesalahan. Silakan coba lagi.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        }
        request.setAttribute("error", "Terjadi kesalahan. Silakan coba lagi.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
