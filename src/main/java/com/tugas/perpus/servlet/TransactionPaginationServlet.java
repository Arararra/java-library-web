package com.tugas.perpus.servlet;

import com.tugas.perpus.controller.TransactionController;
import com.tugas.perpus.model.Transaction;
import com.tugas.perpus.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/transaction-page")
public class TransactionPaginationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        TransactionController transactionController = (TransactionController) session.getAttribute("transactionController");
        if (transactionController == null) {
            transactionController = new TransactionController();
            session.setAttribute("transactionController", transactionController);
        }

        int page = 1;
        int pageSize = 10;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }
        List<Transaction> transactions = transactionController.getTransactionsByPage(user, page, pageSize);
        int totalTransactions = transactionController.getTotalTransactionCount(user);
        int totalPages = (int) Math.ceil((double) totalTransactions / pageSize);

        request.setAttribute("transactions", transactions);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("isMember", user != null && "member".equals(user.getRole()));

        request.getRequestDispatcher("/transaction/index_pagination.jsp").forward(request, response);
    }
}
