package com.tugas.perpus.servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.tugas.perpus.controller.BookController;
import com.tugas.perpus.controller.MemberController;
import com.tugas.perpus.controller.TransactionController;
import com.tugas.perpus.model.Book;
import com.tugas.perpus.model.Member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TransactionCreateServlet", urlPatterns = {"/transaction/create"})
public class TransactionCreateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        MemberController memberController = new MemberController();
        BookController bookController = new BookController();
        // Ambil hanya member yang tidak punya transaksi aktif
        List<Member> eligibleMembers = memberController.getEligibleMembersForBorrow();
        // Ambil hanya buku yang stoknya > 0
        List<Book> availableBooks = bookController.getAvailableBooks();
        request.setAttribute("members", eligibleMembers);
        request.setAttribute("books", availableBooks);
        request.getRequestDispatcher("/transaction/create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberIdStr = request.getParameter("member_id");
        String bookIdStr = request.getParameter("book_id");
        if (memberIdStr == null || bookIdStr == null || memberIdStr.trim().isEmpty() || bookIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Semua field harus diisi.");
            doGet(request, response);
            return;
        }
        try {
            int memberId = Integer.parseInt(memberIdStr);
            int bookId = Integer.parseInt(bookIdStr);
            MemberController memberController = new MemberController();
            BookController bookController = new BookController();
            TransactionController transactionController = new TransactionController();
            // Cek eligibility member dengan membandingkan ke daftar eligibleMembers
            List<Member> eligibleMembers = memberController.getEligibleMembersForBorrow();
            boolean isEligible = eligibleMembers.stream().anyMatch(m -> m.getId() == memberId);
            if (!isEligible) {
                request.setAttribute("error", "Member masih memiliki transaksi aktif.");
                doGet(request, response);
                return;
            }
            // Cek stok buku
            Book book = bookController.getBookById(bookId);
            if (book == null || book.getStock() <= 0) {
                request.setAttribute("error", "Stok buku tidak mencukupi.");
                doGet(request, response);
                return;
            }
            // Tanggal pinjam = hari ini, jatuh tempo = hari ini + 7 hari
            Date now = new Date();
            Date due = new Date(now.getTime() + 7L*24*60*60*1000);
            java.sql.Date borrowSqlDate = new java.sql.Date(now.getTime());
            java.sql.Date dueSqlDate = new java.sql.Date(due.getTime());
            // Insert transaksi
            String errorMsg = transactionController.insertTransaction(memberId, bookId, borrowSqlDate, dueSqlDate, null);
            if (errorMsg == null) {
                // Update stok buku
                bookController.decrementBookStock(bookId);
                request.getSession().setAttribute("successMessage", "Transaksi berhasil dibuat.");
                response.sendRedirect(request.getContextPath() + "/transaction");
            } else {
                request.setAttribute("error", errorMsg);
                doGet(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Terjadi kesalahan: " + e.getMessage());
            doGet(request, response);
        }
    }
}
