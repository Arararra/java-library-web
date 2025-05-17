<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="com.tugas.perpus.controller.MemberController" %> <%@ page
import="com.tugas.perpus.model.Member" %> <% request.setAttribute("title",
"Member"); MemberController memberController = (MemberController)
session.getAttribute("memberController"); if (memberController == null) {
memberController = new MemberController(); session.setAttribute("memberController",
memberController); } java.util.List<Member>
  members = memberController.getMembersFromDatabase(); %>

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
              <h1 class="h3 mb-2 text-gray-800">Daftar Member</h1>

              <div class="card shadow mb-4">
                <div class="card-body">
                  <div class="table-responsive">
                    <table
                      class="table table-bordered table-striped"
                      id="dataTable"
                      width="100%"
                      cellspacing="0"
                    >
                      <thead>
                        <tr>
                          <th scope="col">ID</th>
                          <th scope="col">Nama</th>
                          <th scope="col">Email</th>
                          <th scope="col">Nomor Telepon</th>
                          <th scope="col">Alamat</th>
                          <th scope="col">Role</th>
                        </tr>
                      </thead>
                      <tbody>
                        <% for (Member member : members) { %>
                        <tr>
                          <td><%= member.getId() %></td>
                          <td><%= member.getName() %></td>
                          <td><%= member.getEmail() %></td>
                          <td><%= member.getPhone() %></td>
                          <td><%= member.getAddres() %></td>
                          <td><%= member.getRole() %></td>
                        </tr>
                        <% } %>
                      </tbody>
                    </table>
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
  </html></Book
>
