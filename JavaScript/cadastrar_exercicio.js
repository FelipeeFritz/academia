 const addButton = document.querySelector('.adicionar');
  const saveButton = document.querySelector('.salvar');
  const tableBody = document.querySelector('tbody');
  let editMode = false;

  addButton.addEventListener('click', addExercise);
  saveButton.addEventListener('click', saveChanges);

  function addExercise() {
    const newExerciseRow = document.createElement('tr');
    newExerciseRow.innerHTML = `
      <td contenteditable="true"></td>
      <td contenteditable="true" class="numeric"></td>
      <td contenteditable="true" class="numeric"></td>
      <td contenteditable="true" class="numeric carga"></td>
      <td contenteditable="true" class="tipo-treino"></td>
      <td>
        <button class="editar">Editar</button>
        <button class="excluir">Excluir</button>
      </td>
    `;
    tableBody.appendChild(newExerciseRow);
    const editButton = newExerciseRow.querySelector('.editar');
    const deleteButton = newExerciseRow.querySelector('.excluir');
    editButton.addEventListener('click', toggleEditMode);
    deleteButton.addEventListener('click', deleteExercise);
  }

  function saveChanges() {
    const exerciseData = [];
    const exerciseRows = tableBody.querySelectorAll('tr');
    exerciseRows.forEach(row => {
      const cells = row.querySelectorAll('td');
      const exercise = {
        aparelho: cells[0].innerText.trim(),
        serie: cells[1].innerText.trim(),
        repeticao: cells[2].innerText.trim(),
        carga: cells[3].innerText.trim(),
        tipo_treino: cells[4].innerText.trim()
      };
      exerciseData.push(exercise);
    });

    const xhr = new XMLHttpRequest();
    const url = 'Php/cadastrar_exercicio.php'; // Caminho para o script PHP

    xhr.open('POST', url, true);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        alert(xhr.responseText);
      }
    };

    const jsonData = JSON.stringify(exerciseData);
    xhr.send(jsonData);
  }

  function toggleEditMode() {
    if (!editMode) {
      const exerciseRows = tableBody.querySelectorAll('tr');
      exerciseRows.forEach(row => {
        const cells = row.querySelectorAll('td');
        cells.forEach(cell => {
          cell.setAttribute('contenteditable', 'true');
        });
      });
      editMode = true;
      saveButton.textContent = 'Concluído';
    } else {
      const exerciseRows = tableBody.querySelectorAll('tr');
      exerciseRows.forEach(row => {
        const cells = row.querySelectorAll('td');
        cells.forEach(cell => {
          cell.removeAttribute('contenteditable');
        });
      });
      editMode = false;
      saveButton.textContent = 'Salvar alterações';
    }
  }

  function deleteExercise(event) {
    const row = event.target.parentNode.parentNode;
    row.parentNode.removeChild(row);
  }