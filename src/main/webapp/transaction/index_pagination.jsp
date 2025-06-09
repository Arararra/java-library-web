<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.model.Transaction" %>
<%@ page import="java.util.List" %>
<%
  List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
  Integer pageObj = (Integer) request.getAttribute("page");
  int pageNum = pageObj != null ? pageObj : 1;
  Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
  int totalPagesNum = totalPagesObj != null ? totalPagesObj : 1;
  Boolean isMemberObj = (Boolean) request.getAttribute("isMember");
  boolean isMember = isMemberObj != null ? isMemberObj : false;
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
            <h1 class="h3 mb-2 text-gray-800 mb-0">Daftar Peminjaman (Pagination)</h1>
            <% if (!isMember) { %>
              <a href="<%= request.getContextPath() %>/transaction/create" class="btn btn-primary">
                <i class="fas fa-plus mr-1"></i> Tambah Peminjaman
              </a>
            <% } %>
          </div>
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
                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center">
                    <% int startPage = Math.max(1, pageNum - 2);
                       int endPage = Math.min(totalPagesNum, startPage + 4);
                       if (endPage - startPage < 4) {
                         startPage = Math.max(1, endPage - 4);
                       }
                    %>
                    <li class="page-item <%= (pageNum == 1) ? "disabled" : "" %>">
                      <a class="page-link" href="?page=<%= (pageNum > 1) ? (pageNum - 1) : 1 %>">Prev</a>
                    </li>
                    <% for (int i = startPage; i <= endPage; i++) { %>
                      <li class="page-item <%= (i == pageNum) ? "disabled" : "" %>">
                        <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                      </li>
                    <% } %>
                    <li class="page-item <%= (pageNum == totalPagesNum || totalPagesNum == 0) ? "disabled" : "" %>">
                      <a class="page-link" href="?page=<%= (pageNum < totalPagesNum) ? (pageNum + 1) : totalPagesNum %>">Next</a>
                    </li>
                  </ul>
                </nav>
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
      $('#dataTable').DataTable({
        "paging": false
      });
    });
  </script>
</body>
</html>
