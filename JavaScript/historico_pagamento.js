window.addEventListener('DOMContentLoaded', (event) => {
  fetchPayments();
});

function fetchPayments() {
  fetch('Php/historico_pagamento.php')
    .then(response => response.json())
    .then(data => {
      const table = document.getElementById('paymentTable');
      let totalValue = 0;

      data.forEach(payment => {
        const row = table.insertRow();

        const nameCell = row.insertCell();
        nameCell.textContent = payment.nome;

        const planCell = row.insertCell();
        planCell.textContent = payment.plano;

        const dateCell = row.insertCell();
        dateCell.textContent = payment.data_pagamento;

        const valueCell = row.insertCell();
        valueCell.textContent = payment.valor;

        const statusCell = row.insertCell();
        statusCell.textContent = payment.status;

        const numericValue = parseFloat(payment.valor);
        if (!isNaN(numericValue)) {
          totalValue += numericValue;
        }

        if (payment.status === 'pago') {
          statusCell.classList.add('status-pago');
        } else if (payment.status === 'atrasado') {
          statusCell.classList.add('status-atrasado');
        }
      });

      document.getElementById('totalValue').textContent = `Valor Total: R$${totalValue.toFixed(2)}`;

      filterTable();
    })
    .catch(error => {
      console.error('Erro ao buscar os pagamentos:', error);
    });
}


  function filterTable() {
    const monthSelect = document.getElementById('monthSelect').value;
    const yearSelect = document.getElementById('yearSelect').value;
    const statusSelect = document.getElementById('statusSelect').value;
    const nameInput = document.getElementById('nameInput').value.toLowerCase();
    const table = document.getElementById('paymentTable');
    const tr = table.getElementsByTagName('tr');

    let totalValue = 0;

    for (let i = 1; i < tr.length; i++) { // Começa do índice 1 para ignorar o cabeçalho da tabela
      const tdName = tr[i].getElementsByTagName('td')[0]; // Coluna de Nome
      const tdDate = tr[i].getElementsByTagName('td')[2]; // Coluna de Data de Pagamento
      const tdValue = tr[i].getElementsByTagName('td')[3]; // Coluna de Valor
      const tdStatus = tr[i].getElementsByTagName('td')[4]; // Coluna de Status

      if (tdName && tdDate && tdValue && tdStatus) {
        const nameValue = tdName.textContent || tdName.innerText;
        const dateValue = tdDate.textContent || tdDate.innerText;
        const value = tdValue.textContent || tdValue.innerText;
        const statusValue = tdStatus.textContent || tdStatus.innerText;

        const displayByName = nameValue.toLowerCase().includes(nameInput);
        const displayByMonth = dateValue.includes(monthSelect) || !monthSelect;
        const displayByYear = dateValue.includes(yearSelect) || !yearSelect;
        const displayByStatus = statusValue.toLowerCase().includes(statusSelect) || !statusSelect;

        tr[i].style.display = displayByName && displayByMonth && displayByYear && displayByStatus ? '' : 'none';

        if (displayByName && displayByMonth && displayByYear && displayByStatus) {
          const numericValue = parseFloat(value.replace(/[^0-9.-]+/g, ''));
          if (!isNaN(numericValue)) {
            totalValue += numericValue;
          }
        }
      }
    }

    document.getElementById('totalValue').textContent = `Valor Total: R$${totalValue.toFixed(2)}`;
  }
  
      function exportToCSV() {
        var table = document.getElementsByTagName("table")[0];
        var rows = table.getElementsByTagName("tr");

        var csvContent = "data:text/csv;charset=utf-8,";

        for (var i = 0; i < rows.length; i++) {
            var rowData = [];
            var cells = rows[i].getElementsByTagName("td");

            for (var j = 0; j < cells.length; j++) {
                rowData.push(cells[j].textContent);
            }

            csvContent += rowData.join(",") + "\n";
        }

        var encodedURI = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedURI);
        link.setAttribute("download", "registros.csv");
        document.body.appendChild(link);
        link.click();
    }
function exportToPDF() {
    var doc = new window.jspdf.jsPDF();
    doc.autoTable({ html: '#paymentTable' });
    doc.save("registros.pdf");
}