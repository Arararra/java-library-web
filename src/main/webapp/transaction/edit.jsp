<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.model.Transaction" %>
<%@ page import="com.tugas.perpus.model.Book" %>
<%@ page import="com.tugas.perpus.model.Member" %>
<%
  request.setAttribute("title", "Edit Transaksi");
  Transaction transaction = (Transaction) request.getAttribute("transaction");
  java.util.List<Book> books = (java.util.List<Book>) request.getAttribute("books");
  java.util.List<Member> members = (java.util.List<Member>) request.getAttribute("members");
  String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/_layouts/head.jsp" />
  </head>
  <body id="page-top">
    <div id="wrapper">
      <jsp:include page="/_components/sidebar.jsp" />

      <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
          <jsp:include page="/_components/navbar.jsp" />

          <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center mb-4">
              <div class="d-flex align-items-center">
                <a href="<%= request.getContextPath() %>/transaction" class="btn btn-link p-0 mr-2" title="Kembali">
                  <i class="fas fa-arrow-left fa-lg"></i>
                </a>
                <h1 class="h3 text-gray-800 mb-0">Edit Transaksi</h1>
              </div>
              <% if (transaction != null) { %>
              <form method="POST" action="<%= request.getContextPath() %>/transaction/delete/<%= transaction.getId() %>" onsubmit="return confirm('Apakah Anda yakin ingin menghapus transaksi ini?');">
                <button type="submit" class="btn btn-danger">
                  <i class="fas fa-trash-alt mr-1"></i> Hapus
                </button>
              </form>
              <% } %>
            </div>

            <% if (error != null) { %>
              <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <div class="card shadow mb-4">
              <div class="card-body">
                <form action="<%= request.getContextPath() %>/transaction/edit/<%= transaction != null ? transaction.getId() : "" %>" method="POST">
                  <input type="hidden" name="id" value="<%= transaction != null ? transaction.getId() : "" %>" />

                  <div class="form-group">
                    <label for="member" class="font-weight-bold">Member</label>
                    <select class="form-control" id="member" name="member_id" required>
                      <option value="">Pilih member</option>
                      <% if (members != null) for (Member m : members) { %>
                        <option value="<%= m.getId() %>" <%= (transaction != null && transaction.getUser().getId() == m.getId()) ? "selected" : "" %>><%= m.getName() %></option>
                      <% } %>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="book" class="font-weight-bold">Buku</label>
                    <select class="form-control" id="book" name="book_id" required>
                      <option value="">Pilih buku</option>
                      <% if (books != null) for (Book b : books) { %>
                        <option value="<%= b.getId() %>" <%= (transaction != null && transaction.getBook().getId() == b.getId()) ? "selected" : "" %>><%= b.getTitle() %></option>
                      <% } %>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="borrowDate" class="font-weight-bold">Tanggal Pinjam</label>
                    <input type="date" class="form-control" id="borrowDate" name="borrow_date" required readonly value="<%= transaction != null ? transaction.getBorrowDate() : new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" />
                  </div>

                  <div class="form-group">
                    <label for="dueDate" class="font-weight-bold">Jatuh Tempo</label>
                    <input type="date" class="form-control" id="dueDate" name="due_date" required readonly value="<%= transaction != null ? transaction.getDueDate() : new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(System.currentTimeMillis() + 7L*24*60*60*1000)) %>" />
                  </div>

                  <div class="form-group">
                    <label for="returnDate" class="font-weight-bold">Tanggal Kembali</label>
                    <input type="date" class="form-control" id="returnDate" name="return_date" value="<%= transaction != null && transaction.getReturnDate() != null ? transaction.getReturnDate() : "" %>" />
                  </div>

                  <div class="form-group">
                    <label for="status" class="font-weight-bold">Status</label>
                    <select class="form-control" id="status" name="status" required>
                      <option value="0" <%= transaction != null && transaction.getStatus() == 0 ? "selected" : "" %>>Dipinjam</option>
                      <option value="1" <%= transaction != null && transaction.getStatus() == 1 ? "selected" : "" %>>Dikembalikan</option>
                      <option value="2" <%= transaction != null && transaction.getStatus() == 2 ? "selected" : "" %>>Terlambat</option>
                    </select>
                  </div>

                  <div class="text-right">
                    <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <jsp:include page="/_components/footer.jsp" />
      </div>
    </div>

    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>

    <jsp:include page="/_layouts/script.jsp" />
  </body>
</html>
