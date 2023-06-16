        // Função para carregar a tabela de treino usando AJAX
        $(document).ready(function(){
            $.ajax({
                url: 'Php/ficha_treino.php', // Substitua pelo nome do seu arquivo PHP
                type: 'GET',
                success: function(response){
                    $('#tabela-treino').html(response);
                }
            });
        });