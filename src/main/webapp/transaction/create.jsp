<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.model.Book" %>
<%@ page import="com.tugas.perpus.model.Member" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Tambah Transaksi");
  java.util.List<Book> books = (java.util.List<Book>) request.getAttribute("books");
  java.util.List<Member> members = (java.util.List<Member>) request.getAttribute("members");
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
              <a href="<%= request.getContextPath() %>/transaction" class="btn btn-link p-0 mr-2" title="Kembali">
                <i class="fas fa-arrow-left fa-lg"></i>
              </a>
              <h1 class="h3 text-gray-800 mb-0">Tambahkan Transaksi</h1>
            </div>
          </div>

          <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
          <% } %>

          <div class="card shadow mb-4">
            <div class="card-body">
              <form action="<%= request.getContextPath() %>/transaction/create" method="POST">
                <div class="form-group">
                  <label for="member" class="font-weight-bold">Member</label>
                  <select class="form-control" id="member" name="member_id" required>
                    <option value="">Pilih member</option>
                    <% if (members != null) for (Member m : members) { %>
                      <option value="<%= m.getId() %>"><%= m.getName() %></option>
                    <% } %>
                  </select>
                </div>

                <div class="form-group">
                  <label for="book" class="font-weight-bold">Buku</label>
                  <select class="form-control" id="book" name="book_id" required>
                    <option value="">Pilih buku</option>
                    <% if (books != null) for (Book b : books) { %>
                      <option value="<%= b.getId() %>"><%= b.getTitle() %></option>
                    <% } %>
                  </select>
                </div>

                <div class="form-group">
                  <label for="borrowDate" class="font-weight-bold">Tanggal Pinjam</label>
                  <input type="date" class="form-control" id="borrowDate" name="borrow_date" required readonly value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" />
                </div>

                <div class="form-group">
                  <label for="dueDate" class="font-weight-bold">Jatuh Tempo</label>
                  <input type="date" class="form-control" id="dueDate" name="due_date" required readonly value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(System.currentTimeMillis() + 7L*24*60*60*1000)) %>" />
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
