var linhasSelecionadas = [];

function carregarDados() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var dados = JSON.parse(xhr.responseText);
                exibirDados(dados);
            } else {
                console.log('Erro na solicitação: ' + xhr.status);
            }
        }
    };
    xhr.open('GET', 'Php/minha_agenda.php', true);
    xhr.send();
}

function exibirDados(dados) {
    var tabela = document.getElementById('tabelaRegistros');

    for (var i = 0; i < dados.length; i++) {
        var row = tabela.insertRow();
        row.dataset.idcontroleFrequencia = dados[i].idcontrole_frequencia; // adicionando o ID do registro como um atributo de data

        row.insertCell().innerHTML = dados[i].horario;
        row.insertCell().innerHTML = dados[i].segunda;
        row.insertCell().innerHTML = dados[i].terca;
        row.insertCell().innerHTML = dados[i].quarta;
        row.insertCell().innerHTML = dados[i].quinta;
        row.insertCell().innerHTML = dados[i].sexta;

        row.addEventListener('click', function() {
            this.classList.toggle('selecionado');
        });
    }
}
