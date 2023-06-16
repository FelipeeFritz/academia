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
        xhr.open('GET', 'Php/minha_avaliacao.php', true);
        xhr.send();
    }

    function exibirDados(dados) {
        var tabela = document.getElementById('tabelaRegistros');

        for (var i = 0; i < dados.length; i++) {
            var nome = dados[i].nome;
            var horario = dados[i].horario;
            var segunda = dados[i].segunda;
            var terca = dados[i].terca;
            var quarta = dados[i].quarta;
            var quinta = dados[i].quinta;
            var sexta = dados[i].sexta;
            var sabado = dados[i].sabado;
            var idAgendAvaliacao = dados[i].idAgendAvaliacao;

            var row = tabela.insertRow();
            row.dataset.idagendavaliacao = idAgendAvaliacao;
            var cellNome = row.insertCell();
            var cellHorario = row.insertCell();
            var cellSegunda = row.insertCell();
            var cellTerca = row.insertCell();
            var cellQuarta = row.insertCell();
            var cellQuinta = row.insertCell();
            var cellSexta = row.insertCell();
            var cellSabado = row.insertCell();
            var cellExcluir = row.insertCell();

            cellNome.innerHTML = nome;
            cellHorario.innerHTML = horario;
            cellSegunda.innerHTML = segunda;
            cellTerca.innerHTML = terca;
            cellQuarta.innerHTML = quarta;
            cellQuinta.innerHTML = quinta;
            cellSexta.innerHTML = sexta;
            cellSabado.innerHTML = sabado;

            row.addEventListener('click', function() {
                this.classList.toggle('selecionado');
                linhasSelecionadas.push(this);
            });
        }
    }