	window.addEventListener('DOMContentLoaded', (event) => {
		fetchData();
	});

	function fetchData() {
		fetch('Php/controle_pagamento.php')
			.then(response => {
				if (!response.ok) {
					throw new Error('Erro na resposta da solicitação: ' + response.status);
				}
				return response.json();
			})
			.then(data => {
				const table = document.getElementById('paymentTable');
				const tbody = table.getElementsByTagName('tbody')[0];
				let totalValue = 0;

				data.forEach(payment => {
					const { aluno, plano, valor, vencimento, status } = payment;

					const row = document.createElement('tr');
					const alunoCell = document.createElement('td');
					const planoCell = document.createElement('td');
					const valorCell = document.createElement('td');
					const vencimentoCell = document.createElement('td');
					const statusCell = document.createElement('td');

					alunoCell.textContent = aluno;
					planoCell.textContent = plano;
					valorCell.textContent = 'R$' + parseFloat(valor).toFixed(2);
					vencimentoCell.textContent = vencimento;
					statusCell.textContent = status;

					row.appendChild(alunoCell);
					row.appendChild(planoCell);
					row.appendChild(valorCell);
					row.appendChild(vencimentoCell);
					row.appendChild(statusCell);

					tbody.appendChild(row);

					const numericValue = parseFloat(valor);
					if (!isNaN(numericValue)) {
						totalValue += numericValue;
						document.getElementById('totalValue').innerText = 'Valor Total: R$' + totalValue.toFixed(2);
					}
				});
			})
			.catch(error => {
				console.error('Ocorreu um erro:', error);
			});
	}