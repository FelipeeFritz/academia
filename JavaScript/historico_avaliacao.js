       function obterDados() {
            fetch('Php/historico_avaliacao.php')
                .then(function(response) {
                    return response.text();
                })
                .then(function(data) {
                    exibirDados(data);
                })
                .catch(function(error) {
                    console.log('Erro na requisição:', error);
                });
        }

        function exibirDados(data) {
            var tabela = document.getElementById('tabelaRegistros');
            tabela.innerHTML = ''; // Limpa a tabela

            tabela.insertAdjacentHTML('beforeend', data);
        }

        document.addEventListener("DOMContentLoaded", obterDados);