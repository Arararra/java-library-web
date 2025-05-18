package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.MemberController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MemberDeleteServlet", urlPatterns = {"/member/delete/*"})
public class MemberDeleteServlet extends HttpServlet {
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idParam = request.getPathInfo();
    if (idParam != null && idParam.startsWith("/")) {
      idParam = idParam.substring(1);
    }
    try {
      int id = Integer.parseInt(idParam);
      MemberController memberController = new MemberController();
      String errorMessage = memberController.deleteMember(id);
      if (errorMessage != null) {
        request.getSession().setAttribute("error", errorMessage);
      } else {
        request.getSession().setAttribute("successMessage", "Member berhasil dihapus");
      }
      response.sendRedirect(request.getContextPath() + "/member");
    } catch (NumberFormatException e) {
      response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid member ID");
    }
  }
}
