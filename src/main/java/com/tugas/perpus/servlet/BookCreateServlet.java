package com.tugas.perpus.servlet;

import java.io.IOException;
import java.util.List;

import com.tugas.perpus.controller.BookController;
import com.tugas.perpus.controller.CategoryController;
import com.tugas.perpus.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookCreateServlet", urlPatterns = {"/book/create"})
public class BookCreateServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    CategoryController categoryController = new CategoryController();
    List<Category> categories = categoryController.getCategoriesFromDatabase();
    request.setAttribute("categories", categories);
    request.getRequestDispatcher("/book/create.jsp").forward(request, response);
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String title = request.getParameter("title");
    String categoryIdStr = request.getParameter("category_id");
    String stockStr = request.getParameter("stock");
    String author = request.getParameter("writer");
    String publisher = request.getParameter("publisher");

    if (title == null || title.trim().isEmpty() || categoryIdStr == null || stockStr == null || author == null || publisher == null
        || categoryIdStr.trim().isEmpty() || stockStr.trim().isEmpty() || author.trim().isEmpty() || publisher.trim().isEmpty()) {
      request.getSession().setAttribute("error", "Semua field harus diisi.");
      response.sendRedirect(request.getContextPath() + "/book/create");
      return;
    }

    try {
      int categoryId = Integer.parseInt(categoryIdStr);
      int stock = Integer.parseInt(stockStr);
      BookController bookController = new BookController();
      String errorMessage = bookController.insertBook(title, categoryId, stock, author, publisher);
      if (errorMessage == null) {
        request.getSession().setAttribute("successMessage", "Buku berhasil ditambahkan.");
        response.sendRedirect(request.getContextPath() + "/book");
      } else {
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect(request.getContextPath() + "/book/create");
      }
    } catch (Exception e) {
      request.getSession().setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
      response.sendRedirect(request.getContextPath() + "/book/create");
    }
  }
}
