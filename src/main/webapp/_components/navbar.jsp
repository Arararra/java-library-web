<%@ page import="com.tugas.perpus.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User user = (User) session.getAttribute("user");
%>

<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
  <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
    <i class="fa fa-bars"></i>
  </button>

  <ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown no-arrow">
      <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="mr-2 d-none d-lg-inline text-gray-600 small">
          <%= user.getName() %>
        </span>
        <img class="img-profile rounded-circle" src="<%= request.getContextPath() %>/_themes/img/undraw_profile.svg">
      </a>

      <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
        <a class="dropdown-item" href="<%= request.getContextPath() %>/password-reset">
          <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
          Reset Password
        </a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="<%= request.getContextPath() %>/logout">
          <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
          Logout
        </a>
      </div>
    </li>
  </ul>
</nav>