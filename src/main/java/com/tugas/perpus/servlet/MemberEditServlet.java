package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.MemberController;
import com.tugas.perpus.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "MemberEditServlet", urlPatterns = {"/member/edit/*"})
public class MemberEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getPathInfo();
        if (idParam != null && idParam.startsWith("/")) {
            idParam = idParam.substring(1);
        }
        try {
            int id = Integer.parseInt(idParam);
            MemberController memberController = new MemberController();
            Member member = memberController.getMemberById(id);
            if (member == null) {
                request.getSession().setAttribute("errorMessage", "Member dengan ID " + id + " tidak ditemukan");
                response.sendRedirect(request.getContextPath() + "/member");
                return;
            }
            // Ambil error dari session jika ada, lalu pindahkan ke request attribute dan hapus dari session
            String error = (String) request.getSession().getAttribute("error");
            if (error != null) {
                request.setAttribute("error", error);
                request.getSession().removeAttribute("error");
            }
            request.setAttribute("member", member);
            request.getRequestDispatcher("/member/edit.jsp").forward(request, response);
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid member ID");
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
            String nama = request.getParameter("nama");
            String email = request.getParameter("email");
            String alamat = request.getParameter("alamat");
            String telepon = request.getParameter("telepon");
            String role = request.getParameter("role");
            MemberController memberController = new MemberController();
            String errorMessage = memberController.updateMember(id, nama, email, alamat, telepon, role);
            if (errorMessage == null) {
                request.getSession().setAttribute("successMessage", "Member berhasil diupdate.");
                response.sendRedirect(request.getContextPath() + "/member");
            } else {
                request.getSession().setAttribute("error", errorMessage);
                response.sendRedirect(request.getContextPath() + "/member/edit/" + id);
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid member ID");
        }
    }
}
