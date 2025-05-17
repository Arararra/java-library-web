<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.tugas.perpus.controller.MemberController" %> <%@ page
import="com.tugas.perpus.model.Member" %> <% request.setAttribute("title",
"Tambah Member"); %>

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
            <div class="my-4">
              <h1 class="h3 mb-4 text-gray-800">Tambahkan Member</h1>

              <div class="card shadow mb-4">
                <div class="card-body">
                  <form action="/buku/tambah" method="POST">
                    <!-- Nama Member -->
                    <div class="form-group">
                      <label for="judul" class="font-weight-bold">Nama</label>
                      <input
                        type="text"
                        class="form-control"
                        id="judul"
                        name="title"
                        required
                        placeholder="Masukkan judul buku"
                      />
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                      <label for="kategori" class="font-weight-bold"
                        >Email</label
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

                    <!-- Alamat -->
                    <div class="form-group">
                      <label for="stok" class="font-weight-bold">Alamat</label>
                      <input
                        type="number"
                        class="form-control"
                        id="stok"
                        name="stock"
                        required
                        min="0"
                        placeholder="Masukkan jumlah stok"
                      />
                    </div>

                    <!-- No Telepon & Role berdampingan -->
                    <div class="form-row">
                      <div class="form-group col-md-6">
                        <label for="penulis" class="font-weight-bold"
                          >No Telepon</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="penulis"
                          name="writer"
                          required
                          placeholder="Masukkan nama penulis"
                        />
                      </div>

                      <div class="form-group col-md-6">
                        <label for="penerbit" class="font-weight-bold"
                          >Role</label
                        >
                        <input
                          type="text"
                          class="form-control"
                          id="penerbit"
                          name="publisher"
                          required
                          placeholder="Masukkan nama penerbit"
                        />
                      </div>
                    </div>

                    <!-- Submit -->
                    <div class="text-right">
                      <button type="submit" class="btn btn-primary">
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
  </body>
</html>
