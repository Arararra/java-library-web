<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tugas.perpus.controller.MemberController" %>
<%@ page import="com.tugas.perpus.controller.TransactionController" %>
<%@ page import="com.tugas.perpus.controller.FineController" %>
<%@ page import="com.tugas.perpus.model.User" %>
<%
  request.setAttribute("title", "Dashboard");

  // Ambil user dari session
  User user = (User) session.getAttribute("user");
  
  // Total Member
  MemberController memberController = (MemberController) session.getAttribute("memberController");
  if (memberController == null) {
    memberController = new MemberController();
    session.setAttribute("memberController", memberController);
  }
  int totalMember = memberController.getMembersFromDatabase().size();

  // Total Transaksi
  TransactionController transactionController = (TransactionController) session.getAttribute("transactionController");
  if (transactionController == null) {
    transactionController = new TransactionController();
    session.setAttribute("transactionController", transactionController);
  }
  int totalTransaksi = transactionController.getTransactionsFromDatabase(null).size();
  
  // Total Denda
  FineController fineController = (FineController) session.getAttribute("fineController");
  if (fineController == null) {
    fineController = new FineController();
    session.setAttribute("fineController", fineController);
  }
  int totalDenda = fineController.getFinesFromDatabase(null).size();
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

          <div class="row justify-content-between">
            <div class="col-md-4 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Member</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalMember %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-md-4 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Transaksi</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalTransaksi %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-exchange-alt fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="col-md-4 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Denda</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalDenda %></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-money-bill-wave fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-8">
              <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Chart Peminjaman</h6>
                </div>
                <div class="card-body">
                  <div class="chart-area">
                    <jsp:include page="/_components/transaction_chart.jsp" />
                  </div>
                </div>
              </div>
            </div>
            
            <div class="col-lg-4">
              <div class="card shadow mb-4">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Chart Denda</h6>
                </div>
                <div class="card-body">
                  <div class="chart-area">
                    <jsp:include page="/_components/fines_chart.jsp" />
                  </div>
                </div>
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
</body>
</html>