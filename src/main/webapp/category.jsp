<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>

<%
  request.setAttribute("title", "Ini Index");

  CategoryController categoryController = (CategoryController) session.getAttribute("categoryController");
  if (categoryController == null) {
    categoryController = new CategoryController();
    session.setAttribute("categoryController", categoryController);
  }

  java.util.List<Category> categories = categoryController.getCategoriesFromDatabase();
%>

<!DOCTYPE html>
<html>
<head>
  <jsp:include page="_layouts/head.jsp" />
</head>
<body>
  <jsp:include page="_components/navbar.jsp" />

  <main class="container mt-4">
    <h1>Daftar Kategori</h1>
    <table class="table table-striped">
      <thead class="thead-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Nama Kategori</th>
        </tr>
      </thead>
      <tbody>
        <% for (Category category : categories) { %>
          <tr>
            <td><%= category.getId() %></td>
            <td><%= category.getName() %></td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </main>

  <jsp:include page="_components/footer.jsp" />

  <jsp:include page="_layouts/script.jsp" />
</body>
</html>