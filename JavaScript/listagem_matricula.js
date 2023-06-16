 function filterTable() {
    var inputName = document.getElementById("nameInput");
    var filterName = inputName.value.toUpperCase();
    var table = document.getElementsByTagName("table")[0];
    var rows = table.getElementsByTagName("tr");

    for (var i = 1; i < rows.length; i++) {
        var matricula = rows[i].getElementsByTagName("td")[0].textContent.toUpperCase();
        var nome = rows[i].getElementsByTagName("td")[1].textContent.toUpperCase();

        if (matricula.indexOf(filterName) > -1 || nome.indexOf(filterName) > -1 || filterName == "") {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}


   function fetchRegistros() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                var registros = JSON.parse(this.responseText);

                var tableBody = document.getElementById("tableBody");
                tableBody.innerHTML = "";

                registros.forEach(function(registro) {
                    var row = document.createElement("tr");

                    var matriculaCell = document.createElement("td");
                    matriculaCell.textContent = registro.matricula;
                    row.appendChild(matriculaCell);

                    var nomeCell = document.createElement("td");
                    nomeCell.textContent = registro.nome;
                    row.appendChild(nomeCell);

                    var emailCell = document.createElement("td");
                    emailCell.textContent = registro.email;
                    row.appendChild(emailCell);

                    var telefoneCell = document.createElement("td");
                    telefoneCell.textContent = registro.telefone;
                    row.appendChild(telefoneCell);

                    tableBody.appendChild(row);
                });
            }
        };
        xhttp.open("GET", "Php/listagem_matricula.php", true);
        xhttp.send();
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
    doc.autoTable({ html: '#myTable' });
    doc.save("registros.pdf");
}

fetchRegistros();
