// Adiciona um evento de clique no botão de agendamento
var agendarBtn = document.querySelector('button[type="submit"]');
agendarBtn.addEventListener('click', function (event) {
  event.preventDefault(); // Evita o envio do formulário normalmente

  // Obtém todos os checkboxes da tabela
  var checkboxes = document.querySelectorAll('input[type="checkbox"]');
  // Cria uma variável booleana para verificar se o usuário selecionou um horário
  var selecionouHorario = false;

  // Percorre todos os checkboxes e verifica se o usuário selecionou um horário
  checkboxes.forEach(function (checkbox) {
    if (checkbox.checked) {
      selecionouHorario = true;
      return;
    }
  });

  // Verifica se o usuário selecionou algum horário
  if (!selecionouHorario) {
    alert('Por favor, selecione um horário.');
    return;
  }

  // Envie o formulário
  var form = document.querySelector('form');
  form.submit();

  // Exibe a mensagem de sucesso após o agendamento
  alert('Agendamento realizado com sucesso! Por favor, confira o email de confirmação.');
});
