package com.tugas.perpus.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tugas.perpus.controller.CategoryController;

@WebServlet(name = "CategoryDeleteServlet", urlPatterns = {"/category/delete/*"})
public class CategoryDeleteServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }

    try {
      int id = Integer.parseInt(idParam);
      CategoryController categoryController = new CategoryController();
      String errorMessage = categoryController.deleteCategory(id);

      if (errorMessage != null) {
        request.getSession().setAttribute("error", errorMessage);
      } else {
        request.getSession().setAttribute("successMessage", "Kategori berhasil dihapus");
      }

      response.sendRedirect(request.getContextPath() + "/category/index.jsp");
    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
    }
  }
}
