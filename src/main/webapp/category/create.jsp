<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>

<%
  request.setAttribute("title", "Buat Kategori");
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
            <h1 class="h3 mb-2 text-gray-800">Buat Kategori</h1>

            <% if (request.getSession().getAttribute("error") != null) { %>
              <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getSession().getAttribute("error") %>
                <button type="button" class="btn btn-danger btn-sm" data-bs-dismiss="alert" aria-label="Close">x</button>
              </div>
              <% request.getSession().removeAttribute("error"); %>
            <% } %>

            <div class="card shadow mb-4">
              <div class="card-body justify-content-end">
                <form method="POST" action="<%= request.getContextPath() %>/category/create" class="d-flex flex-column align-items-end">
                  <div class="form-group w-100">
                    <label for="name" class="font-weight-bold">Nama</label>
                    <input type="text" class="form-control" id="name" placeholder="Masukkan Nama" name="name" required />
                  </div>
                  <button type="submit" class="btn btn-primary">Submit</button>
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
