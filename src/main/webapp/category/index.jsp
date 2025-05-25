<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Kategori");

  CategoryController categoryController = (CategoryController) session.getAttribute("categoryController");
  if (categoryController == null) {
    categoryController = new CategoryController();
    session.setAttribute("categoryController", categoryController);
  }

  java.util.List<Category> categories = categoryController.getCategoriesFromDatabase();
  User user = (User) session.getAttribute("user");
  boolean isMember = user != null && "member".equals(user.getRole());
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
            <h1 class="h3 text-gray-800 mb-0">Daftar Kategori</h1>
            <% if (!isMember) { %>
              <a href="<%= request.getContextPath() %>/category/create" class="btn btn-primary">
                <i class="fas fa-plus mr-1"></i> Tambah Kategori
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
                      <th scope="col">Nama Kategori</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% for (Category category : categories) { %>
                      <tr<% if (!isMember) { %> style="cursor:pointer" onclick="window.location='<%= request.getContextPath() %>/category/edit/<%= category.getId() %>'"<% } %>>
                        <td><%= category.getId() %></td>
                        <td><%= category.getName() %></td>
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