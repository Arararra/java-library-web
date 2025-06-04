<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.TransactionController" %>
<%@ page import="com.tugas.perpus.model.Transaction" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "peminjaman");

  TransactionController transactionController = (TransactionController) session.getAttribute("transactionController");
  if (transactionController == null) {
    transactionController = new TransactionController();
    session.setAttribute("transactionController", transactionController);
  }
  
  User user = (User) session.getAttribute("user");
  boolean isMember = user != null && "member".equals(user.getRole());
  java.util.List<Transaction> transactions = transactionController.getTransactionsFromDatabase(user);
%>

<!DOCTYPE html>
<html>
<head>
  <jsp:include page="/_layouts/head.jsp" />
  <link href="<%= request.getContextPath() %>/_themes/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
  <div id="wrapper">
    <jsp:include page="/_components/sidebar.jsp" />

    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">
        <jsp:include page="/_components/navbar.jsp" />

        <div class="container-fluid">
          <div class="d-flex justify-content-between align-items-center mb-4">
            <h1 class="h3 mb-2 text-gray-800 mb-0">Daftar Peminjaman</h1>
            <% if (!isMember) { %>
              <a href="<%= request.getContextPath() %>/transaction/create" class="btn btn-primary">
                <i class="fas fa-plus mr-1"></i> Tambah Peminjaman
              </a>
            <% } %>
          </div>

          <% 
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
              session.removeAttribute("successMessage");
          %>
            <div class="alert alert-success alert-dismissible fade show" role="alert" id="success-alert">
              <%= successMessage %>
            </div>
          <% } %>

          <% 
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
              session.removeAttribute("errorMessage"); 
          %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <%= errorMessage %>
            </div>
          <% } %>

          <div class="card shadow mb-4">
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Member</th>
                      <th scope="col">Buku</th>
                      <th scope="col">Tanggal Pinjam</th>
                      <th scope="col">Jatuh Tempo</th>
                      <th scope="col">Tanggal Kembali</th>
                      <th scope="col">Status</th>
                      <% if (!isMember) { %>
                      <th scope="col">Aksi</th>
                      <% } %>
                    </tr>
                  </thead>
                  <tbody>
                    <% for (Transaction trx : transactions) { %>
                      <tr>
                        <td><%= trx.getId() %></td>
                        <td><%= trx.getUser() != null ? trx.getUser().getName() : "-" %></td>
                        <td><%= trx.getBook() != null ? trx.getBook().getTitle() : "-" %></td>
                        <td><%= trx.getBorrowDate() != null ? trx.getBorrowDate() : "-" %></td>
                        <td><%= trx.getDueDate() != null ? trx.getDueDate() : "-" %></td>
                        <td><%= trx.getReturnDate() != null ? trx.getReturnDate() : "-" %></td>
                        <td><%= trx.getStatusDescription() %></td>
                        <% if (!isMember) { %>
                        <td style="min-width:120px;">
                          <form method="post" action="<%= request.getContextPath() %>/transaction/finish/<%= trx.getId() %>" style="display:inline;" onsubmit="return confirm('Yakin ingin menyelesaikan peminjaman ini?');">
                            <button type="submit" class="btn btn-success btn-sm" <%= trx.getReturnDate() != null ? "disabled" : "" %>>Selesaikan</button>
                          </form>
                          <form method="post" action="<%= request.getContextPath() %>/transaction/delete/<%= trx.getId() %>" style="display:inline;" onsubmit="return confirm('Yakin ingin menghapus peminjaman ini?');">
                            <button type="submit" class="btn btn-danger btn-sm">Hapus</button>
                          </form>
                        </td>
                        <% } %>
                      </tr>
                    <% } %>
                  </tbody>
                </table>
              </div>
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
  <script src="<%= request.getContextPath() %>/_themes/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="<%= request.getContextPath() %>/_themes/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script>
    $(document).ready(function() {
      $('#dataTable').DataTable();
    });
  </script>
</body>
</html>
