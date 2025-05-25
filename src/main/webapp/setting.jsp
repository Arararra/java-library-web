<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("title", "Reset Password");
  String successMessage = (String) request.getAttribute("successMessage");
  String errorMessage = (String) request.getAttribute("errorMessage");
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
            <h1 class="h3 mb-2 text-gray-800 mb-0">Reset Password</h1>
          </div>

          <% if (errorMessage != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <%= errorMessage %>
            </div>
          <% } %>

          <% if (successMessage != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <%= successMessage %>
            </div>
          <% } %>

          <div class="card shadow mb-4">
            <div class="card-body">
              <form action="<%= request.getContextPath() %>/password-reset" method="post">
                <div class="form-group">
                  <label for="oldPassword">Password Lama</label>
                  <input type="password" class="form-control" id="oldPassword" name="oldPassword" required />
                </div>

                <div class="form-group">
                  <label for="newPassword">Password Baru</label>
                  <input type="password" class="form-control" id="newPassword" name="newPassword" required />
                </div>

                <button type="submit" class="btn btn-primary">Ganti Password</button>
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
