<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ page import="com.tugas.perpus.model.Category" %> 
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Tambah Buku");
  java.util.List<Category> categories = (java.util.List<Category>) request.getAttribute("categories");
  String error = (String) request.getAttribute("error");

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
                <a href="<%= request.getContextPath() %>/book" class="btn btn-link p-0 mr-2" title="Kembali">
                  <i class="fas fa-arrow-left fa-lg"></i>
                </a>
                <h1 class="h3 text-gray-800 mb-0">Tambahkan Buku</h1>
              </div>
            </div>

            <% if (error != null) { %>
              <div class="alert alert-danger"><%= error %></div>
            <% } %>
            
            <div class="card shadow mb-4">
              <div class="card-body">
                <form action="<%= request.getContextPath() %>/book/create" method="POST">
                  <div class="form-group">
                    <label for="judul" class="font-weight-bold">Judul Buku</label>
                    <input type="text" class="form-control" id="judul" name="title" required placeholder="Masukkan judul buku" />
                  </div>
                  <div class="form-group">
                    <label for="kategori" class="font-weight-bold">Kategori</label>
                    <select class="form-control" id="kategori" name="category_id" required>
                      <option value="">Pilih kategori</option>
                      <% if (categories != null) for (Category cat : categories) { %>
                        <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                      <% } %>
                    </select>
                  </div>

                  <div class="form-group">
                    <label for="stok" class="font-weight-bold">Stok</label>
                    <input type="number" class="form-control" id="stok" name="stock" required min="0" placeholder="Masukkan jumlah stok" />
                  </div>
                  
                  <div class="form-row">
                    <div class="form-group col-md-6">
                      <label for="penulis" class="font-weight-bold">Penulis</label>
                      <input type="text" class="form-control" id="penulis" name="writer" required placeholder="Masukkan nama penulis" />
                    </div>
                    <div class="form-group col-md-6">
                      <label for="penerbit" class="font-weight-bold">Penerbit</label>
                      <input type="text" class="form-control" id="penerbit" name="publisher" required placeholder="Masukkan nama penerbit" />
                    </div>
                  </div>
                  
                  <div class="text-right">
                    <button type="submit" class="btn btn-primary">Submit</button>
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
  </body>
</html>
