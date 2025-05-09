<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.BookController" %>
<%@ page import="com.tugas.perpus.model.Book" %>

<%
  request.setAttribute("title", "Book");

  BookController bookController = (BookController) session.getAttribute("bookController");
  if (bookController == null) {
    bookController = new BookController();
    session.setAttribute("bookController", bookController);
  }

  java.util.List<Book> books = bookController.getBooksFromDatabase();
%>

<!DOCTYPE html>
<html>
<head>
  <jsp:include page="/_layouts/head.jsp" />
  <link href="<%= request.getContextPath() %>/_themes/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
</head>
<body id="page-top">
  <div id="wrapper">
    <jsp:include page="/_components/sidebar.jsp" />

    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">
        <jsp:include page="/_components/navbar.jsp" />

        <div class="container-fluid">
          <h1 class="h3 mb-2 text-gray-800">Daftar Buku</h1>

          <div class="card shadow mb-4">
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered table-striped" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th scope="col">ID</th>
                      <th scope="col">Judul</th>
                      <th scope="col">Kategori</th>
                      <th scope="col">Stok</th>
                      <th scope="col">Penulis</th>
                      <th scope="col">Penerbit</th>
                    </tr>
                  </thead>
                  <tbody>
                    <% for (Book book : books) { %>
                      <tr>
                        <td><%= book.getId() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getCategory().getName() %></td>
                        <td><%= book.getStock() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getPublisher() %></td>
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
    $(document).ready(function() {
      $('#dataTable').DataTable();
    });
  </script>
</body>
</html>