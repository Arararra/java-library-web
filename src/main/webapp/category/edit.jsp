<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.tugas.perpus.controller.CategoryController" %> <%@ page
import="com.tugas.perpus.model.Category" %> <% request.setAttribute("title",
"Edit-Category"); %>

<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/_layouts/head.jsp" />
    <link
      href="<%= request.getContextPath() %>/_themes/vendor/datatables/dataTables.bootstrap4.min.css"
      rel="stylesheet"
    />
  </head>
  <body id="page-top">
    <div id="wrapper">
      <jsp:include page="/_components/sidebar.jsp" />

      <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
          <jsp:include page="/_components/navbar.jsp" />

          <div class="container-fluid">
            <div class="my-5">
              <h1 class="h3 mb-4 text-gray-800">Edit Kategori</h1>

              <div class="card shadow mb-4">
                <div class="card-body">
                  <form action="/kategori/edit" method="POST">
                    <div class="form-group">
                      <label for="namaKategori" class="font-weight-bold"
                        >Nama Kategori</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="namaKategori"
                        name="namaKategori"
                        required
                        placeholder="Masukkan nama kategori"
                        value="${kategori.namaKategori}"
                        <!--
                        Opsional
                        jika
                        pakai
                        JSTL
                        atau
                        EL
                        --
                      />
                    </div>

                    <div class="text-right">
                      <button type="submit" class="btn btn-success px-4">
                        Edit
                      </button>
                    </div>
                  </form>
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
      $(document).ready(function () {
        $("#dataTable").DataTable();
      });
    </script>
  </body>
</html>
