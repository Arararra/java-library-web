<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.MemberController" %>
<%@ page import="com.tugas.perpus.model.Member" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Tambah Member");
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
              <a href="<%= request.getContextPath() %>/member" class="btn btn-link p-0 mr-2" title="Kembali">
                <i class="fas fa-arrow-left fa-lg"></i>
              </a>
              <h1 class="h3 text-gray-800 mb-0">Tambahkan Member</h1>
            </div>
          </div>

          <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
          <% } %>

          <div class="card shadow mb-4">
            <div class="card-body">
              <form action="<%= request.getContextPath() %>/member/create" method="POST">
                <div class="form-group">
                  <label for="nama" class="font-weight-bold">Nama</label>
                  <input type="text" class="form-control" id="nama" name="nama" required placeholder="Masukkan nama member" />
                </div>

                <div class="form-group">
                  <label for="email" class="font-weight-bold">Email</label>
                  <input type="email" class="form-control" id="email" name="email" required placeholder="Masukkan email member" />
                </div>
                
                <div class="form-row">
                  <div class="form-group col-md-6">
                    <label for="telepon" class="font-weight-bold">No Telepon</label>
                    <input type="text" class="form-control" id="telepon" name="telepon" required placeholder="Masukkan no telepon" />
                  </div>

                  <div class="form-group col-md-6">
                    <label for="role" class="font-weight-bold">Role</label>
                    <select class="form-control" id="role" name="role" required>
                      <option value="">Pilih role</option>
                      <option value="member">Member</option>
                      <option value="admin">Admin</option>
                    </select>
                  </div>
                </div>
                
                <div class="form-group">
                  <label for="alamat" class="font-weight-bold">Alamat</label>
                  <textarea class="form-control" id="alamat" name="alamat" rows="2" required placeholder="Masukkan alamat member"></textarea>
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
