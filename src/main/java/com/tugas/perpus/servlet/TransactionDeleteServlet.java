package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.TransactionController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TransactionDeleteServlet", urlPatterns = {"/transaction/delete/*"})
public class TransactionDeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil id dari path info
        String pathInfo = request.getPathInfo(); // e.g. /5
        int trxId = -1;
        if (pathInfo != null && pathInfo.length() > 1) {
            try {
                trxId = Integer.parseInt(pathInfo.substring(1));
            } catch (NumberFormatException e) {
                trxId = -1;
            }
        }
        if (trxId <= 0) {
            request.getSession().setAttribute("errorMessage", "ID transaksi tidak valid.");
            response.sendRedirect(request.getContextPath() + "/transaction");
            return;
        }
        TransactionController transactionController = new TransactionController();
        String err = transactionController.deleteTransaction(trxId);
        if (err == null) {
            request.getSession().setAttribute("successMessage", "Transaksi berhasil dihapus.");
        } else {
            request.getSession().setAttribute("errorMessage", err);
        }
        response.sendRedirect(request.getContextPath() + "/transaction");
    }
}
