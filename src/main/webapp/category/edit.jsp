<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>

<%
  request.setAttribute("title", "Edit Kategori");
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
            <h1 class="h3 mb-2 text-gray-800">Edit Kategori</h1>

            <div class="card shadow mb-4">
              <div class="card-body justify-content-end">
                <form method="POST" action="/category/controller/create" class="d-flex flex-column align-items-end">
                  <div class="form-group w-100">
                    <label for="name" class="font-weight-bold">Nama</label>
                    <input type="text" class="form-control" id="name" placeholder="Masukkan Nama" name="name" value="Teknologi" required />
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
  </body>
</html>
