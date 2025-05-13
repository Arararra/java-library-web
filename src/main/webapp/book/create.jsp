<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.tugas.perpus.controller.CategoryController" %> <%@ page
import="com.tugas.perpus.model.Category" %> <% request.setAttribute("title",
"Create-Book"); %>

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
            <div class="my-4">
              <h1 class="h3 mb-4 text-gray-800">Tambahkan Buku</h1>

              <div class="card shadow mb-4">
                <div class="card-body">
                  <form action="/buku/tambah" method="POST">
                    <!-- Judul -->
                    <div class="form-group">
                      <label for="judul" class="font-weight-bold"
                        >Judul Buku</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="judul"
                        name="judul"
                        required
                        placeholder="Masukkan judul buku"
                      />
                    </div>

                    <!-- Kategori -->
                    <div class="form-group">
                      <label for="kategori" class="font-weight-bold"
                        >Kategori</label
                      >
                      <input
                        type="text"
                        class="form-control"
                        id="kategori"
                        name="kategori"
                        required
                        placeholder="Masukkan kategori buku"
                      />
                    </div>

                    <!-- Stok -->
                    <div class="form-group">
                      <label for="stok" class="font-weight-bold">Stok</label>
                      <input
                        type="number"
                        class="form-control"
                        id="stok"
                        name="stok"
                        required
                        min="0"
                        placeholder="Masukkan jumlah stok"
                      />
                    </div>

                    <!-- Penulis & Penerbit berdampingan -->
                    <div class="form-row">
                      <div class="form-group col-md-6">
                        <label for="penulis" class="font-weight-bold"
                          >Penulis</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="penulis"
                          name="penulis"
                          required
                          placeholder="Masukkan nama penulis"
                        />
                      </div>

                      <div class="form-group col-md-6">
                        <label for="penerbit" class="font-weight-bold"
                          >Penerbit</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="penerbit"
                          name="penerbit"
                          required
                          placeholder="Masukkan nama penerbit"
                        />
                      </div>
                    </div>

                    <!-- Submit -->
                    <div class="text-right">
                      <button type="submit" class="btn btn-success px-4">
                        Submit
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
