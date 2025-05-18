<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.MemberController" %>
<%@ page import="com.tugas.perpus.model.Member" %>

<%
  request.setAttribute("title", "Edit Member");
  Member member = (Member) request.getAttribute("member");
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
                <h1 class="h3 text-gray-800 mb-0">Edit Member</h1>
              </div>
              <% if (member != null) { %>
              <form method="POST" action="<%= request.getContextPath() %>/member/delete/<%= member.getId() %>" onsubmit="return confirm('Apakah Anda yakin ingin menghapus member ini?');">
                <button type="submit" class="btn btn-danger">
                  <i class="fas fa-trash-alt mr-1"></i> Hapus
                </button>
              </form>
              <% } %>
            </div>

            <% String error = (String) request.getAttribute("error"); if (error != null) { %>
              <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <div class="card shadow mb-4">
              <div class="card-body">
                <form action="<%= request.getContextPath() %>/member/edit/<%= member != null ? member.getId() : "" %>" method="POST">
                  <input type="hidden" name="id" value="<%= member != null ? member.getId() : "" %>" />

                  <div class="form-group">
                    <label for="nama" class="font-weight-bold">Nama</label>
                    <input type="text" class="form-control" id="nama" name="nama" required placeholder="Masukkan nama member" value="<%= member != null ? member.getName() : "" %>" />
                  </div>

                  <div class="form-group">
                    <label for="email" class="font-weight-bold">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required placeholder="Masukkan email member" value="<%= member != null ? member.getEmail() : "" %>" />
                  </div>

                  <div class="form-group">
                    <label for="alamat" class="font-weight-bold">Alamat</label>
                    <textarea class="form-control" id="alamat" name="alamat" required placeholder="Masukkan alamat member"><%= member != null ? member.getAddress() : "" %></textarea>
                  </div>

                  <div class="form-row">
                    <div class="form-group col-md-6">
                      <label for="telepon" class="font-weight-bold">No Telepon</label>
                      <input type="text" class="form-control" id="telepon" name="telepon" required placeholder="Masukkan no telepon" value="<%= member != null ? member.getPhone() : "" %>" />
                    </div>
                    <div class="form-group col-md-6">
                      <label for="role" class="font-weight-bold">Role</label>
                      <select class="form-control" id="role" name="role" required>
                        <option value="member" <%= member != null && "member".equals(member.getRole()) ? "selected" : "" %>>Member</option>
                        <option value="admin" <%= member != null && "admin".equals(member.getRole()) ? "selected" : "" %>>Admin</option>
                      </select>
                    </div>
                  </div>

                  <div class="text-right">
                    <button type="submit" class="btn btn-primary">Simpan Perubahan</button>
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
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        var closeButtons = document.querySelectorAll('.alert button[data-bs-dismiss="alert"]');
        closeButtons.forEach(function (button) {
          button.addEventListener("click", function () {
            var alert = button.closest(".alert");
            if (alert) {
              alert.remove();
            }
          });
        });
      });
    </script>
  </body>
</html>
