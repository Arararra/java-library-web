package com.tugas.perpus.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tugas.perpus.model.Category;
import com.tugas.perpus.controller.CategoryController;

@WebServlet(name = "CategoryEditServlet", urlPatterns = {"/category/edit/*"})
public class CategoryEditServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }

    try {
      int id = Integer.parseInt(idParam);
      CategoryController categoryController = new CategoryController();
      Category category = categoryController.getCategoryById(id);

      if (category == null) {
        request.getSession().setAttribute("errorMessage", "Kategori dengan ID " + id + " tidak ditemukan");
        response.sendRedirect(request.getContextPath() + "/category/index.jsp");
        return;
      }

      request.setAttribute("category", category);
      request.getRequestDispatcher("/category/edit.jsp").forward(request, response);
    } catch (NumberFormatException | NullPointerException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }

    try {
      int id = Integer.parseInt(idParam);
      String name = request.getParameter("name");

      if (name == null || name.trim().isEmpty()) {
        request.getSession().setAttribute("error", "Nama kategori tidak boleh kosong");
        response.sendRedirect(request.getContextPath() + "/category/edit/" + id);
        return;
      }

      CategoryController categoryController = new CategoryController();
      String errorMessage = categoryController.updateCategory(id, name);

      if (errorMessage != null) {
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect(request.getContextPath() + "/category/edit/" + id);
      } else {
        request.getSession().setAttribute("successMessage", "Kategori berhasil diperbarui");
        response.sendRedirect(request.getContextPath() + "/category/index.jsp");
      }
    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
    }
  }
}
