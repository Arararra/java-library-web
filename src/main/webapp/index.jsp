<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.MemberController" %>
<%@ page import="com.tugas.perpus.controller.TransactionController" %>
<%@ page import="com.tugas.perpus.controller.FineController" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Dashboard");

  // Ambil user dari session
  User user = (User) session.getAttribute("user");
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
          <div class="d-sm-flex align-items-center justify-content-between mb-4">
            <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
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