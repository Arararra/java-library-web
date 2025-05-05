<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%@ page import="com.tugas.perpus.model.Category" %>
<%
  // Inisialisasi controller
  CategoryController categoryController = (CategoryController) session.getAttribute("categoryController");
  if (categoryController == null) {
    categoryController = new CategoryController();
    session.setAttribute("categoryController", categoryController);
  }

  // Ambil daftar kategori dari database
  java.util.List<Category> categories = categoryController.getCategoriesFromDatabase();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Perpustakaan</title>
</head>
<body>
  <h1>Daftar Kategori</h1>
  <table border="1">
    <thead>
      <tr>
        <th>ID</th>
        <th>Nama Kategori</th>
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
</body>
</html>