package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.FineController;
import com.tugas.perpus.controller.TransactionController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "FinePayServlet", urlPatterns = {"/fines/pay/*"})
public class FinePayServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // e.g. /5
        int fineId = -1;
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                fineId = Integer.parseInt(pathInfo.substring(1));
            } catch (NumberFormatException e) {
                fineId = -1;
            }
        }
        if (fineId <= 0) {
            request.getSession().setAttribute("errorMessage", "ID denda tidak valid.");
            response.sendRedirect(request.getContextPath() + "/fines");
            return;
        }
        FineController fineController = new FineController();
        String err = fineController.payFine(fineId);
        if (err == null) {
            request.getSession().setAttribute("successMessage", "Denda berhasil dibayar dan peminjaman selesai.");
        } else {
            request.getSession().setAttribute("errorMessage", err);
        }
        response.sendRedirect(request.getContextPath() + "/fines");
    }
}
