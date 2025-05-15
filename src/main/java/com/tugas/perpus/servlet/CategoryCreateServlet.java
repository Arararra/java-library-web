package com.tugas.perpus.servlet;

import java.io.IOException;

import com.tugas.perpus.controller.CategoryController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoryCreateServlet", urlPatterns = {"/category/create"})
public class CategoryCreateServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    System.out.println("CategoryCreateServlet doGet() called");
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String name = request.getParameter("name");

    if (name == null || name.trim().isEmpty()) {
      request.getSession().setAttribute("error", "Nama kategori tidak boleh kosong.");
      response.sendRedirect(request.getContextPath() + "/category/create.jsp");
      return;
    }

    CategoryController controller = new CategoryController();
    try {
      String errorMessage = controller.createCategory(name);
      if (errorMessage == null) {
        request.getSession().setAttribute("successMessage", "Kategori berhasil ditambahkan.");
        response.sendRedirect(request.getContextPath() + "/category/index.jsp");
      } else {
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect(request.getContextPath() + "/category/create.jsp");
      }
    } catch (Exception e) {
      request.getSession().setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
      response.sendRedirect(request.getContextPath() + "/category/create.jsp");
    }
  }
}
