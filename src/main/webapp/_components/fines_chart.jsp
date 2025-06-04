<%@ page import="com.tugas.perpus.controller.FineController" %>
<%@ page import="com.tugas.perpus.model.Fine" %>
<%@ page import="java.util.List" %>

<%
  FineController fineController = new FineController();
  List<Fine> finesList = fineController.getFinesFromDatabase(null);

  int selesai = 0;
  int belum = 0;

  if (finesList != null) {
    for (Fine fine : finesList) {
      if (fine.getStatus() == 1) {
        selesai++;
      } else {
        belum++;
      }
    }
  }
%>

<canvas id="finesPieChart" class="w-100 h-100"></canvas>
<script src="<%= request.getContextPath() %>/_themes/vendor/chart.js/Chart.min.js"></script>
<script>
  const pieCtx = document.getElementById('finesPieChart').getContext('2d');
  new Chart(pieCtx, {
    type: 'pie',
    data: {
      labels: ['Selesai', 'Belum Selesai'],
      datasets: [{
        label: 'Jumlah Denda',
        data: [<%= selesai %>, <%= belum %>],
        backgroundColor: [
          'rgba(75, 192, 192, 0.7)',
          'rgba(255, 99, 132, 0.7)'
        ],
        borderColor: [
          'rgba(75, 192, 192, 1)',
          'rgba(255, 99, 132, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      plugins: {
        legend: {
          display: true,
          position: 'bottom'
        }
      }
    }
  });
</script>
