<%@ page import="com.tugas.perpus.controller.TransactionController" %>
<%@ page import="com.tugas.perpus.model.Transaction" %>
<%@ page import="java.util.List" %>

<%
  TransactionController transactionController = new TransactionController();
  List<Transaction> transactions = transactionController.getTransactionsFromDatabase(null);

  int dipinjam = 0;
  int selesai = 0;
  int terlambat = 0;

  if (transactions != null) {
    for (Transaction trx : transactions) {
      switch (trx.getStatus()) {
        case 0: dipinjam++; break;
        case 1: selesai++; break;
        case 2: terlambat++; break;
      }
    }
  }
%>

<canvas id="trxBarChart" class="w-100 h-100"></canvas>
<script src="<%= request.getContextPath() %>/_themes/vendor/chart.js/Chart.min.js"></script>
<script>
  const ctx = document.getElementById('trxBarChart').getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Dipinjam', 'Selesai', 'Terlambat'],
      datasets: [{
        label: 'Statistik Peminjaman',
        data: [<%= dipinjam %>, <%= selesai %>, <%= terlambat %>],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(54, 162, 235, 0.2)'
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(54, 162, 235, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  });
</script>
