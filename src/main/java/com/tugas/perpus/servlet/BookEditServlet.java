package com.tugas.perpus.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tugas.perpus.model.Book;
import com.tugas.perpus.model.Category;
import com.tugas.perpus.controller.BookController;
import com.tugas.perpus.controller.CategoryController;

@WebServlet(name = "BookEditServlet", urlPatterns = {"/book/edit/*"})
public class BookEditServlet extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }

    try {
      int id = Integer.parseInt(idParam);
      BookController bookController = new BookController();
      Book book = bookController.getBookById(id);
      CategoryController categoryController = new CategoryController();
      List<Category> categories = categoryController.getCategoriesFromDatabase();

      if (book == null) {
        request.getSession().setAttribute("errorMessage", "Buku dengan ID " + id + " tidak ditemukan");
        response.sendRedirect(request.getContextPath() + "/book");
        return;
      }

      request.setAttribute("book", book);
      request.setAttribute("categories", categories);
      request.getRequestDispatcher("/book/edit.jsp").forward(request, response);
    } catch (NumberFormatException | NullPointerException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID");
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
      String title = request.getParameter("title");
      int categoryId = Integer.parseInt(request.getParameter("category_id"));
      int stock = Integer.parseInt(request.getParameter("stock"));
      String author = request.getParameter("writer");
      String publisher = request.getParameter("publisher");
      BookController bookController = new BookController();
      String errorMessage = bookController.updateBook(id, title, categoryId, stock, author, publisher);
      
      if (errorMessage != null) {
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect(request.getContextPath() + "/book/edit/" + id);
      } else {
        request.getSession().setAttribute("successMessage", "Buku berhasil diperbarui");
        response.sendRedirect(request.getContextPath() + "/book");
      }
      
    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID");
    }
  }
}
