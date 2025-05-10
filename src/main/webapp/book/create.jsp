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
            <div style="margin: 40px">
              <h1 class="h3 mb-2 text-gray-800">Tambahkan Buku</h1>

              <div
                class="form-box"
                style="
                  width: 100%;
                  height: 100vh;
                  background-color: #ffffff;
                  border-radius: 10px;
                  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
                  padding: 30px;
                  box-sizing: border-box;
                  margin-top: 20px;
                "
              >
                <form action="/buku/tambah" method="POST">
                  <!-- Judul -->
                  <div style="margin-bottom: 20px">
                    <label
                      for="judul"
                      style="
                        display: block;
                        font-weight: bold;
                        margin-bottom: 8px;
                      "
                    >
                      Judul Buku:
                    </label>
                    <input
                      type="text"
                      id="judul"
                      name="judul"
                      required
                      style="
                        padding: 10px;
                        width: 100%;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                      "
                    />
                  </div>

                  <!-- Kategori -->
                  <div style="margin-bottom: 20px">
                    <label
                      for="kategori"
                      style="
                        display: block;
                        font-weight: bold;
                        margin-bottom: 8px;
                      "
                    >
                      Kategori:
                    </label>
                    <input
                      type="text"
                      id="kategori"
                      name="kategori"
                      required
                      style="
                        padding: 10px;
                        width: 100%;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                      "
                    />
                  </div>

                  <!-- Stok -->
                  <div style="margin-bottom: 20px">
                    <label
                      for="stok"
                      style="
                        display: block;
                        font-weight: bold;
                        margin-bottom: 8px;
                      "
                    >
                      Stok:
                    </label>
                    <input
                      type="number"
                      id="stok"
                      name="stok"
                      required
                      min="0"
                      style="
                        padding: 10px;
                        width: 100%;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                      "
                    />
                  </div>

                  <!-- Penulis -->
                  <div style="margin-bottom: 20px">
                    <label
                      for="penulis"
                      style="
                        display: block;
                        font-weight: bold;
                        margin-bottom: 8px;
                      "
                    >
                      Penulis:
                    </label>
                    <input
                      type="text"
                      id="penulis"
                      name="penulis"
                      required
                      style="
                        padding: 10px;
                        width: 100%;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                      "
                    />
                  </div>

                  <!-- Penerbit -->
                  <div style="margin-bottom: 20px">
                    <label
                      for="penerbit"
                      style="
                        display: block;
                        font-weight: bold;
                        margin-bottom: 8px;
                      "
                    >
                      Penerbit:
                    </label>
                    <input
                      type="text"
                      id="penerbit"
                      name="penerbit"
                      required
                      style="
                        padding: 10px;
                        width: 100%;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                      "
                    />
                  </div>

                  <!-- Submit -->
                  <div style="text-align: right">
                    <button
                      type="submit"
                      style="
                        padding: 10px 20px;
                        background-color: #4caf50;
                        color: white;
                        border: none;
                        border-radius: 4px;
                      "
                    >
                      Submit
                    </button>
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
    <script src="<%= request.getContextPath() %>/_themes/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="<%= request.getContextPath() %>/_themes/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script>
      $(document).ready(function () {
        $("#dataTable").DataTable();
      });
    </script>
  </body>
</html>
