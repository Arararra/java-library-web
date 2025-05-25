<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.model.Fine" %>
<%@ page import="com.tugas.perpus.model.Transaction" %>
<%@ page import="com.tugas.perpus.controller.FineController" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Denda");
  FineController fineController = (FineController) session.getAttribute("fineController");
  if (fineController == null) {
    fineController = new FineController();
    session.setAttribute("fineController", fineController);
  }
  User user = (User) session.getAttribute("user");
  boolean isMember = user != null && "member".equals(user.getRole());
  List<Fine> fines = fineController.getFinesFromDatabase(user);
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
            <h1 class="h3 mb-2 text-gray-800 mb-0">Daftar Denda</h1>
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
                      <th>ID</th>
                      <th>ID Peminjaman</th>
                      <th>Total Denda</th>
                      <th>Status</th>
                      <% if (!isMember) { %>
                      <th>Aksi</th>
                      <% } %>
                    </tr>
                  </thead>
                  <tbody>
                    <% for (Fine fine : fines) { %>
                      <tr>
                        <td><%= fine.getId() %></td>
                        <td><%= fine.getTransaction().getId() %></td>
                        <td>Rp <%= fine.getTotalDenda() %></td>
                        <td><%= fine.getStatus() == 1 ? "Selesai" : "Belum Selesai" %></td>
                        <% if (!isMember) { %>
                        <td>
                          <% if (fine.getStatus() == 0) { %>
                            <form method="post" action="<%= request.getContextPath() %>/fines/pay/<%= fine.getId() %>" style="display:inline;" onsubmit="return confirm('Yakin ingin membayar denda ini?');">
                              <button type="submit" class="btn btn-success btn-sm">Bayar</button>
                            </form>
                          <% } else { %>
                            <span class="text-success">Lunas</span>
                          <% } %>
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
