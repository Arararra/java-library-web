<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>
<%@ page import="com.tugas.perpus.model.User" %>

<%
  request.setAttribute("title", "Edit Kategori");
  Category category = (Category) request.getAttribute("category");
  
  User user = (User) session.getAttribute("user");
  if (user != null && "member".equals(user.getRole())) {
    response.sendRedirect(request.getContextPath());
    return;
  }
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
                <a href="<%= request.getContextPath() %>/category" class="btn btn-link p-0 mr-2" title="Kembali">
                  <i class="fas fa-arrow-left fa-lg"></i>
                </a>
                <h1 class="h3 text-gray-800 mb-0">Edit Kategori</h1>
              </div>
              <form method="POST" action="<%= request.getContextPath() %>/category/delete/<%= category.getId() %>" onsubmit="return confirm('Apakah Anda yakin ingin menghapus kategori ini?');">
                <button type="submit" class="btn btn-danger">
                  <i class="fas fa-trash-alt mr-1"></i> Hapus
                </button>
              </form>
            </div>

            <% if (request.getSession().getAttribute("error") != null) { %>
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getSession().getAttribute("error") %>
                <button type="button" class="btn btn-danger btn-sm" data-bs-dismiss="alert" aria-label="Close">x</button>
              </div>
              <% request.getSession().removeAttribute("error"); %>
            <% } %>

            <div class="card shadow mb-4">
              <div class="card-body justify-content-end">
                <form method="POST" action="<%= request.getContextPath() %>/category/edit/<%= category.getId() %>" class="d-flex flex-column align-items-end">
                  <div class="form-group w-100">
                    <label for="name" class="font-weight-bold">Nama</label>
                    <input type="text" class="form-control" id="name" placeholder="Masukkan Nama" name="name" value="<%= category.getName() %>" required />
                  </div>
                  <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
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
    <script>
      document.addEventListener('DOMContentLoaded', function () {
        var closeButtons = document.querySelectorAll('.alert button[data-bs-dismiss="alert"]');
        closeButtons.forEach(function (button) {
          button.addEventListener('click', function () {
            var alert = button.closest('.alert');
            if (alert) {
              alert.remove();
            }
          });
        });
      });
    </script>
  </body>
</html>
