package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.MemberController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MemberCreateServlet", urlPatterns = {"/member/create"})
public class MemberCreateServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String error = (String) request.getSession().getAttribute("error");
    if (error != null) {
      request.setAttribute("error", error);
      request.getSession().removeAttribute("error");
    }
    request.getRequestDispatcher("/member/create.jsp").forward(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String nama = request.getParameter("nama");
    String email = request.getParameter("email");
    String alamat = request.getParameter("alamat");
    String telepon = request.getParameter("telepon");
    String role = request.getParameter("role");

    if (nama == null || nama.trim().isEmpty() || email == null || email.trim().isEmpty() || alamat == null || alamat.trim().isEmpty() || telepon == null || telepon.trim().isEmpty() || role == null || role.trim().isEmpty()) {
      request.getSession().setAttribute("error", "Semua field harus diisi.");
      response.sendRedirect(request.getContextPath() + "/member/create");
      return;
    }

    MemberController memberController = new MemberController();
    String errorMessage = memberController.insertMember(nama, email, alamat, telepon, role);
    if (errorMessage == null) {
      request.getSession().setAttribute("successMessage", "Member berhasil ditambahkan.");
      response.sendRedirect(request.getContextPath() + "/member");
    } else {
      request.getSession().setAttribute("error", errorMessage);
      response.sendRedirect(request.getContextPath() + "/member/create");
    }
  }
}
