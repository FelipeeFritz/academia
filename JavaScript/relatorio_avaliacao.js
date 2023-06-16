  $(document).ready(function() {
    $.ajax({
        url: 'Php/relatorio_avaliacao.php',
        type: 'GET',
        success: function(data) {
            let html = '';
            let months = ['Atual', 'Mês anterior', 'Antepenultimo'];  // Adiciona os meses

            for (let i = 0; i < data.length; i++) {
                let evaluation = data[i];
                let card = '<div class="card">';
                card += '<h2 class="card-title">Avaliação Física - ' + months[i] + '</h2>';  // Adiciona o mês ao título
                card += '<p><strong>Braço:</strong> ' + evaluation.braco + ' cm</p>';
                card += '<p><strong>Antebraço:</strong> ' + evaluation.antebraco + ' cm</p>';
                card += '<p><strong>Peito:</strong> ' + evaluation.peito + ' cm</p>';
                card += '<p><strong>Cintura:</strong> ' + evaluation.cintura + ' cm</p>';
                card += '<p><strong>Quadril:</strong> ' + evaluation.quadril + ' cm</p>';
                card += '<p><strong>Coxa:</strong> ' + evaluation.coxa + ' cm</p>';
                card += '<p><strong>Panturrilha:</strong> ' + evaluation.panturrilha + ' cm</p>';
                card += '<p><strong>Altura:</strong> ' + evaluation.altura + ' cm</p>';
                card += '<p><strong>Peso:</strong> ' + evaluation.peso + ' kg</p>';
                card += '</div>';
                html += card;
            }
            $('#results').html(html);
        },
        error: function() {
            $('#results').html('Ocorreu um erro ao buscar os dados.');
        }
    });
});

