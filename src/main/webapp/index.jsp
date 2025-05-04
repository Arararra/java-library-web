<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.CategoryController" %>
<%
  // Inisialisasi controller
  CategoryController categoryController = (CategoryController) session.getAttribute("categoryController");
  if (categoryController == null) {
    categoryController = new CategoryController();
    session.setAttribute("categoryController", categoryController);
  }

  // Tangani input dari form
  String newCategory = request.getParameter("categoryName");
  if (newCategory != null) {
    categoryController.addCategory(newCategory);
  }

  // Ambil daftar kategori
  java.util.List<String> categories = categoryController.getCategories();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Perpustakaan</title>
</head>
<body>
  <h1>Daftar Kategori</h1>
  <ul>
    <% for (String category : categories) { %>
      <li><%= category %></li>
    <% } %>
  </ul>

  <h2>Tambah Kategori</h2>
  <form method="post" action="index.jsp">
    <label for="categoryName">Nama Kategori:</label>
    <input type="text" id="categoryName" name="categoryName" required>
    <button type="submit">Tambah</button>
  </form>
</body>
</html>