    var monthNames = [
      "Jan", "Fev", "Mar",
      "Abr", "Mai", "Jun", "Jul",
      "Ago", "Set", "Out",
      "Nov", "Dez"
    ];

    var currentDate = new Date();
    var currentMonth = currentDate.getMonth();
    var currentYear = currentDate.getFullYear();

    function renderCalendar() {
      var calendarBody = document.getElementById("calendarBody");
      calendarBody.innerHTML = "";

      var firstDay = new Date(currentYear, currentMonth, 1);
      var lastDay = new Date(currentYear, currentMonth + 1, 0);

      document.getElementById("monthYear").innerHTML = monthNames[currentMonth] + " " + currentYear;

      var date = 1;
      for (var i = 0; i < 6; i++) {
        var row = document.createElement("tr");

        for (var j = 0; j < 7; j++) {
          if (i === 0 && j < firstDay.getDay()) {
            var cell = document.createElement("td");
            var cellText = document.createTextNode("");
            cell.appendChild(cellText);
            row.appendChild(cell);
          } else if (date > lastDay.getDate()) {
            break;
          } else {
            var cell = document.createElement("td");
            var cellText = document.createTextNode(date);
            if (date === currentDate.getDate() && currentMonth === currentDate.getMonth() && currentYear === currentDate.getFullYear()) {
              cell.style.fontWeight = "bold";
            }
            cell.appendChild(cellText);
            row.appendChild(cell);
            date++;
          }
        }
        calendarBody.appendChild(row);
      }
    }

    function previousMonth() {
      currentMonth--;
      if (currentMonth < 0) {
        currentMonth = 11;
        currentYear--;
      }
      renderCalendar();
    }

    function nextMonth() {
      currentMonth++;
      if (currentMonth > 11) {
        currentMonth = 0;
        currentYear++;
      }
      renderCalendar();
    }

    renderCalendar();