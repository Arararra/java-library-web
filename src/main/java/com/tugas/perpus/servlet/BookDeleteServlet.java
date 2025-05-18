package com.tugas.perpus.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.tugas.perpus.controller.BookController;

@WebServlet(name = "BookDeleteServlet", urlPatterns = {"/book/delete/*"})
public class BookDeleteServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }

    try {
      int id = Integer.parseInt(idParam);
      BookController bookController = new BookController();
      String errorMessage = bookController.deleteBook(id);

      if (errorMessage != null) {
        request.getSession().setAttribute("error", errorMessage);
      } else {
        request.getSession().setAttribute("successMessage", "Buku berhasil dihapus");
      }

      response.sendRedirect(request.getContextPath() + "/book");
    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid book ID");
    }
  }
}
