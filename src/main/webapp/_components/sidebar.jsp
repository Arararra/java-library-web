<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String currentPath = request.getRequestURI().substring(request.getContextPath().length()); %>
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
  <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
    <div class="sidebar-brand-icon rotate-n-15">
      <i class="fas fa-book"></i>
    </div>
    <div class="sidebar-brand-text mx-3">Sistem Perpustakaan</div>
  </a>

  <hr class="sidebar-divider my-0">

  <li class="nav-item <%= currentPath == null ? "active" : "" %>">
    <a class="nav-link" href="<%= request.getContextPath() %>">
      <i class="fas fa-fw fa-tachometer-alt"></i>
      <span>Dashboard</span>
    </a>
  </li>

  <hr class="sidebar-divider">

  <li class="nav-item">
    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
      aria-expanded="true" aria-controls="collapsePages">
      <i class="fas fa-fw fa-folder"></i>
      <span>Pages</span>
    </a>
    <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
      <div class="bg-white py-2 collapse-inner rounded">
        <h6 class="collapse-header">Login Screens:</h6>
        <a class="collapse-item" href="login.html">Login</a>
        <a class="collapse-item" href="register.html">Register</a>
        <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
        <div class="collapse-divider"></div>
        <h6 class="collapse-header">Other Pages:</h6>
        <a class="collapse-item" href="404.html">404 Page</a>
        <a class="collapse-item" href="blank.html">Blank Page</a>
      </div>
    </div>
  </li>
  <li class="nav-item <%= currentPath.startsWith("/transaction") ? "active" : "" %>">
    <a class="nav-link" href="<%= request.getContextPath() %>/transaction">
      <i class="fas fa-fw fa-boxes"></i>
      <span>Peminjaman</span>
    </a>
  </li>
  <li class="nav-item <%= currentPath.startsWith("/book") ? "active" : "" %>">
    <a class="nav-link" href="<%= request.getContextPath() %>/book">
      <i class="fas fa-fw fa-book"></i>
      <span>Buku</span>
    </a>
  </li>
  <li class="nav-item <%= currentPath.startsWith("/category") ? "active" : "" %>">
    <a class="nav-link" href="<%= request.getContextPath() %>/category">
      <i class="fas fa-fw fa-th-large"></i>
      <span>Kategori</span>
    </a>
  </li>
  <li class="nav-item <%= currentPath.startsWith("/member") ? "active" : "" %>">
    <a class="nav-link" href="<%= request.getContextPath() %>/member">
      <i class="fas fa-fw fa-users"></i>
      <span>Member</span>
    </a>
  </li>

  <hr class="sidebar-divider d-none d-md-block">

  <div class="text-center d-none d-md-inline">
    <button class="rounded-circle border-0" id="sidebarToggle"></button>
  </div>
</ul>